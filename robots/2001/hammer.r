/************************
 *                      *
 *  H  A  M  M  E R .r  *
 *                      *
 ************************

nome in codice: MINI S H O C K

 Michelangelo Messina                         



	Everything is free...

*/


/*
Il microrobot e' un tentativo di riduzione del macro
shock.r
Il risultato e' abbastanza scadente...

Si posiziona nell'angolo piu' vicino.
Se ci sono nemici nelle vicinanze, oscilla verticalmente
e orizzontalmente, altrimenti resta fermo.
Quando ne rimane uno solo attacca con un movimento orizzontale
al centro dell'arena.

La routine di fuoco e' molto primitiva, con correzioni sull'angolo
e sulla distanza.
*/



int     dam, /*percentuale di danni attuale*/
        pt,att; /*contatore parziale*/
int     ang,x;
int     up,dx;






main()
{
    att=1;
    while (1) {
        dx=(loc_x(up=(loc_y()>500))>500);
        dam=damage()+20;
        while ( damage() < dam ) { /*fino quando non e' colpito o limite di tempo*/
                if (dx) {
                        xmag(830);
                        xmin(915);
                        drive(360,0);
                } else {
                        xmin(170);
                        xmag(85);
                        drive(180,0);
                }

                if (up) {
			ymag(830);
			ymin(915);
                        drive(90,0);
                } else {

			ymin(170);
			ymag(85);
                        drive(270,0);
                }
		
		 /* se tutti sono lontani posso star fermo 
		 altrimenti oscillo intorno all'angolo attuale*/ 

                while (spara()) {
                        if(!(++pt%40)) {
                            ang=-10;
                            x=0;
			    while((ang+=20)!=730) x+=(!scan(ang,10));
			    if (x>33) {
                                    att=0;
				    ymin(450);ymag(550);
				    while(1) {xmin(800); xmag(200); }
			    }
			}
                }
        }

	/* ricerca di un angolo libero */
        if(up) {
                if(libero(260)) ymag(110);
                else fuggi();
   	} else {
                if(libero(80)) ymin(890);
                else fuggi();
	}

    }
}

fuggi()
{
        if(dx) {
                if(libero(170)) xmag(110);
        } else {
                if(libero(350)) xmin(890);
        }
}

int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(!((scan(i,10))||(scan(i+20,10))));
}


spara()
{ 
        if (!(x=scan(ang,10)))
        if (!(x=scan(ang-=20,10)))
        if (!(x=scan(ang+=40,10)))
        if (!(x=scan(ang+=20,10))) {return ang+=40;}
        cannon (ang+=7*(!(scan(ang+356,7)))+353*(!(scan(ang+4,7))), 2*scan(ang,10)-x );      
        if(att) if(x>810) return(ang+=47);
        return(0);
} 
  
/* spostamento */
xmag(y) { while(loc_x(m(180))>y); } 
xmin(y) { while(loc_x(m(360))<y); } 
ymag(y) { while(loc_y(m(270))>y); } 
ymin(y) { while(loc_y(m(90))<y); } 

m(dir)
{
     spara(drive(dir,100));
}


/* I had a dream last night */
