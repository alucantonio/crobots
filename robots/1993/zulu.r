/* --------------------------------------------------------
   Algoritmo ZULU, programmato da Marco Zora 
   -------------------------------------------------------- */


int dist,ang,par;

main()
{
int danni=0;

/* --------------------------------------------------------
   Tattica n.1 Rotazione condizionata in senzo orario.
   -------------------------------------------------------- */

while(danni<40) {
                Vai_a(60,60);
                danni=damage()+2;
                while(damage()<danni) Azione(0,90);

                Vai_a(940,940);
                danni=damage()+2;
                while(damage()<danni) Azione(180,270);
                }

/* --------------------------------------------------------
   Tattica n.2 Rotazione libera in senzo orario.
   -------------------------------------------------------- */

while(1) {                
                Vai_a(80,80);
                Vai_a(920,920);
          } 
}


/* --------------------------------------------------------
   Routine di spostamento e controllo bersaglio.
   Il range dello scanner viene modificato in base al movimento di ZULU,
   calcolando il quadrante(i) dove il bersaglio pu• trovarsi ed
   escludendo gli altri.
   -------------------------------------------------------- */

Vai_a(x,y) 
{
if(loc_y() > y) { while(loc_y() > y ) { drive(270,100); Azione(90,270); }
                  drive(0,0);
                  while(speed()>49) Azione(90,180);
                  }
           
           else { while(loc_y() < y ) { drive(90,100); Azione(270,450);  } 
                  drive(0,0);
                  while(speed()>49) Azione(270,360);
                  }

if(loc_x() > x) { while(loc_x() > x ) { drive(180,100); Azione(0,180);   }
                  drive(0,0);
                  while(speed()>49) Azione(0,90);
                  }         
                  
           else { while(loc_x() < x ) { drive(0,100); Azione(180,360);  }
                  drive(0,0);
                  while(speed()>49) Azione(180,270);
                  }
}

                                                          
/* --------------------------------------------------------
   Controlla se il bersaglio rientra nel range iniz-fine, 
   effettua una correzione grossolana supponendo di essere
   inseguito e spara.
   -------------------------------------------------------- */

Azione(iniz,fine)
{
if( dist=scan(ang,par) ) { cannon(ang,dist-25); ang-=6*par;  }
                         
                            if(ang < fine) ang+=par+par;
                            else ang=inizio;
                         
                            if(dist<200) par=10;
                            else par=2;
                            }

/* --------------------------------------------------------
  
   -------------------------------------------------------- */

