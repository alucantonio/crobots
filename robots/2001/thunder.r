/************************
 *                      *
 *  T H U N D E R .r    *
 *                      *
 ************************


 Micheldegelo Messina


        'cause my heart goes BOOM


*/



/*
Il microrobot e' un tentativo di riduzione del macro
touch.r
Il risultato e' estremamente scadente...

Si posiziona nell'angolo piu' vicino e oscilla lungo la bisettrice.
Quando ne rimane uno solo attacca con un movimento orizzontale
al centro dell'arena.

La routine di fuoco e' molto primitiva, con correzioni sull'angolo
e sulla distanza.
*/



int rng, deg;     /* Distanza e Gradi          */
int dir;               /* La mia direzione          */
int ne;                /* Numero avversari          */
 
int dam;
int i,b;
int x,y;
int t,att;

main()
{
    x=80+840*(loc_x(spara(att=1))>500);
    y=80+840*(loc_y()>500);

    
      while (dam=damage(vai())+20) {
         while ( damage(i=7) < dam ) { /*fino quando non e' colpito o limite di tempo*/
                                        /*oscilla (7);*/
                while (--i) {
                        m(dir-=180);
                        while (loc_y()<=y) m(dir); 
                        m(dir+=180);
                        while (loc_y()>y) m(dir);
                }
                drive (dir,0);
                if(!rng) {
                        i=-10; ne=0;
                        while (i<360) {
                                if (scan (i+=20, 10)) ++ne;
                        }
                        if (ne<2) {
                                if (damage(att=0)<90) {
                                 ymin(450);ymag(550);
                                 while(1) {xmin(800); xmag(200); }
                                }
                        }
                }
         }
         if(y>500) {
                if(libero(260)) y=110;
                else fuggi();
         } else {
                if(libero(80)) y=890;
                else fuggi();
         }

      }
}

fuggi()
{
        if(x>500) {
                if(libero(170)) x=110;
        } else {
                if(libero(350)) x=890;
        }
}

int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(!((scan(i,10))||(scan(i+20,10))));
}

vai() {
    if(x>500) xmin(915); else xmag(85);
    if (y<500) {
        ymag(85);
        if (x<500) {return dir=225;}
        else {return dir=315;}
    } else {
        ymin(915);
        if (x<500) {return dir=315;}
        else {return dir=225;}
    }
}
                 
xmag(y) { while(loc_x(m(180))>y); }
xmin(y) { while(loc_x(m(360))<y); } 
ymag(y) { while(loc_y(m(270))>y); } 
ymin(y) { while(loc_y(m(90))<y); } 

m(dir)
{
     spara(drive(dir,100));
}

spara()
{ 
        if (!(rng=scan(deg,10)))
        if (!(rng=scan(deg-=20,10)))
        if (!(rng=scan(deg+=40,10))) {return deg+=40;}
        cannon (deg+=7*(!(scan(deg+356,7)))+353*(!(scan(deg+4,7))), 2*scan(deg,10)-rng );      
        if(att) if(rng>810) return(deg+=47);
} 

