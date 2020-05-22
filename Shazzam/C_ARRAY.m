%BALASESCU IONUT MARIUS 322CD
function a = C_ARRAY(input)
    %aplic fft pe datele de intrare si pun amplitudinile
    %cele mai mari, cu pulsatiile respective, in vectorul de caracterizare 
    x = fft(input);
    Fs = 500;
    T = 1/Fs;
    L = length(x);
    t = (0:L-1)*T;
    f = Fs*(0:(L/2))/L;
    P2 = abs(x/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    %plot(f,P1)
    %title("Amplitude Spectrum of S(t)")
    %xlabel("f (Hz)")
    %ylabel("|P1(f)|")
    %A e vector de amplitudini
    %B e vecotr de indecsi ai originalului P1
    [A, B] = sort(P1, 'descend');
    for j = 2 :2: 4
        a(j-1) = A(j/2);
        a(j) = f(B(j/2))*2*pi;
    end
end