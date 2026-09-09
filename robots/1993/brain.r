/************************************************************************
 * Nome Robot: BRAIN                                                    *
 * Dati Autore:                                                         *
 * VIDALI MATTEO                                                        */


/* brain.r */


int newx,newy,ang;

main()
{
        int direz,danno,x,y;
        
        
        /*Inizio prima strategia*/
        
        direz=muovi(100,600);

        while(danno<=25)  {    /*limite-danno prima strategia*/
                /*movimento lungo una diagonale minore*/
                
                drive(direz,100);
                while(loc_x()>100 && speed())  {
                        fire1();
                }

                direz=muovi(400,900);

                while(speed()>50)  {
                        drive(direz,50);
                }

                drive(direz,100);
                while(loc_y()<900 && speed())  {
                        fire1();
                }

                direz=muovi(100,600);

                while(speed()>50)  {
                        drive(direz,50);
                }

                danno=damage();  /*controlla danno per cambiare strategia*/
        }
                
        
        
        /*Inizio seconda strategia(ved. anche RAND.R)*/       
        
        x=loc_x();y=loc_y(); /*setta posiz. correnti*/
        
        newxy(); /*nuove coordinate calcolate in modo random*/
        
        direz=muovi(newx,newy);  /*calcola angolo per spostamento*/

        while(danno<=60)  {  /*limite-danno seconda strategia*/
                drive(direz,100);  
                if (newx<x)  {  /*controlla e realizza spostamento*/
                        if (newy<y)  {
                                while(loc_x()>newx && loc_y()>newy && speed())  fire2();
                        } else  while(loc_x()>newx && loc_y()<newy && speed())  fire2();
        
                } else {
                        if (newy<y)  {
                                while(loc_x()<newx && loc_y()>newy && speed())  fire2();
                        } else  while(loc_x()<newx && loc_y()<newy && speed())  fire2();

                }
                
                newxy();   /*altre coordinate random*/
                direz=muovi(newx,newy);  /*nuovo angolo*/
                while(speed()>50)  {    /*decrementa velocit… per cambiare direzione*/
                        drive(direz,50);
                } 
                
                danno=damage();  /*controlla danno per cambiare strategia*/
        }

        /*Inizio terza ed ultima strategia*/

        drive(180,0);      /*movimento verticale lungo bordo sinistro*/
        while(speed()>50)  {
                fire3();
        }
        
        drive(180,100);
        while(loc_x()>80)  {
                fire3();
        }

        drive(90,0);
        while(speed()>50)  {
                fire3();
        }
        
        ang=270;

        while(1)  {
                drive(90,100);
                while(loc_y()<920)  {
                        fire3();
                }
        
                drive(270,0);
                while(speed()>50)  {
                        fire3();
                }

                drive(270,100);
                while(loc_y()>80)  {
                        fire3();
                }
        
                drive(90,0);
                while(speed()>50)  {
                        fire3();
                }
        }
}


newxy() /*funzione che calcola nuove coordinate*/
{
        newx=rand(700);  /* 300 e 700 sono i limiti dello spostamento*/
        if (newx<300) newx=300;
        
        newy=rand(700);
        if (newy<300) newy=300;
}
                            


muovi(x,y)    /*funzione che calcola angolo per spostamento*/
int x,y;
{
        int gradi,pos_x,pos_y;
        pos_x=loc_x();
        pos_y=loc_y();

        if (pos_x==x)  {
                if (y<pos_y)  gradi=270;
                else gradi=90;
        }  else  {
                if (y<pos_y) {
                        if (x>pos_x)
                                gradi=360+atan((100000*(pos_y-y))/(pos_x-x));
                        else    gradi=180+atan((100000*(pos_y-y))/(pos_x-x));
                } else if (x>pos_x)
                         gradi=atan((100000*(pos_y-y))/(pos_x-x));
                       else  gradi=180+atan((100000*(pos_y-y))/(pos_x-x));
        }
        return(gradi);
}


fire1()  /*fuoco per prima strategia*/
{
        int range;
        
        if (range=scan(ang,3))  
                cannon(ang,7*range/8);
        else  {
                ang-=23;
                while(!(range=scan(ang,10)))
                        ang+=20;
                if (range<60)
                        range=60;
                cannon(ang,7*range/8);
        }
}


fire2()    /*semplice funzione di sparo per seconda strategia*/
{
        int range;
        
        if (range=scan(ang,10))
                cannon(ang,range);
        else ang+=20;

}


fire3()    /*fuoco intelligente per terza strategia*/
{
        int newrange,oldrange=0;
        
        if(newrange=scan(ang,10))  {
                if (oldrange<=newrange)  {
                        cannon(ang,8*newrange/7);
                        oldrange=newrange;
                }  else  {
                        cannon(ang,7*newrange/8);
                        oldrange=newrange;
                }
        }  else  {
                ang+=20;
                if ((ang>=110)  && (ang<270))
                        ang=270;
        }
}


