/*

        רררררר  רררררר   ררררר ררררררר  רררררר  רררררר
        ר       ר    ר  ר         ר     ר    ר  ר    ר
        ר  ררר  ר    ר   רררר     ר     רררררר  רררררר
        ר    ר  ר    ר       ר    ר     ר    ר  ר  ר
        רררררר  רררררר  ררררר     ר     ר    ר  ר   ר



        Autori:     Alessandro Savoiardo
                    Alessio Gosmar

        Robot:      Gostar

        Anno:       2004

        Categoria:  Micro (357 istruzioni)

        Commenti: La specialitא di gostar ט l'attacco a stella.
                  Traccia nell'arena il disegno di una stella unita come fosse 
                  un disegno su carta.

                  Presenti al torneo 2k4 con: ~ Gotar
                                              ~ Rotar
                                              ~ Gotar2
                                              ~ Gostar
*/

int grfuoco, ogrfuoco, rgfuoco, punto, limite, maxcampo;

main()
{
  grfuoco = 0;
  rgfuoco = 0;
  ogrfuoco = 0;
  limite = 250;
  punto = 1;
  maxcampo = 999;
  while (1)
  {
    if (punto == 1)
      while (loc_y()>limite) /* Va al punto 2 */
        Fuoco(240,100);

    if (punto == 2)
      while (loc_x()<(maxcampo-limite)) /*  Va al punto 3 */
        Fuoco(30,100);

   if (punto == 3)
      while (loc_x()>limite) /*  Va al punto 4 */
        Fuoco(180,100);

   if (punto == 4)
      while (loc_y()>limite)/*  Va al punto 5 */
        Fuoco(330,100);

   if (punto == 5)
      while (loc_y()<(maxcampo-limite)) /*  Va al punto 1 */
        Fuoco(120,100);

    ++punto;
    if (punto > 5)
      punto = 1;
  }
}


int VerificaEstremi()
{
  int res, lim;
  res = 0;
  lim = 60;

  if (loc_y()<lim)
    res = 1;
  if (loc_y()>(maxcampo-lim))
    res = 1;
  if (loc_x()<lim)
    res = 1;
  if (loc_x()>(maxcampo-lim))
    res = 1;

 return res;
}

Fuoco(angolo,vel)
int angolo,vel;
{
  if (VerificaEstremi() == 1)
    drive (360-angolo);
  else
    drive(angolo,vel);

  if (rgfuoco=scan(ogrfuoco=grfuoco,10))
  {
    if (scan(grfuoco+350,10)) grfuoco-=5; else grfuoco+=5;
    if (scan(grfuoco+10,10)) grfuoco+=3; else grfuoco-=3;
    cannon(grfuoco+(grfuoco-ogrfuoco),(scan(grfuoco,10)<<1)-rgfuoco);
  } else {
      if (rgfuoco=scan(grfuoco+=340,10)) return cannon(grfuoco,rgfuoco);
      if (rgfuoco=scan(grfuoco+=40,10))  return cannon(grfuoco,rgfuoco);
      while (!(rgfuoco=scan(grfuoco+=20,10))) ;
      cannon(grfuoco,rgfuoco);
  }
}



