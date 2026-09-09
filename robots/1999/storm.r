/*          
----------------------------------------STORM
                       di Marco e Luca Pranzo

------------------------------------RELEASE 2
ATTENZIONE:  Quello  che  stai  leggendo è la 
release 2 di Storm. L'unica differenza con la
versione  che ha partecipato  al  Torneo 1999 
sono   questi  commenti  di  giustificazione. 
Lettore ti starai chiedendo di cosa mi dovrei 
mai  giustificare.   Ebbene   sappi  che   la 
motivazione  della Release 2  è  legata  alla 
mancanza di commenti simpatici ed ironici che 
hanno  spesso  caratterizato  i  miei  robot.
Tanto  da  farmi  credere  che  Tu,  mi  stia 
leggendo mosso dalla ricerca di tali commenti
Oh Lettore,  se il tuo vero ed  unico scopo è 
divertirti allora fermati, non andare avanti.
Infatti  il  codice  che  seguirà,  oltre  ad 
essere scarsamente commentato (al solito),  è 
altamente compresso.  Per comprenderlo  avrai 
bisogno di tutta la tua arguzia unita ad  una 
buone  dose di fantasia,  oppure di  un  buon 
traduttore dal " CRobots-C <-> Ansi-C ".  
Un esempio chiarirà meglio la situazione :

CRobots-C
verticale = ( ((dir0+=90*orario)%(fine=180)) 
            > (centro=(inizio=0)) );

Ansi-C
dir0=dir0+90*orario;
fine=180;
centro=0;
inizio=0;
verticale=(dir0%180)>0;

Ancora qui,  oh mio Lettore?  Se proprio vuoi 
proseguire fallo a tuo rischio e pericolo. Io 
non mi riterrò  responsabile di  nessun danno 
permanente  o temporaneo,  fisico o  mentale, 
che  questo codice potrò arrecarti.  E tu non 
potrai  in  alcun  modo  addebitarmi le spese 
dell'intevento d'urgenza della Neuro. 

------------------------------------STRATEGIA
Storm si posiziona nell'angolo più vicino,  e 
comincia a pendolare preferibilmente verso un 
angolo vuoto.
Se viene colpito  e l'angolo  nella direzione 
in cui si sta dirigendo è vuoto allora cambia 
angolo.
Appena  si accorge  di essere rimasto  con un 
solo avversario parte per la straegia finale. 
Si  sposta  lungo  i  lati  e   se  l' angolo 
successivo è occupato  allora taglia lungo la
diagonale.

--------------------------------------TATTICA
La routine di fuoco è praticamente quella  di 
Tox.
Durante le frenate, per sfruttare al meglio i 
tempi morti,  Storm  esegue varie  operazioni 
tra cui anche il conta degli avversari.
Durante  il pendolamento  Storm  calcola  una 
correzione  sulla  direzione  per  accostarsi 
maggiormente alla parete in modo da diminuire 
la sua esposizione ai colpi dei nemici.

----------------------------------ARCHITETTURA
L'architettura di Storm è estremamente lineare
ed è riassumibile con:  
"Fino a che  non sei arrivato  a  destinazione
spara;  quando sei arrivato  decidi  la  nuova 
destinazione e riparti."
Questa struttura  permette la realizzazione di 
un  codice intrinsecamente senza procedure  ed 
indipendente dalla posizione.
*/

int
/* Selettori della Strategia */
 angolo,centro,inizio,fine,
/* Variabili Ausiliarie */
 menouno,meno800,meno150,
/* Variabili di Posizione */
 sys_nord,sys_est,
/* Variabili di Movimento */
 pos,verticale,max,qq,dir,dir0,posiz,
/* Variabili del Danno */ 
 dmg,odmg,
/* Variabili di Fuoco */
 rng,orng,deg,odeg,
/* Variabili per il conta */
 numero,sys_nen,orario,a,inc;    
 

main()
{ 
/* Impostazioni Iniziali */
 menouno-=(inizio=1);
 meno150-=(sys_nen=150);
 if (sys_est=(loc_x()>500)) {max=1; qq=850;}
 else {dir=180; max=menouno; qq-=150;}

/* Vai! */ 
 while( drive(dir,100) )
 {
   if (verticale) pos=max*loc_y();
   else pos=max*loc_x();

/* Fino a che non giunge a destinazione... */
   while(pos<=qq)
   {

/* Spara */
      if (orng=scan(deg,10))
      {
         if (!scan(deg+=355,5)) deg+=10;
         if (orng>770) {cannon(deg,orng);deg+=40;}
         else
         {
           if(scan(deg+355,1)) deg+=355;
           if(scan(deg+5  ,1)) deg+=5;
           if(scan(deg+357,1)) deg+=357;
           if(scan(deg+3  ,1)) deg+=3;
           if(scan(deg+359,1)) deg+=359;
           if(scan(deg+1  ,1)) deg+=1;       
           
           if (orng=scan(odeg=deg,5))
           {
               if(scan(deg+355,1)) deg+=355;
               if(scan(deg+5  ,1)) deg+=5;
               if(scan(deg+357,1)) deg+=357;
               if(scan(deg+3  ,1)) deg+=3;
               if(scan(deg+359,1)) deg+=359;
               if(scan(deg+1  ,1)) deg+=1;       

               if (rng=scan(deg,10))
               {
                   cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                          rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
               }
           }
         }
      }
      else
      {
         if (scan(deg+=339,10));
         else if (scan(deg+=42,10));
         else deg+=42;
      }
/* Calcola la posizione */
      if (verticale) pos=max*loc_y();
      else pos=max*loc_x();
   }

/* Frena nell... */
   drive(dir+180,0);

/* ...Angolo */
   if (angolo) 
   {

/* Conta i nemici */
     orng=750;
     if (orario) {a=dir0+157; inc=15;}
     else {a=dir0+203; inc=345;}
     if ( rng=scan(a+=inc,7) ) trovato();
     if ( rng=scan(a+=inc,7) ) trovato();
     if ( rng=scan(a+=inc,7) ) trovato();
     if ( rng=scan(a+=inc,7) ) trovato();
     if ( rng=scan(a+=inc,7) ) trovato();
     if ( rng=scan(a+=inc,7) ) trovato();
     if ( rng=scan(a+=inc,7) ) trovato();
     if ( rng=scan(a+=inc,7) ) trovato();

     if (numero) sys_nen=150;
     else sys_nen-=30;
     
     angolo=0;
     if (sys_nen) 
     {
       if (scan(dir0=90+180*sys_nord,10))
       {
         dir0=180*sys_est;
         verticale=0;
       }
       else verticale=1;
       if ( verticale*sys_nord + (!verticale)*sys_est ) { max=menouno; qq=meno800;}
       else { max=1; qq=200;}  
     }           
     else 
     {

/* Avvia la Strategia Finale */
       verticale=( ((dir0+=90*orario)%(fine=180)) > (centro=(inizio=0)) );
     }   
     dir=dir0;
   }

/* ...Centro */
   else if (centro)
   { 
     if (sys_nord!=sys_est) orario=verticale;
     else orario!=verticale;

     numero = (angolo = 1);
     
     if ( ((dmg=damage())>odmg)&&(!scan(dir+10,10))&&(!scan(dir+350,10)) )
     {

/* Cambia angolo */
       qq+=650;
       if (verticale) sys_nord^=1;
       else sys_est^=1;
       orario^=1;
     }
     else
     {
       max*=menouno;
       qq=50-qq;
       dir0+=180;

/* Correzione di avvicinamento alla parete */
       posiz=verticale*loc_x()+(!verticale)*loc_y();
       if ( (posiz>20) && (posiz<980) ) dir=dir0+10*orario-5;
       else dir=dir0;
     }
     odmg = dmg;
     while(speed()>49);
   }              

/* ...Iniziale */
   else if (inizio)
   {
      meno800-=800;
      if (sys_nord=(loc_y()>500)) {dir=90; max=1; qq=850;}
      else {dir=270; max=menouno; qq=meno150;}
      verticale=angolo=centro=1;
      while(speed()>49);
   }    

/* ...Finale */
   if (fine) 
   {
     if ((dir+=90)%90) dir+=45;
     else verticale^=1; 

     if ( verticale*(loc_y()>500) + (!verticale)*(loc_x()>500) ) { max=menouno; qq=meno150;}
     else { max=1; qq=850;}            
     
     if ( (scan(dir+10,10))||(scan(dir+350,10)) ) dir+=45;
     while(speed()>49);
   }
 }
}

/* Routine di cerca */
trovato(){ numero-=1; if (rng<=orng) {deg=a; orng=rng;} }

/*
 ****  *****   ***   ****   *   *
*        *    *   *  *   *  ** **
 ***     *    *   *  ****   * * *
    *    *    *   *  *  *   *   *
****     *     ***   *   *  *   *
 ####  #####   ###   ####   #   #
#        #    #   #  #   #  ## ##
 ###     #    #   #  ####   # # #
    #    #    #   #  #  #   #   #
####     #     ###   #   #  #   #
 ****  *****   ***   ****   *   *
*        *    *   *  *   *  ** **
 ***     *    *   *  ****   * * *
    *    *    *   *  *  *   *   *
****     *     ***   *   *  *   *
*/
