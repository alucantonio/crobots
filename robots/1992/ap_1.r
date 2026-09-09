/*
**
**           ap_1.r                Antonio Pennino
**             di                  
**       Antonio Pennino           
**          09/12/91               MC4366
**
*/

/*------------------------------------------------------------------**
**               Principali Costanti Del Programma                  **
**------------------------------------------------------------------*/
int	STOP;          /*  motore fermo                                */
int	MAXVEL;        /*  motore al massimo                           */
int	MAXCDIR;       /*  max. velocita' per poter cambiare direzione */
int	VELRALL;       /*  velocita' da adottare per rallentare        */
int	DIM_X;         /*  numero di caselle orizzontali (sinistra=0)  */
int	DIM_Y;         /*  numero di caselle verticali   (basso=0)     */
int	MAXTIRO;       /*  massima lunghezza di tiro del cannone       */
int	MARGMURO;      /*  margine di sicurezza per il muro            */
int	MARGSPARA;     /*  margine di sicurezza per il cannone         */
int	MAXSCAN;       /*  massima ampiezza dell' angolo di scansione  */
int	INCRSCAN;      /*  incremento nell' angolo di scansione        */

/*------------------------------------------------------------------**
**                      Variabili Globali                           **
**------------------------------------------------------------------*/
int	AngScan;       /*  ultimo angolo di scansione del radar        */
int	RipScan;       /*  ripetizioni consecutive della scansione     */
int	DirMarcia;     /*  direzione (angolo) attuale di marcia        */

/*------------------------------------------------------------------**
**          Inizializza Le Costanti e le Variabili Globali          **
**------------------------------------------------------------------*/
inizializza()
{
	STOP = 0;      
	MARGMURO = 50;  
	MARGSPARA = 45;  
	MAXVEL = 100;
	DIM_X = 1000;  
	DIM_Y = 1000;   
	MAXTIRO = 700;   
	MAXCDIR = 50;  
	VELRALL = 60;
	MAXSCAN = 8;   
	INCRSCAN = MAXSCAN * 2;
	RipScan = 360 / INCRSCAN;      
	AngScan = 45;
}


/*------------------------------------------------------------------**
**               SCANDISCO IL CAMPO E SE TROVO SPARO                **
**------------------------------------------------------------------*/
spara()
{
	int	distanza, rip;
	rip = RipScan; 
	distanza = 0;
	while ( --rip && distanza == 0 ) {
		AngScan %= 360; 
		AngScan += INCRSCAN;
		distanza = scan(AngScan, MAXSCAN);
		if ( distanza > MARGSPARA /* && distanza<=MAXTIRO */ ) { 
			while ( !cannon(AngScan, distanza) ) 
				;
			if (testmarg() == 0) 
				go_dir(AngScan, MAXVEL); 
		}
	}
	AngScan -= INCRSCAN * 2;
}


/*------------------------------------------------------------------**
**              RESTITUISCO IL VALORE ASSOLUTO (>0) DI UN INTERO    **
**------------------------------------------------------------------*/
abs(num)
int	num;
{
	if (num >= 0) 
		return(num); 
	else 
		return(num * -1);
}


/*------------------------------------------------------------------**
**        CALCOLO LA DIREZIONE PER ANDARE IN UN CERTO PUNTO         **
**   L' angolo e' restutuito normalizzato ( 0 <= angolo < 360 )     **
**------------------------------------------------------------------*/
direzione(old_x, old_y, new_x, new_y)
int	old_x, old_y, new_x, new_y;
{
	int	dx, dy, angolo;                 /* dichiaro le variabili locali */

	dx = new_x - old_x; 
	dy = new_y - old_y;   /* calcolo le differenze in X,Y */
	if (dx == 0)                        /* valuto se direzione verticale*/
		if (dy >= 0) 
			return(90);           /* ... new_y e' a +90 gradi     */
		else 
			return(270);          /* ... new_y e' a -90 gradi     */
	angolo = atan((100000 * dy) / abs(dx)); /* calcolo l' angolo(1,4 quadr.)*/
	if ( dx < 0 ) 
		angolo = 180 - angolo;  /* corr. x secondo e terzo quad.*/
	angolo = (angolo + 360) % 360;          /* normalizzo l' angolo (0-359) */
	return(angolo);                   /* restituisco l' angolo        */
}


/*------------------------------------------------------------------**
**                 I N I Z I O   P R O G R A M M A                  **
**------------------------------------------------------------------*/
main()
{
	inizializza();

	go_to(DIM_X / 2, DIM_Y / 2, MAXVEL);
	while (1) {
		while ( testmarg() && speed() )      
			spara();
		while ( (testmarg() == 0) && speed() ) 
			spara();
		go_to(DIM_X / 2, DIM_Y / 2, MAXVEL);
	}
}


/*------------------------------------------------------------------**
**              SI SPOSTA NELLA LOCAZIONE SPECIFICATA               **
**                ( x , y , velocita ; DirMarcia )                  **
**------------------------------------------------------------------*/
go_to(x, y, vel)
int	x, y, vel;
{
	go_dir( direzione(loc_x(), loc_y(), x, y) , vel );
}


/*------------------------------------------------------------------**
**               SI SPOSTA NELLA DIREZIONE SPECIFICATA              **
**                ( direzione , velocita ; DirMarcia )              **
**------------------------------------------------------------------*/
go_dir(direzione, vel)
int	direzione;
int	vel;
{
	DirMarcia = direzione;
	drive( DirMarcia , MAXCDIR );
	drive( DirMarcia , MAXCDIR );
	while ( speed() == STOP ) 
		;
	while ( speed() > MAXCDIR ) 
		;
	drive( DirMarcia , vel );
}


/*------------------------------------------------------------------**
**                 INVERTE LA DIREZIONE DI MARCIA                   **
**------------------------------------------------------------------*/
retromarcia()
{
	DirMarcia = (DirMarcia + 180 + 360) % 360;
	go_dir(DirMarcia, MAXVEL);
}


/*------------------------------------------------------------------**
**                 VERIFICO SE MI TROVO AI MARGINI                  **
**                        ( ; vero | falso )                        **
**------------------------------------------------------------------*/
testmarg()
{
	int	x, y;
	x = loc_x(); 
	y = loc_y();
	if ( (x + MARGMURO) > DIM_X ) 
		return(1);
	if ( (y + MARGMURO) > DIM_Y ) 
		return(1);
	if (x < MARGMURO)             
		return(1);
	if (y < MARGMURO)             
		return(1);
	return(0);
}


