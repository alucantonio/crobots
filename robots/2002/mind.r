/********************
 *                  *
 *  M  I  N  D  .r  *
 *                  *
 ********************


 Michelangelo Messina



        Open your mind

*/


/*
Il minirorobot e' un tentativo di riduzione dei macro
discendenti diretti di shock.r
Il risultato e' abbastanza scadente... ma non so fare di meglio!

All'avvio si posiziona nell'angolo piu' vicino.
Se ci sono nemici nelle vicinanze, oscilla verticalmente
e orizzontalmente, altrimenti resta fermo.
Se viene colpito e i danni sono ingenti, controlla se c'e' un angolo
libero. In caso affermativo ci si reca.
Se e' fermo dopo 20 cicli controlla il numero dei nemici.
Quando ne rimane uno solo attacca con un movimento a quadrato
al centro dell'arena.

La routine di fuoco e' molto primitiva, con correzioni sull'angolo
e sulla distanza.
*/



int     dam, /*percentuale di danni attuale*/
        pt,att; /*contatore parziale*/
int     ang,x;
int     up,dx;
int     dir;





main()
{
    dove(pt=att=21);
    while (dam=damage()+20) {
        while ( damage() < dam ) { /*fino quando non e' colpito o limite di tempo*/
                if (dx) {
                        xmag(820);
                        ang=180;
                        s(xmin(915));
                } else {
                        xmin(180);
                        ang=360;
                        s(xmag(85));
                }

                if (up) {
                        ymag(820);
                        ang=270;
                        s(ymin(915));
                } else {
                        ymin(180);
                        ang=90;
                        s(ymag(85));
                }
		
		 /* se tutti sono lontani posso star fermo 
		 altrimenti oscillo intorno all'angolo attuale*/ 

                while (!x) {
                        spara();
                        if(++pt>20) {
                            pt=x=0;
                            ang=-10;
			    while((ang+=20)!=370) x+=(!scan(ang,10));
			    if (x>16) {
                                    att=0;
                                    while(1) {ymag(300);xmin(800); ymin(700);xmag(200); }
			    }
                        } 
                }
        }

	/* ricerca di un angolo libero */
        if(up) {
                if(libero(260)) dove(ymag(110));
                else fuggi();
   	} else {
                if(libero(80)) dove(ymin(890));
                else fuggi();
	}

    }
}

fuggi()
{
        if(dx) {
                if(libero(170)) dove(xmag(110));
        } else {
                if(libero(350)) dove(xmin(890));
        }
}

dove()
{
dx=(loc_x(up=(loc_y()>500))>500);
}

int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(!((scan(i,10))||(scan(i+20,10))));
}


spara()
{
        if (x=scan(ang,10));
        else if (x=scan(ang-=20,10));
        else if (x=scan(ang+=40,10));
        else if (x=scan(ang+=20,10));
        else {return ang+=40;}
        cannon (ang+=7*(!(scan(ang+356,7)))+353*(!(scan(ang+4,7))), 2*scan(ang,10)-x );      
        if(att) if(x>850) {x=0;return(ang+=41);}
} 

/* spostamento */
xmag(y) { dir=180;while(loc_x(m())>y); } 
xmin(y) { dir=360;while(loc_x(m())<y); } 
ymag(y) { dir=270;while(loc_y(m())>y); } 
ymin(y) { dir=90;while(loc_y(m())<y); } 

m()
{
     spara(drive(dir,100));
}

s()
{
     spara(drive(dir,0));
}

