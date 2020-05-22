BALASESCU IONUT MARIUS 322CD

   Pentru realizarea acestei teme am folosit urmatoarele functii:  
	- functia ecg_function(p1,p2), care primeste un semnal ca 
   parametru(+1 parametru care specifica tipul semnalului) si     
   intoarce indexul persoanei caruia i s-a evaluat semnalul ecg,   
   daca se face match. Functia apeleaza la randul ei mai multe    
   functii:                                                        
      -o functie clean_matrix()care creeaza o baza de date cu 90   
   inregistrari sub forma unei matrice cu liniile umplute cu       
   ajutorul algoritmului fft(in functia C_ARRAY()'create array'.  
   Am creat un vector de caracterizare pentru fiecare semnal clean 
   din baza de date.                                               
      -o functie care filtreaza semnalul(daca este nevoie) cu      
   functiile matlab highpass() si lowpass. Acestor 2 functii le-am 
   dat ca argument semnalul, cate o referinta(aleasa convenabil   
   pentru baza noastra de date) si frecventa de 500 Hz.            
	Tot in functia ecg_function, am creat un vector de caracte- 
   rizare cu functia C_ARRAY() pentru semnalul clean dat ca        
   parametru sau, in functie de caz, pentru semnalul filtrat.     
       Am cautat cea mai buna asemanare intre semnale cu norma    
   euclidiana si am returnat indexul respectiv.                    
      Pentru testare am creat un checker(un script in matlab)   
  care citeste baza de date si imi verifica pentru fiecare fisier 
  daca id-ul returnat de functia principala ecg este acelasi cu cel
  al persoanei careia i s-a citit ecg-ul.  			    
     Citirea fisierelor.m se face din calea ECG_DB/Person-x/rec_1.m













  