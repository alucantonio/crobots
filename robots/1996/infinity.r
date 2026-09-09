/***********************
 *                     *
 *     Infinity.r      *
 *                     *
 ***********************

 Rel 50b - 9/9/1996

 Michelangelo Messina                           Angelo Ciufo
                                                Email: MC8579@mclink.it

			Insieme,
			Amigos
*/


int ang;        /* angolo di scansione*/

main()
{
        int     b,c,d,i,        /*variabili temporanee*/
        pausa,                  /*loop eseguiti*/
        attesa,                 /*loop da eseguire prima di attaccare*/
        dir,                    /*angolo direzione*/
        cx,sx,                  /*cos e sin dir*/
        dam;                    /*danni subiti*/

        /*      inizializzazione        */
        attesa=100;
        dam=0;
        if (loc_x()<500) dir=180;
        else dir=0;

        while (1)       /* ciclo principale */
	{
                while (damage()<=dam) {
                        if (speed()>50)
                        {       /* robot in movimento: 
                                   controlla se si trova nelle vicinanze del bordo e poi
                                   chiama la routine di fuoco */
                                if ((c=loc_x())>850 && cx>0) drive(dir,0);
                                else if (c<150 && cx<0) drive(dir,0);
                                else if ((b=loc_y())>850 && sx>0) drive(dir,0);
                                else if (b<150 && sx<0) drive(dir,0);
                                spara(1);
                        }
                        else
                        {       /* fermo:
                                   il robot oscilla intorno alla posizione di arrivo
                                   (per evitare di essere colpito) */
                                drive((dir+=180)%=360,100);
                                spara(1);
                                spara(1);
                                drive(dir,0);
                                if (spara(1)) ++pausa;
                                else pausa=0;
                                if (pausa>attesa && dam<90) {
                                        /* attacco:
                                           se non ci sono nemici in vicinanza,
                                           da molto tempo, inseguo un robot */

                                        /* cerca prima il nemico piu' vicino*/
                                        c=0;
                                        i=-20;
                                        while(!(b=scan(i+=20, 10)));
                                        ang=i;
                                        while (i<360) {
                                                if ((d=scan(i+=20, 10)) ) {
                                                        if (d<b) {
                                                                b=d;
                                                                ang=i;
                                                        }
                                                        ++c;
                                                }
                                        }
                                        drive(ang,100);
                                        pausa=0;
                                        attesa=50;
                                        if(!c) dam=94; /* se ce ne e' uno solo, fino al 94% */

                                        /* punto il nemico zig-zagando */
                                        i=-1;       
                                        while(damage()<dam) {
                                                if (spara(0)) {
                                                        /* se sono troppo vicino mi allontano */
                                                        drive(ang+225,100);
                                                        i=0;
                                                }
                                                else {
                                                        /* se vicino ai bordi, va verso il centro */
                                                        if ((c=loc_x())>880 ) dir=180;
                                                        else if (c<120 ) dir=0;
                                                        else if ((c=loc_y())>880 ) dir=270;
                                                        else if (c<120) dir=90;

                                                        /* ogni tre cicli cambio direzione */
                                                        else if (!((++i)%=6)) dir=ang+45;
                                                        else if (i==3) dir=ang-45;
                                                        drive(dir,100);
                                                }
                                        }
                                }
                        }
                }


                /* fuga:
                   se colpito il robot cerca un pezzo di arena senza nemici */

                b=loc_y();
                drive(dir+180,100);

                /* l'arena e' divisa secondo lo schema:
                        3  360 2
                        90 4 90
                        0  360 1 */

                if ((c=loc_x())<333){
                        if (b<333) i=0;
                        else if (b>667) i=3;
                        else i=90;
                }
                else if (c>667) {
                        if (b>667) i=2;
                        else if (b<333) i=1;
                        else i=90;
                }
                else if (b<333||b>667) i=360;
                else {
                        i=-1;
                        while(++i<4) if(scan(dir+=20,10)) i=-1; 
                        dir-=30;
                          /* all'uscita i=4*/
                }
                if (i<4) {
                        i*=90;
                        if (!( scan(i-10,10) || scan(i+10,10))) dir=i;
                        else if (!( (d=scan(i+80,10)) || scan(i+100,10))) dir=i+90;
                        else if (!( scan(i+35,10) || (c=scan(i+55,10))) ) dir=i+45;
                        else if(c || d) dir=i+22;
                        else dir=i+68;
                }
                else if (i>4) {
                        i%=360;
                        if (scan(i,10) || scan(i+20,10) || scan(i-20,10)) dir=i+180;
                        else dir=i;
                }


                drive (dir,100);
                spara(1);
                pausa=0;
                cx=cos(dir);
                sx=sin(dir);
                spara(1);
                drive(dir,100);
                dam=damage()+3;
                spara(1);
	}
}


/* routine di fuoco */

int spara(mode)
int mode;
/* mode=0:
   usato nella routine di attacco, il robot e' in modalita' inseguimento:
   anche se il nemico dista piu' di 710 non ne viene cercato un altro.
   La routine restituisce 1 se il nemico e' molto vicino (<140).

   mode=1:
   usata negli altri casi. Restituisce 1 se non sono stati trovati nemici,
   o se distano piu' di 710.
*/
{
	int     range,oldr;
	if ((range=scan(ang, 10)) ) {
		if (scan(ang-7,4)) {
			if (scan(ang-=7-2,2)) {
				if(scan(ang-=2-1,1)) ang-=1;
			}
			else if (scan(ang+2,2)) ang+=2;
		}
                else if(scan(ang+7,4)) {
                        if(scan(ang+=7+2,2)) ang+=2;
                }
                else if(scan(ang+2,2)) ang+=2;
	}
	else if ((range=scan(ang-=20,10))) {
		if (scan(ang-7,4)) {
			if (scan(ang-=7-2,2)) ang-=2;
		}
		else if(scan(ang+7,4)) ang+=7;
	}
	else if ((range=scan(ang+=38,8))) {
		if (scan(ang-5,3)) ang-=5;
	}
	else if (!(range=scan(ang+=18,10))) {
                if (!(scan(ang+=20,10))) ang+=40;
                ang%=360;
                return mode;
	}
	if (oldr=scan(ang,10)){ 
                cannon (ang, oldr*183/(183+range-oldr) );
		if(mode) {
                        if(oldr<710) return 0;
			ang+=40;
                        return 1;
		}
                return(oldr<140);
	}
        return mode;
}

/**********************************
 *          Destination:          *
 *                                *
 *        I N F I N I T Y         *
 **********************************/
