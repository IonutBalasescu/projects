%BALASESCU IONUT MARIUS 322CD
function AV = clean_matrix()
    %construiesc stringuri pentru a citi fisierele
    string1 = 'ECG-DB/Person_';
    string2 = '/rec_1m.mat';
    string3 = '/rec_2m.mat';
    for i = 1 : 90
        chr = int2str(i);
        if i < 10
            s1 = strcat(string1,'0', chr, string2);
        else
            s1 = strcat(string1, chr, string2);
        end
        if exist(s1, 'file') == 2
            a = load(s1) ;
            x = a.val(2, :);   %iau doar semnalul clean
            y = C_ARRAY(x);    %creez vectorul de caract.
            AV(i,:) = y;       %il introduc in matrice (Baza de date)
        end
end