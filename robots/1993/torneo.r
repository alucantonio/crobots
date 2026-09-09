/*
  Sabbioni Luca

  Il "robot" si muove lungo la diagonale secondaria del campo di battaglia
  scandagliandolo a 360 gradi. La routine di sparo provvedde a modificare 
  il range del cannone in funzione della differenza delle distanze dai robot
  nemici rilevate precedentemente.
*/


int range,orange,dir;


main()

{
 /* movimento che permette al robot di raggiungere 
    l'angolo in alto a sinistra */
  
  dir=5;
  drive(180,100);
  while (loc_x()>70) hit();
  drive(180,0);
  while (speed()>49) ;       
  drive(90,100);
  while (loc_y()<940) hit();
  drive(90,0);


  while (1)   /* ciclo principale */
   {
     while (speed()>49) ;
     
     /* movimento in diagonale dall'alto verso il basso */     

     drive(315,100);
     while (loc_y()>80 && speed()>0) hit(1);
     drive(315,0);
     while (speed()>49) ;

     /* movimento in diagonale dal basso verso l'alto */     

     drive(135,100);
     while (loc_y()<920 && speed()>0) hit(0);
     drive(135,0);
    }
}

hit(ddir)    /* procedura di sparo */
{
  int ddir;    

  if ((range=scan(dir,10)))
   {
    if (range==orange)   
       if (ddir)
       {
        if (sin(dir)>0 && cos(dir)<0) cannon(dir,7*range/8);
        else if (sin(dir)<0 && cos(dir)<0) cannon(dir,8*range/7);
              else cannon(dir,range);
       }  
       else
       {
         if (sin(dir)>0 && cos(dir)<0) cannon(dir,8*range/7);
         else if (sin(dir)<0 && cos(dir)<0) cannon(dir,7*range/8);
               else cannon(dir,range);
       }

    if (range>orange) cannon(dir,10*range/9);
    if (range<orange) cannon(dir,7*range/8);
    orange=range;
   } 
    else dir+=20;
}
          


