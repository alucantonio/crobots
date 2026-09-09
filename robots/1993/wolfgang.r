/* 
   -------------------------------------------------------------------------
                                  Wolfgang  
   -------------------------------------------------------------------------

   Programmato da:

      Paolo Cagnotti

      Sven Cotella

   Il robot si muove a partire dall'angolo in alto a sinistra, verso destra,
   lungo il lato superiore, fino alla met… del lato stesso. Scende quindi in
   verticale fino al lato inferiore, spostandosi poi fino all'angolo in bas-
   so a destra. Di qui il robot sale fino alla met… del lato destro, si muo-
   ve indi verso sinistra fino a raggiungere il lato sinistro, per poi risa-
   lire fino all'angolo in alto a sinistra e ricominciare da capo il suo mo-
   vimento.
   L' algoritmo di sparo cambia il range tentando di prevedere la posizione 
   degli avversari, confrontandone le posizioni assunte durante lo scontro.
*/

int ang,currdis,prevdis;

main()
{
 ang=0;
 while (1)
    {
     drive(180,100);
     while (loc_x()>100)
        feuer();
     drive(180,0);
     while (speed()>49)
        feuer();
     drive(90,100);
     while (loc_y()<900)
        feuer();
     drive(90,0);
     while (speed()>49)
        feuer();
     drive(0,100);
     while (loc_x()<450)
        feuer();
     drive(0,0);
     while (speed()>49)
        feuer();
     drive(270,100);
     while (loc_y()>100)
        feuer();
     drive(270,0);
     while (speed()>49)
        feuer();
     drive(0,100);
     while (loc_x()<900)
        feuer();
     drive(0,0);
     while (speed()>49)
        feuer(); 
     drive(90,100);   
     while (loc_y()<450)
        feuer();
     drive(90,0);
     while (speed()>49)
        feuer();
    }     
} 

feuer()
{
 if (currdis=scan(ang,9))
    {
     if (prevdis<currdis)
        cannon(ang,8*currdis/7);
     else
        cannon(ang,6*currdis/7);
     prevdis=currdis;
    }
 else
    ang+=18;
}
