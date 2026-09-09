/*
   The Duke 0.04 13/3/93

   Giuseppe Menozzi

   The Duke e' l'insieme di vari algoritmi. Il concetto e' sempre lo stesso,
   quello inaugurato dal buon vecchio Jazz: un giusto cocktail tra velocita'
   e precisione, ottenuto con l'algoritmo "del 7/8".

   La prima parte del proggy esegue un disegno composto di "W" sui lati,
   non dopo aver raggiunto il punto di partenza seguendo un percorso ottimale
   dipendente dalla posizione random iniziale. Questo disegno non e'
   particolarmente efficiente negli scontri a due, ma oppone una buona difesa
   quando i robot sono quattro. La funzione richiamata per il fuoco,
   Maciulla(), esegue una sorta di ricerca esaustiva, partendo dal centro
   e andando nelle due direzioni.

   Nella seconda parte, attivata se il programma e' ormai attivo da un certo
   tempo, si suppone che l'avversario sia ormai rimasto uno solo, e si
   tenta lancia una modifica del buon vecchio Jazz.
*/



int Dir, DirR, Range, OldRange, locx, locy, cnt;

Maciulla()
{
   if (Range = scan (Dir,3))
      cannon (Dir,7*Range/8);
   else
   { Dir -=23;
     while (!(Range = scan (Dir,10))) Dir +=19;
     if (Range < 60) Range = 60;
     cannon (Dir,7*Range/8);
   };
}

Falcidia()
{
   if (Range = scan (Dir,5))
      cannon (Dir,7*Range/8);
   else
   {
      if (!(Range = scan (Dir,10)))
      { Dir +=19;
         if (!(Range = scan (Dir,10)))
         { Dir -=38;
            if (!(Range = scan (Dir,10)))
            { Dir +=57;
               if (!(Range = scan (Dir,10)))
               { Dir -=76;
                  if (!(Range = scan (Dir,10)))
                  { Dir +=95;
                     if (!(Range = scan (Dir,10)))
                       return (0);
                  };
               };
            };
         };
      };
      if (Range < 60) Range = 60;
      if (Range > OldRange)
         cannon (Dir,7*Range/6);
      else
         cannon (Dir,7*Range/8);
   };
   OldRange = Range;
}

xy2DirR (x,y)
int x,y;
{
   int locx, locy;

   locx = loc_x();
   locy = loc_y();

   if (locx == x)
   {
      if (y > locy)
         DirR = 90;
      else
         DirR = 270;
   }
   else
   {
      if (y < locy)
      {
         if (x > locx)
            DirR = 360 + atan ((100000 * (locy - y)) / (locx - x) );
         else
            DirR = 180 + atan ((100000 * (locy - y)) / (locx - x) );
      }
      else
         if (x > locx)
            DirR = atan ((100000 * (locy - y)) / (locx - x) );
         else
            DirR = 180 + atan ((100000 * (locy - y)) / (locx - x) );
   };
}

Girati (d)
int d;
{
   while (speed()>50)  {drive (d,50); Falcidia();};
   drive (d,100);
}

main()
{
 Dir = 0;

 locx = loc_x(); locy = loc_y();
 if (locx<500)
 {
    if (locy>500)
    {
      xy2DirR (0,500); drive (DirR,100); while (loc_x()>90) Falcidia(); Girati(270);
    } else drive (270,100);

    while (loc_y()>90)  Falcidia(); Girati(0);
    while (loc_x()<740) Falcidia();
 }
 else
 {
    if (locy>500)
    {
      xy2DirR (999,500); drive (DirR,100); while (loc_x()<930) Falcidia(); Girati(270);
      while (loc_y()>90) Falcidia(); Girati(180);
      while (loc_x()>760) Falcidia();
    } else
    {
       xy2DirR (750,0); drive (DirR,100); while (loc_y()>90) Falcidia();
    };
 };

  cnt = 4;
  while(--cnt)
  {
   Girati(45);  while (loc_x()<930) Falcidia();
   Girati(135); while (loc_x()>750) Falcidia();
   Girati(45);  while (loc_x()<930) Falcidia();
   Girati(135); while (loc_y()<930) Falcidia();
   Girati(225); while (loc_y()>750) Falcidia();
   Girati(135); while (loc_y()<930) Falcidia();
   Girati(225); while (loc_x()>70)  Falcidia();
   Girati(315); while (loc_x()<250) Falcidia();
   Girati(225); while (loc_x()>70)  Falcidia();
   Girati(315); while (loc_y()>70)  Falcidia();
   Girati(45);  while (loc_y()<250) Falcidia();
   xy2DirR(750,0); Girati(DirR); while (loc_y()>70) Falcidia();
  };

   /* Jazz */
    while (1)
    {
       xy2DirR (100,900);
       while (speed()>50)  {drive (DirR,50); Maciulla();};
       drive (DirR,100);
       while (loc_y() < 920 /*&& speed()*/) Maciulla();
       xy2DirR (900,100);
       while (speed()>50)  {drive (DirR,50); Maciulla();};
       drive (DirR,100);
       while (loc_y() > 80 /*&& speed()*/) Maciulla();
    };
 }


