/*                         T I T A N I A   2                        */

/* 30/9/99 */
/* Ale: Ciao Tom, hai pronto il robot?  */
/* Tom: Guarda che studio ingegneria meccanica, ma sono solo al */
/*      secondo anno...   */
/* Ale: Ma no, parlavo di crobots...  */
/* Tom: Per dindirindina (eufemismo) e' vero quanto tempo ho? Un' ora? */
/* Ale: Tranquillizzati, quest' anno e' il 30 Novembre, ma fallo ora */
/*      che poi ti dimentichi...
/* Tom: OK */

/* 30/11/99 */
/* Ale: Ciao Tom, hai pronto il robot?  */
/* Tom: Guarda che studio ingegneria meccanica, ma sono solo al */
/*      secondo anno...   */
/* Capite ora perche' Titania2 assmigli cosi' tanto al paparino? */

/*                                                                 */
/* (Finto) Programmatore:                                          */
/*                       Tommaso De Pra                            */


int x,y,d,ang,dir,oldr,pausa,dam,range,t,l;

main()
{
        vai(850,950);
        while(speed());
        t=100;
        dam=damage();
        l=800;     
        while (t)      
        {
                vibra(l);
                --t;
        }
        vai(500,900);
        while(speed());
        cecchina();
}

vibra(cen)
                        /* Essendo un robot vibrante... */ 
{
while(loc_x()>cen) {drive(180,100);mosso();}
while(speed()>49) {drive(180,0);mosso();}
while(loc_x()<cen) {drive(0,100);mosso();}
while(speed()>49) {drive(0,0);mosso();}
}

 
mosso()
                      /* routine di sparo in movimento */
{
        int     range,sfas;

        if (!oldr) 
                /* routine semplificata se non trova il nemico */ 
        {
                while (!(range = scan(ang += 20, 10)) );
                if (scan(ang-7,4)) ang-=9;
                else if(scan(ang+7,4)) ang+=9;
                if (oldr=scan(ang,10)) cannon(ang,oldr);
                return;
        }

                /* altimenti usa la routine consueta */
        if (!(range = scan (ang, 3))) {
                if (range = scan(ang -=6, 3)) sfas = -4;
                else if (range = scan(ang +=12, 3)) sfas = 6;
                else if (range = scan(ang -=19, 4)) sfas = -8;
                else if (range = scan(ang +=26, 4)) sfas = 8;
                else if (range = scan(ang -=38, 8)) sfas = -13;
                else if (range = scan(ang +=50, 8)) sfas = 9;
                else {
                        oldr=0;
                        return;
                }
        }
        else sfas=4;

        if (range<710) cannon(ang + sfas, range);
        else if (range>oldr) {
                ang+=10;
                oldr=0;
                return;
        } 

        oldr=range;
}


vai(tx,ty)            
                         /* Ruotine di posizionamento */
{
x=loc_x()-tx;
y=(loc_y()-ty)*100000;
if (tx>loc_x()) dir=360+atan(y/x); else dir=180+atan(y/x);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>8100) { drive(dir,100); mosso(); }
drive(dir,49);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>225);
drive(180,0);
while (speed()>49) drive(180,0);
}

cecchina()
                        /* Routine di sparo con la carabina */
{
 while(1)   
  {
   drive(315,100); while(loc_x()<900) attacco();   
   drive(315,0);   fuocovel();
   drive(225,100); while(loc_y()>100) attacco();
   drive(225,0);   fuocovel();
   drive(135,100); while(loc_x()>100) attacco();
   drive(135,0);   fuocovel();
   drive(45,100);  while(loc_y()<900) attacco();
   drive(45,0);    fuocovel();
  } 
}

                          /* Routine di attacco normale */
attacco() 
{  
 if ( (d=scan(ang,10)) && (d<750) ) 
  { 
   if (d=scan(ang+353,6)) cannon(ang+=353,d);
   else if (d=scan(ang,6)) cannon(ang,d);
   else if (d=scan(ang+7,6)) cannon(ang+=7,d); 
  }
 else
  {
   if ((d=scan(ang+21,10))&&(d<700)) {ang+=21;}
  }  
}                         

                         /* Routine di fuoco veloce */
fuocovel()
{     
 while (speed() > 49) if ((d=scan(ang,10))) cannon(ang,d); 
                      else ang+=21;
}                               
                        /* FINE...soltanto per ora !!! */

