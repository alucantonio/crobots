/*
   TATTICO
   Programmato da Vidali Matteo
*/

int ang,range;
main()  
{
        ang=0;            /* Si dirige lungo il bordo sinistro */
        drive(180,100);        
        while(loc_x()>40)
                spara();
        drive(90,0);
        while(speed()>49)
                spara();
        ang=270;
        
        while(1)  {        /* Si muove verticalmente */
                drive(90,100);
                while(loc_y()<920)
                        spara();
                drive(270,0);
                while(speed()>49)
                        spara();
                drive(270,100);
                while(loc_y()>80)
                        spara();
                drive(90,0);
                while(speed()>49)
                        spara();
        }
}

spara()    /* routine di sparo */
{
        int newrange,oldrange;
        if (((newrange=scan(ang,10))<=700) && (newrange>0))  {
                if (oldrange<newrange)  {     /* aggiusta il tiro */
                        cannon(ang,11*newrange/10);
                } else   {
                        cannon(ang,10*newrange/11);
                        oldrange=newrange;
                }
        }  else  {
                ang+=20;
                if ((ang>=110)  && (ang<270))
                        ang=270;
        }
}

