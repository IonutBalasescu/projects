%BALASESCU IONUT MARIUS 322CD
function signal = filtrate_signal(input_signal)
    %aplic doua functii din matlab pentru a filtra semnalele
    %valorile au fost alese in asa fel incat sa se acopere o banda
    %de lucru cat mai favorabila pentru semnalele din baza de date
    signal = highpass(input_signal,0.7501 , 500);
    signal = lowpass(signal, 2.901 , 500);
end