/* Horse.r by Summa Giovanni

    Horse si muove su 3 lati dell' arena con un movimento a U o ferro
    di cavallo sparando con una portata leggermente allungata o accorciata
    a seconda del verso di marcia
*/
int Direz,Ang;
main()
{
 while (1)
 {
  drive (0, 100);
  Ang=200;
  Direz=Ang;
  while (loc_x() < 940)
          seek2();
  drive (90, 0);
  frena2();
  drive (90, 100);
  Ang=290;
  Direz=Ang;
  while (loc_y() < 940)
          seek2();
  drive (180, 0);
  frena2();
  drive (180, 100);
  Ang=360;
  Direz=Ang;
  while (loc_x() > 80)
          seek2();
  drive (0, 0);
  frena();
  drive (0, 100);
  Ang=160;
  Direz=Ang;
  while (loc_x() < 940)
          seek();
  drive (270, 0);
  frena();
  drive (270, 100);
  Ang=70;
  Direz=Ang;
  while (loc_y() > 80)
          seek();
  drive (180, 0);
  frena();
  drive (180, 100);
  Ang=0;
  Direz=Ang;
  while (loc_x() > 80)
          seek();
  drive (0, 0);
  frena();
 }
}
/* Funzioni di scansione e attacco */
seek()
{
 int Portata;
 if (Portata=scan(Direz,10))
     cannon(Direz,Portata * 7 / 8);
 Direz+=20;
 if (Direz > (Ang+199))
     Direz=Ang;
}
seek2()
{
 int Portata;
 if (Portata=scan(Direz,10))
     cannon(Direz,Portata * 8 / 7);
 Direz-=20;
 if (Direz < (Ang - 200))
     Direz=Ang;
}
frena()
{
        while (speed() > 49)
                seek();
}
frena2()
{
        while (speed() > 49)
                seek2();
}
