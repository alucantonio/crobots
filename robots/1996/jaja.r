/*-------------------------------------------------------------------------- 

   CROBOT:  jaja.r 
   
   AUTORE:  LUIGI RAFAIANI (01.03.1962) 
	    e-mail mc1503@mclink.it 

		    
			  SCHEDA TECNICA

 IL CROBOT TENDE AD OSCILLARE RIMANENDO VICINO AD OGNI ANGOLO DELL'ARENA 
 FINCHE' NON VIENE ATTACCATO NEL QUAL CASO SI SPOSTA SEMPRE OSCILLANDO
 DESCRIVENDO UN QUADRATO A CIRCA 150 UNITA' DAL BORDO DEL CAMPO 
 DI GIOCO FERMANDOSI VICINO AL PROSSIMO VERTICE. 
 
 LA ROUTINE DI FUOCO FUOCO() COMPRENDE UNA FUNZIONE DI PUNTAMENTO 
 FIND() E UNA ROUTINE DI TIRO VERO E PROPRIO SPARA(). 
 
 IL CROBOT UNA VOLTA PERSO IL BERSAGLIO LO CERCA A DESTRA E A SINISTRA E
 SE NON LO TROVA VA IN CERCA DI UN ALTRO BERSAGLIO.

 LA ROUTINE DI PUNTAMENTO TENDE AD INDIVIDUARE PER APPROSSIMAZIONI SUCCESSIVE
 L'ESATTO ANGOLO DELLA POSIZIONE DELL'AVVERSARIO. (SI E' CERCATO DI RENDERE
 IL PIU' POSSIBILE COSTANTE IL TEMPO DI ESECUZIONE DELLA ROUTINE AL VARIARE
 DELL'ANGOLO).
 
 LA ROUTINE DI TIRO SPARA() SEGUE IL BERSAGLIO ATTRAVERSO UNA FIND() 
 DOPO DI CHE' CALCOLA L'ANGOLO DI TIRO IN BASE ALLO SPOSTAMENTO DEL 
 BERSAGLIO E CALCOLA IN RANGE IN BASE ALLA SEGUENTE FORMULA:
				    VELOCITA' PROIETTILE
 RANGE = RANGE ATTUALE * ------------------------------------------
			 VELOCITA' PROIETTILE + VELOCITA' BERSAGLIO
 
 DOVE LA VELOCITA' PROIETTILE E' UNA COSTANTE E LA VELOCITA' DEL BERSAGLIO
 E' PROPORZIONALE ALLO SPOSTAMENTO DEL BERSAGLIO. 
 SI SONO POI AGGIUNTI DUE FATTORI CORRETTIVI PER IL MOVIMENTO:
 UNO SULL'ANGOLO PROPORZIONALE AL SENO DELL'ANGOLO TRA DIREZIONE DI MARCIA
 E POSIZIONE DEL BERSAGLIO ( ANGOLO ALFA ) E UNO SUL RANGE PROPORZIONALE AL
 COSENO DI TALE ANGOLO.

 SI E' CERCATO DI MANTENERE IL TEMPO DI ESECUZIONE DELLA ROUTINE DI FUOCO
 AL DI SOPRA DEL TEMPO DI RICARICA DELLA FUNZIONE CANNON().

 --------------------------------------------------------------------------*/


int     ang, dir, dam, sdam, ldam, t, limt;   
int     vaix, vaiy, velox;
int     oang, dang, alfa, corr, anco, nrg, rng2, rg;    
int     drg, verso;

/***---                     main()                      ---***/

main()

{
ang = 36002;
while ( ! scan (ang,10) ) ang += 19;


while (1)
	{
	verso = 180;
	while (loc_x() > 250) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	verso = 90;
	while (loc_y() < 750) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	verso = 360;
	while (loc_x() < 750) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	verso = 270;
	while (loc_y() > 250) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	}
}

/***---               routines                          ---***/

colpire()

{
fuoco();
dir = verso+50;
drive (dir,100);
fuoco();
dir = verso-50;
drive (dir,100);
}

fcolp()

{
fuoco();
dir = verso+90;
drive (dir,100);
fuoco();
dir = verso-90;
drive (dir,100);
}


/***--- find() - routine di ricerca del bersaglio       ---***/

find()

{

if ( nrg = scan(ang,10) )  
 { if ( scan(ang+6,5) )
   {  if ( scan(ang+2,2) )
      {  if ( scan(ang+4,1) ) 
	 {  if ( scan(ang+3,0) ) 
	     ang+=3; 
	    else
	     ang+=4;
	 }
	 else
	    if ( scan(ang+2,0) )
	     ang+=2; 
	    else
	     ang+=1; 
      }
      else
      {  if ( scan(ang+8,1) ) 
	 {  if ( scan(ang+7,0) ) 
	     ang+=7; 
	    else
	     ang+=9;
	 }
      else
	 if ( scan(ang+6,0) )
	    ang+=6; 
	 else
	    ang+=5; 
      }
   }
   else
   {  if ( scan (ang-1,2) )
      {  if ( scan(ang-3,1) )
	 {  if ( scan(ang-2,0) ) 
	     ang-=2;
	    else
	     ang-=3;        
	 }
	 else
	   if ( scan(ang-1,0) )
	    ang-=1;
	   else
	    ang-=0;        
      }
      else
      {  if ( scan(ang-4,1) )
	 {  if ( scan(ang-5,0) ) 
	     ang-=5;
	    else
	     ang-=4;        
	 }
	 else
	   if ( scan(ang-6,1) )
	    ang-=6;
	   else
	    ang-=8;        
      }
   }
 return 1;
 }
else 
 { if ( nrg = scan(ang+15,5) )
   {  if ( scan(ang+12,2) )
      {  if ( scan(ang+14,1) ) 
	 {  if ( scan(ang+13,0) ) 
	     ang+=13; 
	    else
	     ang+=14;
	 }
	 else
	    if ( scan(ang+12,0) )
	     ang+=12; 
	    else
	     ang+=11; 
      }
      else
      {  if ( scan(ang+18,1) ) 
	 {  if ( scan(ang+17,0) ) 
	     ang+=17; 
	    else
	     ang+=19;
	 }
      else
	 if ( scan(ang+16,0) )
	    ang+=16; 
	 else
	    ang+=15; 
      }
   }
   else
   {  if ( nrg = scan (ang-13,2) )
      {  if ( scan(ang-11,1) )
	 {  if ( scan(ang-11,0) ) 
	     ang-=11;
	    else
	     ang-=12;        
	 }
	 else
	   if ( scan(ang-13,0) )
	    ang-=13;
	   else
	    ang-=14;        
      }
      else
      {  if ( nrg = scan(ang-17,1) )
	 {  if ( scan(ang-16,0) ) 
	     ang-=16;
	    else
	     ang-=17;        
	 }
	 else
	   if ( scan(ang-18,1) )
	    ang-=18;
	   else
	    return 0;        
      }
   }
 return 1;
 }
}



/***--- fuoco() - routine di gestione del tiro  ---***/

fuoco()         
{
/* se individui un bersaglio spara                           */
if ( find() )
   {
   spara();
   }
else    
   {
   ang += 29;
   drive (dir,40); 
   while ( ! scan(ang,10) ) ang += 19;
   while (speed() > 40) ;
   }
}

/***--- spara() - routine di tiro  ---***/

spara()
 
{
 
drive (dir,100);

oang=ang;
 
if ( find() )
 {    
 drive (dir,40);
    
 alfa = (ang-dir) - ((ang-dir)/360)*360;
 
 corr = cos(alfa);
 anco = - sin(alfa);
    
 dang = ang + (ang-oang)*3 + anco/17000;
   
 if (rg=scan(ang,10)) 
   {
   drg =  rg*350/(350+nrg-rg-corr/3000); 
   while ( ! cannon ( dang, drg ) ) ;
   }
 else   
   {
   drg = nrg;
   cannon ( dang, drg);
   }
 }
else
 {
 drive (dir,40);
 ang += 29;
 while ( ! scan (ang,10) ) ang += 19;
 while (speed() > 40);
 }

}

