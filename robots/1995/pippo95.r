/*
  Pippo95
  Creola Andrea

  Tattica: Inizialmente fino a quando il danneggiamento nonsupera il 4%, il
           robot rimane fermo, dopo si muove incrementa di 65 gradi l'angolo
           di movimento, e si muove nella direzione ottenuta, fino a quando
           non ariva vicino al bordo o non viene ripetutamente colpito,
           a questo punto, se il danneggiamento a superato il 70% si rifugia
           sui bordi, in caso contrario cambia direzione incrementando
           l'angolo di 65 gradi.
*/
/**********/
int ang;     /* Angolo in cui cercare l'avversario */
int delta;   /* Differenza tra la'ngolo di ricerca e il movimento dell'
                avversario */
int rangepr; /* Disatanza precedente dell'avversario */
int range;   /* Distanza corrente dell'avversario */
int dam;     /* Danni */
int dir;     /* Direzione di movimento */
int wait;    /* Usata per limitare il numero di ricerche dell'avversario */
int ang2;    /* Angolo supplementare */
int range2;  /* Range supplementare */
int conta;   /* Usata per limitare le soste */
/********** MAIN **********/
main()
{
 dam=damage();
 while(1)
  {
   conta=40;
   while((damage()-4<dam)&&(--conta)) sp1();
   dam=damage();

   dir += 65;
   dir = (dir % 360);
   drive(dir,080);

   if (dir < 90)
      while ((loc_x() < 850) && (loc_y() < 850) && (damage()<(dam+6)))sp1();
   else if (dir < 180)
      while ((loc_x() > 150) && (loc_y() < 850) && (damage()<(dam+6)))sp1();
   else if (dir < 270)
      while ((loc_x() > 150) && (loc_y() > 150) && (damage()<(dam+6)))sp1();
   else
      while ((loc_x() < 850) && (loc_y() > 150) && (damage()<(dam+6)))sp1();

   drive (dir, 0);
   while(speed()>50)sp1();
   if (damage()>70) fuga();
  }
}
/********** SP1 **********/
sp1()
{
 if (!(range = scan (ang, 3)))
  {
   if (range = scan(ang-= 6,3)) delta = -6;
   else if (range = scan(ang-=13, 10)) delta = -5;
   else if (range = scan(ang+=25, 3)) delta = 6;
   else if (range = scan(ang+=13, 10)) delta = 5;
   else
    {
     wait=10;
     while ( (!(rangepr = scan(ang+=20, 10) )) && (--wait));
     return;
    }
  }
 if (range > 700)
  {
   wait=10;
   while ( (!(rangepr = scan(ang+=20, 10) )) && (--wait));
   return;
  }
 if (range - 050  > rangepr) cannon(ang+delta, (range*147) >> 7);
 else if (range + 050 < rangepr) cannon(ang+delta, (range*57) >> 6);
 else cannon(ang,range);


 range2=scan(ang2+=20,5);
 if ((range2 > 0) && (range2 < (range - 50)))
  {
   ang = ang2;
   rangepr = range2;
  }
 else rangepr = range;
}
/********** FUGA **********/
fuga()
{
 if (loc_x()>500)
  {
   drive(000,080);
   while(loc_x()<900)sp1();
   drive(090,000);
   while(speed()>050);
  }
 else
  {
   drive(000,080);
   while(loc_x()<900)sp1();
   drive(090,000);
   while(speed()>050);
  }

 while(1)
  {
   drive(090,080);
   while(loc_y()<900)sp1();
   drive(270,000);
   while(speed()>050);

   drive(270,080);
   while(loc_y()>100)sp1();
   drive(090,000);
   while(speed()>050);

  }
}