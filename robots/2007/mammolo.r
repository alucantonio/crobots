/*
Nome            : Mammolo - macro
Versione        : 1.0
Autore		: Simone Ascheri

Preludio
========
Biancaneve si Š smarrita nel bosco.
trova la casetta dei sette nani e ci si stabilisce.
Mammolo non Š molto contento e torna a casa dalla mamma, a cui era molto affezionato perche' alla tenera et… di 3 anni gi… gli aveva trovato un'occupazione, mandandolo a lavorare in miniera.

Commento
========

Trattasi di Fizban... aggiornato????
Ho cambiato qualche costante ma non ho nemmeno testato
*/

int vel,r_coord,x_pos,y_pos;
int ang,oang,a,r,or;
int time,run,d,gradi,conta;
int si,z,oa,lim,cl;

main()
{
        r_coord=822;
        while (run+=conta=gradi=3)
             {
                if (damage()>80) r_coord=837;
                x_pos=(loc_y(y_pos=(loc_x()<(vel=500))*(r_coord-=15*(++time>6)))<500)*r_coord;
                while ((loc_x()%890)>110) CucchiaioKender(ang=(loc_x()<500)*180);
                vel=0;
                CucchiaioKender(ang);
                while ((loc_y(vel=100)%890)>110) CucchiaioKender(ang=90+(loc_y()<500)*180);
                vel=0;
                CucchiaioKender(ang);
                while (((gradi+=21)<390)&&(conta<12))  if (scan(gradi,10)>0) {++conta;CucchiaioKender(a=ang=gradi);}
                vel=100;
                while (conta<5)
                     {
                        if (((loc_x()%800)<200)||((loc_y()%800)<200))
                          {
                            si=45+180*(loc_y()>500)+90*((loc_x()>500)!=(loc_y()>500));
                          if (((z=(ang-si)%360)*z)>0)
                              {
                                C(vel=0);
                                ang=si;
                                C(C(vel=100));
                              }
                          }
                        else if (r>700)
                          {
                            if (((z=(ang-a)%360)*z)>25)
                              {
                                C(vel=0);
                                ang=a;
                                C(C(vel=100));
                              }
                          }
                        else if ((speed()>80))
                             {
                                C(vel=0);
                                ang+=180;
                                C(C(vel=100));
                             }
                        C();
                     }
                while (--run)
                     { 
                        while(loc_y() <910-x_pos) CucchiaioKender(90);
                        while(loc_x() >r_coord-y_pos+90) CucchiaioKender(180);
                        while(loc_y() >r_coord-x_pos+90) CucchiaioKender(270);
                        while(loc_x() <910-y_pos) CucchiaioKender(0);
                     }

             }
}

CucchiaioKender(dir)
int dir;
  {
     drive (dir,vel);
     if((r=scan(a,10))&&(r<850))
        {
           if (r=scan(a,4));
           else if (r=scan(a-=7,3));
           else if (r=scan(a+=14,3));
           else return;
           cannon (a,r);
        }
     else
       if(scan(a+=21,10));
       else
         if(scan(a-=42,10));
         else
           if(scan(dir,10)) a=dir;
           else
             return (a+=84);
  }  

C()
  {
     drive (ang,vel);
     if(or=scan(oa=a,10))
        {
           if (r=scan(a,4)) return cannon(a,3*scan(a,10)-r-or);
           else if (r=scan(a-=7,3)) return cannon(a-6,3*scan(a,10)-r-or);
           else if (r=scan(a+=16,4)) return cannon(a+6,3*scan(a,10)-r-or);
           else return 1;
        }
     else
       if(scan(a+=21,10));
       else
         if(scan(a-=42,10));
         else
         return (a+=84);
  }  

