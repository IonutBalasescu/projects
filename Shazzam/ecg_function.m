%BALASESCU IONUT MARIUS 322CD
function [person_id] = ecg_function(input_signal, israw)
    %functia imi returneaza matricea de vectori caracteristici
    AX = clean_matrix();
    %daca semnalul e row, se filtreaza cu functia filtrate_signal
    %daca semnalul e curat se trece de aceasta linie
    if israw == 1
        input_signal = filtrate_signal(input_signal);
    end
    %aplic fft si creez vectorul caracteristic, pe care il stochez
    %in array si caut cea mai mica eroare
    array = C_ARRAY(input_signal);
    min = 10000;
    index = 0;
for i = 1 : 90
    if norm(AX(i,:) - array) < min 
        min = norm(AX(i,:) - array);
        index = i;
    end
end
    %returnez indexul persoanei a carui ecg l-am prelucrat
    %nu functioneaza pentru toate cazurile cu zgomot, dar trece de jumatate
    person_id = index;

end