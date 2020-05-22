%B?L??ESCU IONU?-MARIUS 322CD

t = -10 : 0.01 : 10 ;

u = cos(100*t + pi/3);
subplot(4, 1, 1);
plot(t, u);
K = 20;
t2 = 0 : 0.01 : 10;
for i = 0 : 2
    K = 20 + i * 40;
    h = exp(-K*t);
    y = conv(u, h, 'same');
    subplot(4, 1, i + 2);
    plot(t, y);
end
%Se analizeaza doua domenii:unul la stanga lui 0 si unul la dreapta 
%lui 0, in ceea ce priveste timpul
%La valori mai mici decat 0, semnalul este foarte instabil(din cauza
%puterii exponentialei), deci cu cat creste K, semnalul scapa de sub
%control(amplitudinea creste exponential(functie exponentiala :D) si
%defazajul este foarte mic
%Pe domeniul pozitiv lucrurile se linistesc; cu cat K este ales mai mare,
%cu atat mai usor se stabilizeaza sistemul. Amplitudinea este amortizata
%complet(aproape instant in toate cazurile).