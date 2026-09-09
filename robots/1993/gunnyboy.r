/* ******************************************************************** */
/* == GUNNYBOY ==  By Paolo Di Benedetto  				*/
/* ******************************************************************** */

/* ******************************************************************** */
/* GUNNYBOY si avvale di 3 procedure:					*/
/* 1) "cerca": esegue il controllo dei danni subiti e richiama le 	*/
/*		procedure "spara" e "scappa"				*/
/* 2) "spara": cerca e attacca gli avversari				*/
/* 3) "scappa": fa attraversare tutto il campo (parallelamente all' asse*/
/*		Y) al robot 						*/
/* ******************************************************************** */

/* dichiarazioni variabili globali */

int xpos,ypos; /* memorizzano la posizione */
int distan,gradi,inizio,fine; /* per le operazioni di guerra */
int dir,conta; /* per muoversi(dir) e per contare le scansioni */
int danni1,danni2; /* memorizzano il vecchio e il nuovo ammontare dei danni */

main()
{
/* inizializzazione variabili */
conta=0;
ypos=loc_y();
danni1=damage();
danni2=danni1+15;
gradi=0;

/* Routine che guida il robot nell' intorno del punto x=500 y=1000	*/
/* valutando con la funzione arcotangente la direzione (dir) per raggiungere*/
/* il punto lungo la traiettoria pió breve				*/
while (((xpos<480)||(xpos>=520)) && (ypos<970)) {
						xpos=loc_x();
						ypos=loc_y();
						if (xpos>500) 
						{ dir= 90+(atan(100000*(xpos-500)/(1000-ypos))); }
						else
						 dir=atan(100000*(1000-ypos)/(500-xpos)); 
						drive (dir,50);
						spara();
						ypos=loc_y();
						danni1=damage();
if ( danni1 >= danni2 ) { if (ypos>=500) { scappa(270,0);danni2=danni1+15; }
					else
					scappa (90,1000);danni2=danni1+15;
			}

	}

/* Raggiunta la posizione operativa il robot entra in un ciclo infinito */
while(1) {
	if (ypos>=970) {inizio=170;fine=370;cerca(); }   
	if (ypos<=30) {inizio=-10;fine=190;cerca(); }
	}
}

/* Procedura di ricerca e attacco, per eseguire uno scanning molto rapido */
/* il Gunnyboy usa una risoluzione bassa (3) e la variabile gradi viene   */
/* incrementata ogni volta di 3 					  */
/* La rapiditÖ di scansione unita al fatto che nella posizione operativa  */
/* deve essere controllata un' area di soli 180 gradi aumenta le 	  */
/* aumenta le possibilitÖ di trovare il nemico per primo  		  */
/* Per evitare di essere un bersaglio troppo facile dopo aver sparato     */
/* Gunnyboy si sposta parallelamente all' asse X			  */
spara()
{
distan=scan(gradi,3);
if ((distan <=700) && (distan>0)) {
				cannon(gradi,distan);
				cannon(gradi,distan*7/8);
				gradi -=20;
				xpos=loc_x();
				if (xpos>500) {drive(180,50); }
				if (xpos <=500) {drive(0,50); }
				conta=0;
				 }
gradi +=3;
}

/* Procedura di sicurezza fa attraversare al robot tutto il campo se	*/
/* il livello dei danni1 aumenta oltre un certo limite o se vanno a vuoto*/
/* circa dieci scansioni 						*/

scappa(degree,pos)
{
int degree,pos,aux;
ypos=loc_y();
if (ypos > 500) {
		while(ypos>30) {
		drive(degree,100);
		spara();
		ypos=loc_y();
		}
		}
else
	if (ypos < 500) {
		while(ypos < 970) {
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
while (gradi < fine) {
		conta +=1; 
		spara() ;
		ypos=loc_y();
danni1=damage();
if ((danni1>= danni2) || (conta==900)) { if (ypos>=970) { scappa(270,0);
						 gradi=fine; /* cosç si esce dal ciclo della procedura cerca */
						 danni2=danni1+15; } /* viene aggiornata la varibile per il controllo danni */
					else
					scappa (90,1000); gradi=fine;danni2=danni1+15;
			}
		}
}