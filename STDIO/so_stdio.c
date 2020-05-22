#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>
#include "so_stdio.h"

#define BUFLEN 4096

struct _so_file {
	int last;
	int fd;
	int flags;
	char *buffer;
	int crt;
	int bytes;
	int eof;
	int ptr;
	int err;
	int child;
};

FUNC_DECL_PREFIX SO_FILE *so_fopen(const char *pathname, const char *mode)
{
	int fd, flags;

	if (pathname == NULL)
		return NULL;

	if (mode == NULL)
		return NULL;

	if (!strcmp(mode, "r"))
		flags = O_RDONLY;

	else if (!strcmp(mode, "r+"))
		flags = O_RDWR;

	else if (!strcmp(mode, "w"))
		flags = O_WRONLY | O_TRUNC | O_CREAT;

	else if (!strcmp(mode, "w+"))
		flags = O_RDWR | O_TRUNC | O_CREAT;

	else if (!strcmp(mode, "a"))
		flags = O_APPEND | O_WRONLY;

	else if (!strcmp(mode, "a+"))
		flags = O_APPEND | O_CREAT | O_RDWR;
	else
		return NULL;

	SO_FILE *stream = (SO_FILE *) calloc(1, sizeof(SO_FILE));

	fd = open(pathname, flags);
	stream->flags = flags;
	stream->fd = fd;
	stream->buffer = (char *) calloc(BUFLEN, sizeof(char));
	stream->crt = 0;
	stream->bytes = 0;

	stream->err = 0;
	stream->ptr = 0;

	if (fd < 0) {
		free(stream->buffer);
		free(stream);
		return NULL;
	}

	return stream;
}

FUNC_DECL_PREFIX int so_fclose(SO_FILE *stream)
{
	int ret = 0, rc;

	if (stream != NULL) {
		ret = so_fflush(stream);
		rc = close(stream->fd);
		if (rc < 0) {
			stream->err = 1;
			ret = SO_EOF;
		}
		if (ret < 0) {
			stream->err = 1;
			ret = SO_EOF;
		}
		free(stream->buffer);
		free(stream);
	}

	return ret;
}

FUNC_DECL_PREFIX int so_fileno(SO_FILE *stream)
{
	if (stream != NULL)
		return stream->fd;
	return -1;
}



FUNC_DECL_PREFIX int so_fflush(SO_FILE *stream)
{
	stream->crt = 0;
	if (!stream->last) {
		stream->bytes = 0;
		return 0;
	}
	while (stream->bytes) {
		int rc = write(stream->fd,
				stream->buffer + stream->crt,
				stream->bytes);

		if (rc < 0) {
			stream->err = 1;
			return SO_EOF;
		}
		stream->bytes -= rc;
		stream->crt += rc;
	}
	stream->last = 0;
	stream->crt = 0;

	return 0;
}

FUNC_DECL_PREFIX int so_fseek(SO_FILE *stream, long offset, int whence)
{
	so_fflush(stream);
	stream->ptr = lseek(stream->fd, offset, whence);

	if (stream->ptr >= 0)
		stream->eof = 0;

	return  stream->ptr >= 0 ? 0 : -1;

}

FUNC_DECL_PREFIX long so_ftell(SO_FILE *stream)
{
	return stream->ptr;
}

FUNC_DECL_PREFIX
size_t so_fread(void *ptr, size_t size, size_t nmemb, SO_FILE *stream)
{
	int rc;
	int offset = 0;
	int size1 = size * nmemb;
	int size2;

	if (stream->last)
		so_fflush(stream);

	if (stream->eof)
		return 0;

	while (size1) {
		if (stream->bytes && !stream->last) {
			size2 = stream->bytes < size1 ? stream->bytes : size1;
			memcpy(ptr + offset,
				stream->buffer + stream->crt,
				size2);
			stream->bytes -= size2;
			stream->crt = !stream->bytes ? 0 : stream->crt + size2;
			size1 -= size2;
			offset += size2;
		} else {
			stream->last = 0;
			size2 = size1 < BUFLEN ? size1 : BUFLEN;
			rc = read(stream->fd, stream->buffer, BUFLEN);

			if (rc < 0) {
				stream->err = 1;
				return 0;
			}

			if (!rc) {
				stream->eof = 1;
				return offset;
			}

			if (rc < size2)
				size2 = rc;

			stream->bytes = rc;
			memcpy(ptr + offset, stream->buffer, size2);
			stream->bytes = rc - size2;
			stream->crt = !stream->bytes ? 0 : size2;

			offset += size2;
			size1 -= size2;
		}
	}
	stream->ptr += offset;
	return offset / size;
}

FUNC_DECL_PREFIX
size_t so_fwrite(const void *ptr, size_t size, size_t nmemb, SO_FILE *stream)
{
	if (!stream->last) {
		so_fflush(stream);
		stream->last = 1;
	}

	int offset = 0;
	int size1 = size * nmemb;
	int size2 = size1 > BUFLEN ? BUFLEN : size1;

	while (size1) {
		size2 = BUFLEN - stream->bytes < size1 ?
			BUFLEN - stream->bytes : size1;
		memcpy(stream->buffer + stream->crt, ptr + offset, size2);
		size1 -= size2;
		offset += size2;
		stream->bytes += size2;
		stream->crt += size2;
		if (stream->bytes == BUFLEN) {
			so_fflush(stream);
			stream->last = 1;
		}
	}
	stream->ptr += offset;
	return offset / size;
}

FUNC_DECL_PREFIX
int so_fgetc(SO_FILE *stream)
{
	int ret = 0;

	if (stream != NULL) {
		while (!stream->bytes) {
			ret = read(stream->fd, stream->buffer, BUFLEN);
			stream->crt = 0;

			if (ret < 0) {
				stream->err = 1;
				return -1;
			}
			if (!ret) {
				stream->eof = -1;
				return -1;
			}
			stream->bytes = ret;
		}

		stream->bytes--;
		stream->crt++;
		return (int) stream->buffer[stream->crt - 1];
	}

	return SO_EOF;
}

FUNC_DECL_PREFIX int so_fputc(int c, SO_FILE *stream)
{
	if (stream->bytes == BUFLEN) {
		so_fflush(stream);
		stream->bytes = 0;
		stream->crt = 0;
	}

	stream->buffer[stream->crt] = (char) c;
	stream->crt++;
	stream->bytes++;
	stream->last = 1;
	return c;
}

FUNC_DECL_PREFIX int so_feof(SO_FILE *stream)
{
	return stream->eof;
}

FUNC_DECL_PREFIX int so_ferror(SO_FILE *stream)
{
	return stream->err;
}

FUNC_DECL_PREFIX
SO_FILE *so_popen(const char *command, const char *type)
{

	int pid = -1;
	int pip[2];

	pipe(pip);

	SO_FILE *stream = (SO_FILE *) calloc(1, sizeof(SO_FILE));

	stream->buffer = (char *) calloc(BUFLEN, sizeof(char));


	pid = fork();

	if (pid == -1) {
		free(stream->buffer);
		free(stream);
		return NULL;
	}


	if (pid) {
		if (!strcmp(type, "r")) {
			stream->fd = pip[0];
			close(pip[1]);
		} else if (!strcmp(type, "w")) {
			stream->fd = pip[1];
			close(pip[0]);
		}
		stream->child = pid;

		return stream;
	}

	if (!strcmp(type, "r") && pip[1] != STDOUT_FILENO) {
		dup2(pip[1], STDOUT_FILENO);
		close(pip[1]);
		pip[1] = STDOUT_FILENO;
	} else if (!strcmp(type, "w") && pip[0] != STDIN_FILENO) {
		dup2(pip[0], STDIN_FILENO);
		close(pip[0]);
	}

	if (!strcmp(type, "r"))
		close(pip[0]);
	else
		close(pip[1]);
	execl("/bin/sh", "sh", "-c", command, NULL);

	return NULL;
}

FUNC_DECL_PREFIX int so_pclose(SO_FILE *stream)
{
	int rc, ret, ret2, options = 0;

	int kid = stream->child;

	ret = -1;
	rc = so_fclose(stream);

	if (rc < 0)
		return -1;

	rc = waitpid(kid, &ret, options);

	if (rc < 0)
		return -1;
	return ret;
}
