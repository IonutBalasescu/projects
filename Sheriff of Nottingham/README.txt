BALASESCU IONUT MARIUS 322CD

			SHERIFF OF NOTTINGHAM



In implementarea boardgame-ului am folosit urmatoarele clase:  

         + O clasa ASSETS, care descrie tipul unui bun, fie legal sau ilegal, cu 
campuri pentru id, legalitate, profit, penalty si o lista de bunuri numita
'bonus', in care sa retin obiectele pe care le va primi un comerciant 
in urma sosirii cu bunuri ilegale la taraba. Clasa contine un constructor
 care va initializa un obiectul declarat cu proprietatile aferente id-ului 
care este specificat ca parametru si metode de get pentru toate campurile;
          +O superclasa BasicPlayer, care prezinta generalitati ale claselor de
Playeri. Aceasta are  campurile : scor, mita, tip de jucator, status serif si niste 
liste de bunuri pentru *cartile din mana* + camp cu numarului de carti din
mana, *carti din sac* + camp cu numarul de carti din sac si *carti de pe 
taraba*. In clasa aceasta am implementat cele mai multe metode si anume :
pentru strategia de baza : o metoda merchantStrategy, care dupa caz apeleaza
alte metode: metoda care sa adauge un bun ilegal(utila si la greedy) si metoda
care adauga doar bunuri legale de cea mai mare frecventa(utila pentru toate
clasele de playeri). Pentru inceput, am creeat o lista cu elementele legale din
mana si in functie de numarul lor(0/!0),am aplicat una dintre cele 2 metodele;
Pentru cazul in care jucatorul basic era serif, se controla sacul cu functia 
sheriffCheckBag, pe care am facut-o sa imi returneze pachetul de carti(in cazul
in care se gaseste un bun nedeclarat, acel bun se confisca si se adauga in lista
cu carti la sfarsit.
         Tot in BasicPlayer am implementat metode pentru a completa cartile din
mana, pentru a adauga bunuri pe taraba, pentru a calcula profitul de pe taraba
si pentru a da bonusurile de queen si king de la sfarsitul jocului.
	+Doua subclase BribedPlayer si GreedyPlayer ale caror metode
de strategie si serif fac override pe metodele din BasicPlayer, iar in cazul
in care trebuie sa se comporte ca BasicPlayer folosesc metodele superclasei
prin keyword-ul 'super'. Clasa GreedyPlayer contine un camp separat de restul 
claselor, care retine paritatea rundei de strategie. Totodata, este singura clasa
de jucatori care este implementata sa accepte mita. Daca exista mita in sac, 
seriful greedy il va lasa pe jucatorul care a dat mita sa puna bunuri ilegale pe 
taraba. Daca nu este mita in sac se apeleaza metoda superclasei.
	In clasa main am realizat desfasurarea rundelor: am impartit cartile,
le-am completat  dupa fiecare runda si am aplicat metodele de strategie si
de serif. Dupa aceea am apelat funcia care da profitul de pe taraba si am cautat
sa dau bonusuri de king si queen celor cu cele mai multe bunuri legale de acelasi tip.
Am facut totalul si am afisat descrescator.
Am lasat si comentarii explicite in cod. 