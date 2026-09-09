/* 
   EMANUELA 
   Programmata da Vidali Matteo
*/


int ang,range;

main()  
{                            /* loop per movimento verticale e fuoco */
        while(1)  {       
                drive(90,100);
                while(loc_y()<920)
                        fire();
                drive(270,0);
                while(speed()>49)
                        fire();
                drive(270,100);
                while(loc_y()>80)
                        fire();
                drive(90,0);
                while(speed()>49)
                        fire();
        }
}


fire()
{
        if (((range=scan(ang,5))<=700) && (range>0))  /* condizioni fuoco */
                cannon(ang,range);
        else ang+=10;

}

