/**************
 *            *
 * B E A T .r *
 *            *
 **************

 Mini robot per il torneo 2012

 Michelangelo Messina


Il minirorobot e' un tentativo di riduzione dei macro
discendenti diretti di shock.r
E' una minima evoluzione di PAIN.r, di cui eredita tutti i difetti.
Il risultato e' abbastanza scadente... ma non so fare di meglio!


All'avvio si posiziona nell'angolo piu' vicino, e oscilla verticalmente
e orizzontalmente, senza restare mai fermo.
Se viene colpito e i danni sono ingenti, controlla se c'e' un angolo
libero. In caso affermativo ci si reca.
Quando ne rimane uno solo attacca con un movimento a rettangolo
al centro dell'arena.

La routine di fuoco e' spudoratamente copiata da Danica.r


Qualcuno un giorno mi spiegherà come si fa a scrivere un crobots decente in 500 istruzioni macchina...

*/



int     dam; /*percentuale di danni attuale*/
int     deg,odeg,x;
int     up,dx;
int     dir;
int     sc1,sc2,ff;
int     b;





main()
{
    dove(attacco());
    sc1=sc2=1;
    while (dam=damage()+6) {
        while ( damage() < dam ) { /*fino quando non e' colpito o limite di tempo*/
                if (dx) {
                        deg=180;
                        xmag(885);
                        s(xmin(920));
                } else {
                        deg=360;
                        xmin(115);
                        s(xmag(80));
                }

                if (up) {
                        deg=270;
                        ymag(885);
                        s(ymin(920));
                } else {
                        deg=90;
                        ymin(115);
                        s(ymag(80));
                }
		
                if(b^=1) attacco(dir=x=0);
        }

	/* ricerca di un angolo libero */
        if(up) {
                if(occupato(260)) fuggi();
                else dove(ymag(80));
   	} else {
                if(occupato(80)) fuggi();
                else dove(ymin(920));
	}

    }
}

fuggi()
{
        if(dx) {
                if(occupato(170)); else dove(xmag(80));
        } else {
                if(occupato(350)); else dove(xmin(920));
        }
}

attacco()
{
                while((dir+=20)!=380) x+=(!scan(dir,10));
                if (x>16) {
                        sc1=5; sc2=3;  ff=1;  
                        while(1) {ymag(360);xmin(640); ymin(640);xmag(340); }
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
xmag(y) { while(loc_x(m(180))>y); } 
xmin(y) { while(loc_x(m(360))<y); } 
ymag(y) { while(loc_y(m(270))>y); } 
ymin(y) { while(loc_y(m(90))<y); } 

m(dir)
{
     spara(drive(dir,100));
}

s(dir)
{
     spara(drive(dir,0));
}




spara()
{
  if (x=scan(odeg=deg,10))  
  {    
    if (scan(deg+350,10)) deg-=sc1; else deg+=sc1;
    if (scan(deg+10,10)) deg+=sc2; else deg-=sc2; 
    cannon(deg+(deg-odeg)*ff, (scan(deg,10)<<1)-x);
  } else {
      if (x=scan(deg+=340,10)) return cannon(deg,x); 
      if (x=scan(deg+=40,10))  return cannon(deg,x);  
      while (!(x=scan(deg+=20,10))) ; 
  }
}

