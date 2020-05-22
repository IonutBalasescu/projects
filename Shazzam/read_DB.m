%BALASESCU IONUT MARIUS 322CD
%cod duplicat;m-am gandit sa nu extind checkerul pe 2 scripturi
string1 = 'ECG-DB/Person_';
string2 = '/rec_1m.mat';
string3 = '/rec_2m.mat';
c = 0;
%verificarea semnalelor clean
for i = 1 : 90          %la fel ca in clean_matrix
    chr = int2str(i);
    if i < 10
        s = strcat(string1,'0', chr, string2);
    else
        s = strcat(string1, chr, string2);
    end
    a = load(s) ;
    x = a.val(2, :);
    index = ecg_function(x, 0);     %iau indexul presupus si il compar cu i
    test = strcat('Test', chr, ':');
    disp(test);
    if index == i
       disp('GOOD MATCH');
       c = c + 1;
    else
        disp('BAD MATCH');
    end
end
%verificarea semnalelor raw
c1 = 0;
for i = 1 : 90
    chr = int2str(i);
    if i < 10
        s = strcat(string1,'0', chr, string2);
    else
        s = strcat(string1, chr, string2);
    end
    a = load(s) ;
    x = a.val(1, :);
    index = ecg_function(x, 1);
    test = strcat('Test', chr, ':');
    disp(test);
    if index == i
       disp('GOOD MATCH');
       c1 = c1 + 1;
    else
        disp('BAD MATCH');
    end
end
%afisarea rezultatelor
chr = int2str(c);
test = strcat('Clean Signals Matched: ', chr);
disp(test);
chr = int2str(c1);
test = strcat('Raw Signals Matched: ', chr);
disp(test);