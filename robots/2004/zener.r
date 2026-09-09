/*
ZENER.r
Midi robot per il torneo 2004

Scritto da:
Angelo Ciufo


Il robot e' una versione compatta del macro Dave.r
Si reca nell'angolo piu' vicino, e oscilla con un movimento a 45ø.
Se c'e' un unico superstite attacca con le routine di Pippo3.
Stesso discorso se, dopo 620 chiamate alle funzioni di sparo,
e' in condizioni decenti.
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
    boom(damage(ne=3)+10);
   
            while (1) {

                if(!orng||orng>850) {
                        i=-10; ne=0;
                        while (i<360) {
                                if (scan (i+=20, 10)) ++ne;
                        }
                        if (ne<2) {
                                boom (101);
                        } else if(t>620) { 
                                if((ne<3) && (damage()<60)) boom(80);
                                else if(damage()<40) boom(60);

                        }
                } 
                                        /*oscilla (9);*/
                i=9;
                while (--i) {
                        spara(drive (dir,100));
                        while (loc_y()<=y) spara(drive (dir,100)); 
                        spara(drive (dir+=180,100));
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
                                return deg+=57;
                        }

        }
}

boom(att)
{
 x=100+800*(loc_x ()>500);
 y=100+800*(loc_y ()>500);

 while(damage()<att)
 {
  dx(sx());
 }
 vai(x,y); 
}

dx()
 {
  while(loc_x()<650) vs(00);
  stop();
 }
sx()
 {
  while(loc_x()>350) vs(180);
  stop();
 }


vs(xx)
 {
  fuoco(drive(dir=xx,100));
 }


stop()
 {
  while(speed(drive(dir,0))>50);/* Fire(0);*/
 }


fuoco() {
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=20,10));
    else if (orng=scan(deg+=40,10));
    else return deg+=41; 
    { 
        if (!scan(deg+=354,6)) deg+=12; 
        fnd();
        if (orng=scan(odeg=deg,10)) 
        { 
           fnd(); 
           if (rng=scan(deg,10)) 
           { 
                cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12))); 
                return deg+=41*(orng>850);/*if (orng>850)  deg+=41;*/
           } 
 
        } 
        else
          {
           if (!(orng=scan(deg+=339,10)))
            {
             if (!(orng=scan(deg+=41,10)))
              {
               if(!(orng=scan(deg+=21,10)))
                {
                 return deg+=41; 
                } 
             } 
           } 
          cannon (deg, 2*scan(deg,10)-orng);
         }
   }
} 



fnd()
{
 if(scan(deg-7,3)) deg-=7; 
 if(scan(deg+7,3)) deg+=7;
 if(scan(deg-4,1)) deg-=4;
 if(scan(deg+4,1)) deg+=4; 
 if(scan(deg-2,1)) deg-=2; 
 if(scan(deg+2,1)) deg+=2; 
}
