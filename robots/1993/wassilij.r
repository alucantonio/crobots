/* 
   -------------------------------------------------------------------------
                                  Wassilij   
   -------------------------------------------------------------------------

   Programmato da:

      Sven Cotella

      Paolo Cagnotti

   Il Crobot si muove lungo i bordi del campo di battaglia in senso orario.
   L' algoritmo di sparo cambia il range tentando di prevedere la posizione
   degli avversari, confrontandone le posizioni assunte durante lo scontro,
   limitando tuttavia l'intervallo di scansione per accrescere la precisione.
*/

int curr_dist, prev_dist, curr_ang;

main()
{
 int dir;

 curr_dist = 200;

 while(1)
 {
  drive(0, 100);
  while(loc_x()<930)
   seek_and_destroy(170, 370);
  drive(0,0);
  while(speed()>49)
   seek_and_destroy(170, 370);

  drive(270, 100);
  while(loc_y()>70)
   seek_and_destroy(80, 280);
  drive(270,0);
  while(speed()>49)
   seek_and_destroy(80, 280);      

  drive(180,100);
  while(loc_x()>70)
   seek_and_destroy(350, 550);
  drive(180,0);
  while(speed()>49)
   seek_and_destroy(350, 550);

  drive(90,100);
  while(loc_y()<930)
   seek_and_destroy(260, 460);
  drive(90,0);
  while(speed()>49)
   seek_and_destroy(260, 460);

 }
}

seek_and_destroy(from, to)
int from, to;
{
    if ( curr_dist = scan(curr_ang, 8) ) {
        cannon(curr_ang, curr_dist+(curr_dist-prev_dist));
        prev_dist = curr_dist;
        curr_ang += 16;
    } else {
        curr_ang -= 16;
        if (curr_ang < from)
            curr_ang = to;
    }

}
