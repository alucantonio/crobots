/**************
 *            *
 * B A C K .r *
 *            *
 **************

 Mini robot per il torneo 2006/2007

 Michelangelo Messina


We're ready for this.

*/


/*
Il minirorobot e' un tentativo di riduzione dei macro
discendenti diretti di shock.r
E' una minima evoluzione di blitz.r, di cui eredita tutti i difetti.
Il risultato e' abbastanza scadente... ma non so fare di meglio!
La modifica principale Š il cambio di routine di fuoco.
E' risultato quasi un gemello omozigota dello scarsissimo unlimited.r

All'avvio si posiziona nell'angolo piu' vicino, e oscilla verticalmente
e orizzontalmente, senza restare mai fermo.
Se viene colpito e i danni sono ingenti, controlla se c'e' un angolo
libero. In caso affermativo ci si reca.
Quando ne rimane uno solo attacca con un movimento a rettangolo
al centro dell'arena.

La routine di fuoco e' spudoratamente copiata da Danica.r
*/



int     dam; /*percentuale di danni attuale*/
int     deg,odeg,x;
int     up,dx;
int     dir;
int     sc1,sc2,ff;





main()
{
    dove(attacco(sc1=sc2=1));
    while (dam=damage()+10) {
        while ( damage() < dam ) { /*fino quando non e' colpito o limite di tempo*/
                if (dx) {
                        deg=180;
                        xmag(850);
                        s(xmin(915));
                } else {
                        deg=360;
                        xmin(150);
                        s(xmag(85));
                }

                if (up) {
                        deg=270;
                        ymag(850);
                        s(ymin(915));
                } else {
                        deg=90;
                        ymin(150);
                        s(ymag(85));
                }
		
                attacco(dir=x=0);
        }

	/* ricerca di un angolo libero */
        if(up) {
                if(occupato(260)) fuggi();
                else dove(ymag(110));
   	} else {
                if(occupato(80)) fuggi();
                else dove(ymin(890));
	}

    }
}

fuggi()
{
        if(dx) {
                if(occupato(170)); else dove(xmag(110));
        } else {
                if(occupato(350)); else dove(xmin(890));
        }
}

attacco()
{
                while((dir+=20)!=380) x+=(!scan(dir,10));
                if (x>16) {
                        sc1=5; sc2=3;  ++ff;  
                        while(1) {ymag(300);xmin(800); ymin(700);xmag(200); }
                }
}


dove()
{
dx=(loc_x(up=(loc_y()>500))>500);
}

int occupato(i)
/* restituisce 1 se ci sono nemici nella direzione i */
int i;
{
        return(((scan(i,10))||(scan(i+20,10))));
}
/* spostamento */
xmag(y) { while(loc_x(m(dir=180))>y); } 
xmin(y) { while(loc_x(m(dir=360))<y); } 
ymag(y) { while(loc_y(m(dir=270))>y); } 
ymin(y) { while(loc_y(m(dir=90))<y); } 

m()
{
     spara(drive(dir,100));
}

s()
{
     spara(drive(dir,0));
}




spara()
{
  if (x=scan(odeg=deg,10))  
  {    
    if (scan(deg+350,10)) deg-=sc1; else deg+=sc1;
    if (scan(deg+10,10)) deg+=sc2; else deg-=sc2; 
    cannon(deg+(deg-odeg)*ff,(scan(deg,10)<<1)-x);
  } else {
      if (x=scan(deg+=340,10)) return cannon(deg,x); 
      if (x=scan(deg+=40,10))  return cannon(deg,x);  
      while (!(x=scan(deg+=20,10))) ; 
  }
}
