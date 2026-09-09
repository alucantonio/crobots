
/* Robot Beast.r per CRobots        4 / 9 / 1993

   Scritto da:
   Mario Gregori

*/


int sc_dir, sfas, oldd, dist, dist2, scd2, i, danni;


main()
{
   sc_dir = 0;

   while (1)
   {
      stay();
      vai();
   }
}


/* movimento in una direzione casuale */

vai()
{
   int move_dir;

   move_dir = rand(80) + 5;    /* calcola la direzione */
   if (loc_x() > 500)
      move_dir += 90;
   if (loc_y() > 500)
      move_dir += 2 * (180 - move_dir);

   while (speed() > 49) look();
   drive (move_dir, 80);
   danni = damage();

   /* viaggia in quella direzione fino a raggiungere un bordo */
   if (move_dir < 90)
      while ((loc_x() < 850) && (loc_y() < 850) && (damage()<(danni+6)))
         look ();
   else if (move_dir < 180)
      while ((loc_x() > 150) && (loc_y() < 850) && (damage()<(danni+6)))
         look ();
   else if (move_dir < 270)
      while ((loc_x() > 150) && (loc_y() > 150) && (damage()<(danni+6)))
         look ();
   else
      while ((loc_x() < 850) && (loc_y() > 150) && (damage()<(danni+6)))
         look ();

   drive (move_dir, 0);
}


/* resta fermo un po'... */
stay()
{
   if (damage() < (danni + 6)) danni = damage();
   else return;
   i = 100;
   while ( (danni == damage()) && (--i))
      look();
}


/* Si guarda intorno e spara */
look ()
{
   if (!(dist = scan (sc_dir, 3)))
   {
      if (dist = scan(sc_dir-= 6,3)) sfas = -6;
      else if (dist = scan(sc_dir-=13, 10)) sfas = -5;
      else if (dist = scan(sc_dir+=25, 3)) sfas = 6;
      else if (dist = scan(sc_dir+=13, 10)) sfas = 5;
      else {
            while ( !(oldd = scan(sc_dir+=20, 10)) );
            return;
      }
   } else if (dist > 700) {
      while ( !(oldd = scan(sc_dir+=20, 10)) );
      return;
   }
   if (dist > oldd) cannon(sc_dir+sfas, (dist*147) >> 7);
   else if (dist < oldd) cannon(sc_dir+sfas, (dist*57) >> 6);
   else cannon(sc_dir,dist);
   oldd = dist;
}
