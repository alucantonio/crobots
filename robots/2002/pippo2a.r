/*
 Pippo2a
 Andrea Creola
 Categoria: <500


 Tattica: il robot si porta al lato verticale piu' prossimo e
 da li comincia una oscillazione orizzionate in prossimita'
 dell'angolo adiacente.
 Dato che la funzione di sparo (che non ricordo da chi ho copiato, anche
 se ho dovuto aggiungere una funzione per ridurre lo spazio richiesto)
 mi ha preso troppo spazio, onde per cui non ho potuto cercare di capire
 se la partita era un 2x2 o 4x4.


 Toericamente dovevo mandare un'altro robot, ma all'ulitimo momento
 ho assemblato quasi per caso questo ed Š risultato migliore.


 Leggo dal regolamento che non si puo' spedire via posta, ricordo che
 per i primi tornei di crobots usavo questo mezzo di spedizione e li inviavo
 circa un mese prima dello scadere.


 Non ha molto nesso con il torneo, ma voglio ricordarvi che esiste sopra a
 Gargallo un parco (anche se sarebbe meglio chiamarla area pic-nic) atrezzata,
 si tratta di Chepoli, poco dopo si trova il mulino Ciotino che ora Š squarato.
 Sopra si puo' andare a Cavagliasche (frazione oramai disabitata) oppure  a Soliva
 frazione abitata nei giorni feriali da due persone (dimenticavo di dirvi che
 sono ue frazioni di Valduggia).


 Se qualcuno si sta chiedendo il motivo che mi spinge a scrivere questo:
 semplice, dato che la scheda tecnica Š troppo corta, ho aggiunto un po
 di particolari esterni e dato che un po di cultura.........


 Pubblicita':
   Trix: I biscottini per far crescere i vostri robot belli e sani:


*/
int rng,
    deg,  
    orng,
    odeg, 
    dir,
    un1;
main()
{
 
 un1=(loc_x()>500)*400;
 if(loc_y()>500) up(900);
 else dw(100);


 while(1)
 {
  sx(200+un1);
  dx(400+un1);
 }
 
}


up(xx)
 {
   while(loc_y()<xx) vs(90);
   stop();
 }
dw(xx)
 {
  while(loc_y()>xx) vs(270);
  stop();
 }
dx(xx)
 {
  while(loc_x()<xx) vs(00);
  stop();
 }
sx(xx)
 {
  while(loc_x()>xx) vs(180);
  stop();
 }


vs(xx)
 {
  drive(dir=xx,100);
  fuoco();
 }


stop()
 {
  drive(dir,0);
  while(speed()>50);/* Fire(0);*/
 }





fuoco() {
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=20,10));
    else if (orng=scan(deg+=40,10));
    else return deg+=41; 
    { 
        if (orng>850)  {return deg+=41;}
        if (!scan(deg+=354,6)) deg+=12; 
        if(scan(deg-6,2)) deg-=6; 
        else if(scan(deg+6,2)) deg+=6;
        fnd();
        if (orng=scan(odeg=deg,10)) 
        { 
           if(scan(deg-7,3)) deg-=7; 
           else if(scan(deg+7,3)) deg+=7;
           fnd(); 
           if (rng=scan(deg,10)) 
           { 
                cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12))); 
           } 
 
        } 
        else { 
                if (!(orng=scan(deg+=339,10))){  
                        if (!(orng=scan(deg+=41,10))) { 
                                if(!(orng=scan(deg+=21,10))) { 
                                        return deg+=41; 
                                } 
                        } 
                } 
                else if (!scan(deg+=354,6)) deg+=12;  
                return cannon (deg, 2*scan(deg,10)-orng);
        }
     } 
} 



fnd()
{
 if(scan(deg-4,1)) deg-=4;
 if(scan(deg+4,1)) deg+=4; 
 if(scan(deg-2,1)) deg-=2; 
 if(scan(deg+2,1)) deg+=2; 
}
