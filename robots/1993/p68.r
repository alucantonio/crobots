/***********************************************************************
 *  = Police =  Japan Version 1.068    by Marco Trova       18/06/93   *
 *              \/ o /\  a seconda del punto di partenza               *
 *              routine di sparo derivata da BISHOP.R con correzione   *
 *              al 87.5%: tiene conto del movimento statistico dell'av-*
 *              versario.                                              *
 * Sviluppato da:  Marco Trova                                         *
 * Mc-link:        MC5292                                              *
 * Point Fido: 2:333/201.xx                                            *
 *                                                                     *
 ***********************************************************************/

int dir;     /* direzione di spostamento */
int ay;      /* Y superiore o inferiore */
int veloc;   /* velocità di crociera, costante = 100 */
int bordo;   /* metri dal bordo prima di cominciare la decelerazione */
int dec;     /* velocità di decellerazione */
int var;     /*    */
int risoluzione;
int angolo;   /* direzione corrente di scan */
int range;   /* range corrente di scan */
int torna;
int count;    /*  */
int delta;    /*  */

main()
{

angolo=0;
veloc=100;
bordo=100;
dec=10;
risoluzione=10;
var=risoluzione;
torna=5;

 if (loc_y() <= 499) ay = 100;
 else ay = 899;

	
	dir = xy2dir(100, ay);       /* Vai all'angolo sinistro */
	drive (dir, veloc);
	while (loc_x() > bordo && speed()) spara();
	drive (dir, dec);
	while (speed() > 49) spara();


while (1) {


	dir = xy2dir(490, 490);          /* Vai al centro del campo di guerra */
	drive (dir, veloc);
	while (loc_x() < 480 && speed()) spara();
	drive (dir, dec);
	while (speed() > 49) spara();

	dir = xy2dir(890, ay);         /* Vai all'angolo destro*/
	drive (dir, veloc);
	while (loc_x() < 1000-bordo && speed()) spara();
	drive (dir, dec);
	while (speed() > 49) spara();
	
	dir = xy2dir(490, 490);          /* Vai al centro del campo di guerra */
	drive (dir, veloc);
	while (loc_x() > 480 && speed()) spara();
	drive (dir, dec);
	while (speed() > 49) spara();
	
	dir = xy2dir(100, ay);       /* Vai all'angolo sinistro */
	drive (dir, veloc);
	while (loc_x() > bordo && speed()) spara();
	drive (dir, dec);
	while (speed() > 49) spara();


  }; /* end of while(1)   */


}


xy2dir (x, y)      /* funz. per  la direzione partendo dalle coordinate */
int x, y;
{
		int d, locx, locy;

	locx = loc_x();
	locy = loc_y();

	if (locx == x) {
		if (y > locy)
			d = 90;
		else
			d = 270;
	} else
	{
		if (y < locy) {
			if (x > locx)
				d= 360 + atan ((100000 * (locy - y)) / (locx - x) );
			else
				d= 180 + atan ((100000 * (locy - y)) / (locx - x) );
			} else if (x > locx)
				d= atan ((100000 * (locy -y)) / (locx - x) );
			else
				d = 180 + atan ((100000 * (locy - y)) / (locx - x) );
		};
		return (d);
}

spara()
{
   int sparato;       /*  Flag per il cannone: diverso da 0 ha sparato */
   angolo+=2*var;         /*  cambia l'angolo di scan del doppio della risoluzione */
   sparato=0;         /*  inizializza il flag del cannone non sparato    */

   /*  Loops se il robot e' in scan ma il cannone sta ricaricandosi  */
   while (!sparato && (range =7*scan(angolo,var)/8)>0 )
   {
	  if (range<680)                 /* robot nemico trovato in range */
	 sparato=cannon(angolo,range);   /* prova a sparare al 87.5% del range */
	  else                           /* altrimenti il robot non e' in range */
	 sparato=1;                      /* esci dal loop per aggiustare lo scanning */
   }

   if (sparato)                 /* robot nemico trovato in range */
   {
	  if (var>1)                /* risoluzione corrente  > 1        */
	  {
	 var>>=1;                   /* riduci la risoluzione         */
	 angolo-=3*var;                     
	 count=0;                   /* inizializza il conto della ricerca   */
	  }
	  else                      /* risoluzione corrente piu' piccola  */
	 angolo-=2*var;             /* aggiusta l'angolo di scan         */
   }
   else                         /* nessun robot nell'angolo di scan    */
   {
	  if ((++count)==2)         /* if searched twice             */
	  {
	 var=risoluzione;           /* risetta la risoluzione al massimo   */
	 angolo-=torna*var;         /* aggiusta l'angolo di scan         */
	  }
   }
}


