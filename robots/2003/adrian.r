/*
Adrian.r
Midi robot per il torneo 2003

Scritto da:
Angelo Ciufo


Il robot e' una versione compatta del macro Dave.r
Si reca nell'angolo piu' vicino, e oscilla con un movimento a 45ø.
Se c'e' un unico superstite attacca con le routine di Pippo2a.
Stesso discorso se, dopo 820 chiamate alle funzioni di sparo,
e' in condizioni decenti e ha al max 2 avversari.
*/



int rng, deg;     /* Distanza e Gradi          */
int orng, odeg;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int ne;                /* Numero avversari          */

int i;
int x,y;
int t;

main()
{
    vai (x=100+800*(loc_x (ne=3)>500),y=100+800*(loc_y ()>500));
   
            while (1) {

                if(!orng||orng>850) {
                        i=-10; ne=0;
                        while (i<360) {
                                if (scan (i+=20, 10)) ++ne;
                        }
                        if (ne<2) {
                                boom ();
                        } else if(t>620) { 
                                if((ne<3) && (damage()<60)) boom();
                                else if(damage()<40) boom();
                                else t=0;

                        }
                } 
                                        /*oscilla (9);*/
                i=9;
                while (--i) {
                        spara(drive (dir,100));
                        while (loc_y()<=y) spara(drive (dir,100)); 
                        dir+=180;
                        spara(drive (dir,100));
                        while (loc_y()>=y) spara(drive (dir,100)); 
                        dir-=180;
                }
                drive (dir,0);
            }
                                        /*move ();*/
}


vai (x,y)
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>12000) fuoco(drive (dir,100));
    while (dist(x,y)>1600) drive (dir,100);
    stop();
    if (y<500) { 
        if (x<500) {dir=135;}
        else {dir=45;}
    } else { 
        if (x<500) {dir=45;}
        else {dir=135;}
    }

}

/* Angolo per andare in una certa direzione */
deg(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }


spara()
/* routine di sparo*/ 
{ 
        ++t; 
        if ((orng=scan(deg, 10)) ) { 
                if (scan(deg-8,4)) { 
                        if (scan(deg-=8+3,2)) { 
                                if(scan(deg+=3-2,1)) deg-=2; 
                        }  else if (scan(deg-3,2)) deg-=3;
                } else if(scan(deg+8,4)) { 
                        if (scan(deg+=8+3,2)) deg+=3;
                }  else if(scan(deg+2,2)) deg+=2; 

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-8,4)) { 
                        if (scan(deg-=8-3,2)) deg-=3;
                } else if(scan(deg+7,4)) deg+=7; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+7,4)) deg+=7;
        }  else if (!(orng=scan(deg+=20,10))) { 
                if ((orng=scan(deg+=21,10))) { 
                        if (orng>850) { 
                                cannon(deg,700); 
                                return deg+=57; 
                        } 
                } else if (!(scan(deg+=21,10))) return deg+=40; 
	} 
        if (rng=scan(deg,10)){  
                cannon (deg, rng*165/(165+orng-rng) ); 
                if(rng>720) if(rng>orng || rng>850) {
                                return orng=0;
                        }

        }  else if(scan(deg-20,10)) deg-=20; 
        else if(!scan(deg+=21,10)) deg+=57; 
} 

boom()
{

 while(1)
 {
  sx(350);
  dx(650);
 }
 
}

dx(xx)
 {
  while(loc_x()<xx) vs(00);
  stop();
 }
sx(xx)
 {
  while(loc_x()>xx) vs(180);
  stop();
 }


vs(xx)
 {
  fuoco(drive(dir=xx,100));
 }


stop()
 {
  drive(dir,0);
  while(speed()>50);
 }


fuoco() {
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=20,10));
    else if (orng=scan(deg+=40,10));
    else return deg+=41; 
    { 
        if (orng>850)  {return deg+=41;}
        if (!scan(deg+=354,6)) deg+=12; 
        if(scan(deg-6,2)) deg-=6; 
        else if(scan(deg+6,2)) deg+=6;
        fnd();
        if (orng=scan(odeg=deg,10)) 
        { 
           if(scan(deg-7,3)) deg-=7; 
           else if(scan(deg+7,3)) deg+=7;
           fnd(); 
           if (rng=scan(deg,10)) 
           { 
                cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12))); 
           } 
 
        } 
     } 
} 



fnd()
{
 if(scan(deg-4,1)) deg-=4;
 if(scan(deg+4,1)) deg+=4; 
 if(scan(deg-2,1)) deg-=2; 
 if(scan(deg+2,1)) deg+=2; 
}
