/*

        רררררר  רררררר  ררררררר  רררררר  רררררר
        ר    ר  ר    ר     ר     ר    ר  ר    ר
        רררררר  ר    ר     ר     רררררר  רררררר
        ר  ר    ר    ר     ר     ר    ר  ר  ר
        ר   ר   רררררר     ר     ר    ר  ר   ר



        Autori:      Alessandro Savoiardo
                     Alessio Gosmar

        Robot:       Rotar

        Anno:        2004

        Categoria:   Micro (472 istruzioni)

        Commenti:    Presenti al torneo 2k4 con: ~ Gotar
                                                 ~ Rotar
                                                 ~ Gotar2
*/

int grfuoco, ogrfuoco, rgfuoco, xp, yp, xc, yc, grado, raggio, stato, vel, verso;

main()
{
  grfuoco = 0;
  rgfuoco = 0;
  ogrfuoco = 0;
  raggio = 300;
  verso = 1;
  while (1)
  {
    grado = rand(90);


    vel = 100;

    xc = 500;
    yc = 500;

    if (raggio > 350)
      verso = -1;

    if (raggio < 200)
      verso = 1;

    while (grado < 360)
    {
      stato = damage();
      xp = xc + ((cos(grado) * raggio) /100000);
      yp = yc + ((sin(grado) * raggio) /100000);
      Vai(xp,yp,vel);
      Fuoco();
      /* pausa di ciclo*/
      if ((xp > 5) && (xp < 995) && (yp > 15) && (yp < 995))
        while ((Circa(xp,loc_x()) > (vel)) || (Circa(yp,loc_y()) > (vel)))
        {
          Fuoco();
        };
        drive(grado,80);  /*importante altrimenti non si ferma*/
        Fuoco();
        grado = grado + 35;
        if (stato != damage())
        {
          raggio = raggio + (10 * verso);
        }
      }
  }
}



Fuoco()
{

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


int Circa(val1, val2)
int val1, val2;
{
  int res;
  res = val1-val2;
  if (res < 0)
    res = res * -1;
  return res;
}


int plot_course(xx,yy)                      /*Inizia la procedura, passandogli come parametri
                                              le coordinate della destinazione.....*/
int xx, yy;                                 /*....che vengono dichiarate esternamente alla
                                              procedura stessa*/
{
  int d;                                    /*Dichiara le variabili che userא nella procedura*/
  int x,y;                                  /*Poichט il compilatore e` molto semplificato */
  int scale;                                /*non gestisce i numeri in virgola mobile*/
  int curx, cury;                           /*ma solo gli interi*/

  scale = 100000;                           /*quindi le funzioni trigonometriche restituiscono
                                              un risultato compreso tra 1 e 10000 anzichט tra
                                              0 e 1*/
  curx = loc_x();                           /*Memorizza in due variabili la posizione
                                              attuale*/
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

                                            /*Poichט l' arcotangente (atan) restituisce un
                                              valore compreso tra -90 to +90, per ottenere un
                                              risultato utile sui 360 gradi dobbiamo
                                              modificarlo con altre informazioni di cui
                                              disponiamo.........*/

  if (x == 0)                               /*....ed ט proprio ciע di cui si occupa questa
                                              parte*/
  {
    if (yy > cury)
      d = 90;
   else
      d = 270;
  }
 else
  {
    if (yy < cury)
     {
      if (xx > curx)
        d = 360 + atan((scale * y) / x);    /*Ci troviamo nel quadrante di sud-est*/
      else
        d = 180 + atan((scale * y) / x);    /*Siamo nel quadrante di sud-ovest */
      }
   else
   {
      if (xx > curx)
        d = atan((scale * y) / x);          /*Siamo nel quadrante nord-est */
      else
        d = 180 + atan((scale * y) / x);    /*E questo e` il quadrante nord-ovest*/
    }
  }
  
  return d;
}

/*  Movimento in una posizione */
Vai(xx,yy,vel)
int xx,yy,vel;
{
 drive(plot_course(xx,yy),vel);
}

