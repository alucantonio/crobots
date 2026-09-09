/* ************************************************************************************************************************************************************** */
/* == GUNNYBOY ==  By Paolo Di Benedetto ==												  */
/*Gunnyb29 Ë derivato da GUNNYBOY.R che partecipÚ al torneo di MC nel lontano 1993 senza grosso successo, i problemi principali erano una routine di movimento che*/
/* talvolta si impallava, lasciando il robot in balia degli eventi, ed una routine di puntamento molto approssimativa.						  */
/*																				  */
/*GUNNYB29 utilizza la stessa strategia di GUNNYBOY, raggiunge la parete orizzontale pi˘ visina e si muove lungo di essa, cambiando direzione o perchË vicino al  */
/*bordo o dopo aver sparato.																	  */
/*																				  */
/*E' presente anche una routine scappa(), originariamente pensata o per fuggire, nel caso la quantit‡ di danni avesse superato una determinata soglia, o dopo     */
/*circa 10 cicli di scansione andate a vuoto, per scovare robot nascosti.											  */
/*In realt‡ questa strategia si Ë dimostrata pi˘ dannosa che utile, esponendo il robot molto al fuoco nemico, di fatto ho laciato la routine attiva solo se il    */
/*numero di cicli /*supera una certa soglia, meglio un onorevole attacco suicida che un pavido pareggio!							  */
/* ************************************************************************************************************************************************************** */

/* dichiarazioni variabili globali */

int xpos,ypos; /* memorizzano la posizione */
int distan,gradi,inizio,fine; /* per le operazioni di guerra */
int dir,conta; /* per muoversi(dir) e per contare le scansioni */
int danni1,danni2,sogliadanni; /* memorizzano il vecchio e il nuovo ammontare dei danni */
int s, k, c, ca, c2, scale;

main()
{
	int bordo;
/* inizializzazione variabili */
	conta=0;
	ypos=loc_y();
	danni1=damage();
	sogliadanni = 100;
	danni2=danni1+sogliadanni;
	gradi=0;

	s = 1250; /*parametro di fuoco definito per tentativi*/	
	k = 900*s/100; /*parametro di fuoco definito per tentativi*/	
	c = 10/100; /*parametro di fuoco definito per tentativi*/
	ca = -230/100; /* per correggere l'angolo di tiro a seconda che mi sto allontanando o avvicinando */	
	c2 = 240/100; /*parametro di fuoco definito per tentativi*/	
	scale = 100000;

/* Routine che guida il robot sulla parete X pi˘ vicina	*/

	if (ypos>=500) 
	{
	
		dir = 90;
		bordo = 950;
	}
	else
	{
		dir = 270;
		bordo = 50;
	}

/* aumentata la velocita a 100 per arrivare il prima possibile ed ridurre i rischi */
	
	while (sqrt((ypos-bordo)*(ypos-bordo))>=50)
	{

		drive (dir,100);
		ypos=loc_y(); 
	}

/* Raggiunta la posizione operativa il robot entra in un ciclo infinito */
/* 08-03-2011 aggiornato: la frenata inizia a 50 dal muro non pi˘ a 30 per evitare collisioni e danni */

	while(1) 
	{

/* 08-03-2011 aggiornato: la scansione ha ora ampiezza 10 quindi l'angolo effettivo di scansione sar‡ di 180 gradi +/- 10*/
		ypos=loc_y();
		if (ypos>=950) {inizio=180;fine=360;cerca(); }   
		if (ypos<=50) {inizio=0;fine=180;cerca(); }
	}
}

/* Procedura di ricerca e attacco*/
spara()
{
int ang;
int oang;
int range;
int orange;
int aa;
int rr;
int an;
int fuoco;
	orange=scan(gradi,10);
	if ((orange <=700) && (orange>0)) 
	{
		range=scan(gradi+5,5);
		if ((range <=700) && (range>0)) 
		{
			ang = gradi+5;
			if (range < 60) range = 100;
     			if (range > orange) cannon(ang,range*8/7);
   			else cannon(ang,range*7/8);
			fuoco = 1;
 		}
		range=scan(gradi-5,5);
		if ((range <=700) && (range>0)) 
		{
			ang = gradi-5;
			if (range < 60) range = 100;
     			if (range > orange) cannon(ang,range*8/7);
   			else cannon(ang,range*7/8);
			fuoco = 1;	
		}
		if (fuoco == 1)
		{
			drive(0,0);
       			if(scan(ang-5,5)) ang-=5;
			if(scan(ang+5,5)) ang+=5;
			if(scan(ang-3,3)) ang-=3;
			if(scan(ang+3,3)) ang+=3;
			if(scan(ang-1,2)) ang-=1;
			if(scan(ang+1,2)) ang+=1;
			
			if (range=scan(ang,5)) 
			{ 
				orange=range; 
				oang=ang; 
			}
			if(scan(ang-5,5)) ang-=5; 
			if(scan(ang+5,5)) ang+=5; 
			if(scan(ang-3,3)) ang-=3; 
			if(scan(ang+3,3)) ang+=3; 
			if(scan(ang-1,2)) ang-=1; 
			if(scan(ang+1,2)) ang+=1; 
			if (range=scan(ang,10)) 
			{ 
				rr = 2*range-orange;
				aa = ang + rr*(ang-oang)/k-(ang-oang)*ca;
				while(!cannon(aa,rr));
				fuoco = 0;
			}
		}
		gradi -=40;
		xpos=loc_x();
		if (xpos>500) {drive(180,100); }
		if (xpos <=500) {drive(0,100); }
		conta=0;
	}
	
gradi +=20;
	xpos=loc_x();
	if (xpos>700) {drive(180,100); }
	if (xpos<300) {drive(0,100); }

}


/* Procedura di sicurezza fa attraversare al robot tutto il campo dopo molti molti cicli.....*/

scappa(degree,pos)
{
int degree,pos,aux;
ypos=loc_y();

/* 08-03-2011 aggiornato: la frenata inizia a 100 dal muro non pi˘ a 30 per evitare collisioni e danni */
if (ypos > 500) {
		while(ypos>100) {
		drive(degree,100);
		spara();
		ypos=loc_y();
		}
		}
else
	if (ypos < 500) {
		while(ypos < 900) {
		drive(degree,100);
		spara();
		ypos=loc_y();
		}
		}
conta=0; /* si pone conta uguale a zero per evitare che la procedura "scappa" venga chiamata all'infinito */
drive(0,0);
}


/* Procedura che richiama tutte le altre, la procedura "spara" viene	*/
/* richiamata ad ogni ciclo, mentre la procedura "scappa" solo se il    */
/* controllo dei danni da esito positivo o la variabile conta raggiunge */
/* il suo massimo valore						*/ 
cerca ()
{
	gradi=inizio;
	while (gradi <= fine) 
	{
		conta +=1; 
		spara() ;
		danni1=damage();
		if ((danni1>= danni2) || (conta==4000)) 
		{ 
			ypos=loc_y();
			if (ypos>=500) 
			{ 
				scappa(270,0);
				gradi=fine; /* cosç si esce dal ciclo della procedura cerca */
				danni2=danni1+sogliadanni; /* viene aggiornata la varibile per il controllo danni */

			} 
			else
			{
				scappa (90,1000); 
				gradi=fine;
				danni2=danni1+sogliadanni;
			}
		}
	}
}