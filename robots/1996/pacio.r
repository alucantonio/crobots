/* Pacio.R       Crobot a cura di Cristiano De Mei       6/9/96

  Pacio.r e' ispirato al mio precedente Paccu.r migliorato nella
  tecnica di difesa mediante il movimento a zig-zag che disorienta
  gli avversari "lanciato" da b52.r nel precedente torneo.
  Il robot scorre l'arena in senso verticale sul lato destro del campo
  di gara e sosta sui due angoli oscillandovi incessantemente. 
  Se la gara e' agli sgoccioli e gli avversari "non si fanno sotto" 
  Pacio.r parte per un raid al centro dell'arena alla ricerca degli
  avversari.
  Le routine di fuoco sono semplicissime e si distinguono tra loro
  poiche' una viene utilizzata in movimento l'altra in caso di raid
  a fine partita.

  internet: mc7655@mclink.it

*/
                            
int ang,dist,angini,angfin,dprec,direz,cont,cont2;

main()
{
  angini=0;angfin=359;
  while (loc_x()<940) { drive(0,100);fuocoright(); }
  drive(0,49);
  while (loc_x()<955) { drive(0,24);fuocoright(); }
  drive(180,0);
  if (loc_y()>900) drive(270,25);     /* evita di urtare un muro */
              else drive(90,25);
  while (speed()>49) fuocoright();
  drive(270,100);

  while(1)
  {   
       drive(270,100);
       angini=80;angfin=280;      /* vai giu */
       while (loc_y()>85) {
         drive(270,100);
         fuocoright();
       }
       drive(270,44);
       while (loc_y()>30) fuocoright();
       drive(90,0);
       angini=70;angfin=180;
       while (speed()>49) fuocoright();
       angolo();

       drive(90,100);
       angini=80;angfin=290;      /* vai su */
       while (loc_y()<915) {
         drive(90,100);
         fuocoright();
       }
       drive(90,44);
       while (loc_y()<970) fuocoright();
       drive(270,0);
       angini=180;angfin=280;
       while (speed()>49) fuocoright();
       angolo();

  }
}

fuocoright()          /* routine di fuoco */
{
  if (dist=scan(ang,10))
  {
    seiqui();
    if (dist>720) 
    {
      ang+=10;
      ang%=360;
      if (ang>angfin) ang=angini;
    }
  }
  else
  {
    ang+=10;
    ang%=360;
    if (ang>angfin) ang=angini;
  }
}

angolo()      /* sosta nell'angolo oscillando continuamente */
{
  int dp2;

  dprec=damage();
  dp2=dprec;
  drive(180,100);
  direz=0;cont=0;cont2=0;
  ang=angini;
  while (damage()<dprec+9)
  {
     if ((direz) && (loc_x()>890)) {
       drive(180,0);direz=3;
     }
     if ((cont2>10) && (dp2<70)) salto();
     if (dist=scan(ang,10))
     {
        seiqui();
        if (dist>720)
        {
          ang+=9;
          ang%=360;
          if (ang>angfin) ang=angini;
        }
     }
     else
     {
       ang+=9;
       ang%=360;
       if (ang>angfin) ang=angini;
     }

     if ((direz==2) && (loc_x()>890)) {
       drive(180,0);direz=3;
     }
     if ((direz==0) && (loc_x()<879)) {
       drive(0,0);direz=1;
     }  
     if ((direz==3) && (speed()<50)) {
       drive(180,100);direz=0;
     }
     if ((direz==1) && (speed()<50)) {
       drive(0,100);direz=2;
     }
     if (damage()>dp2) { 
       dp2=damage();
       cont=0; 
     }
     else
       ++cont;     
     if (cont>150) { dp2=damage();dprec=dp2;cont=0;++cont2; }
  }
}

seiqui()        /* routine di precisione */
{
  int d;
  if (scan(ang+5,5)) ang+=5; else ang-=5;
  if ((ang<140) || (ang>220)) {
    if ((direz==0) && (loc_y()>500)) ang+=5;
    if ((direz==2) && (loc_y()>500)) ang-=5;
    if ((direz==0) && (loc_y()<500)) ang-=5;
    if ((direz==2) && (loc_y()<500)) ang+=5;
  }
  else {
    if (scan(ang+3,3)) ang+=3; else ang-=3;
  }

  if (d=scan(ang,10))
    if (d>dist) cannon(ang,d*8/7);
    else cannon(ang,d*7/8);
}

spara()        /* seconda routine di fuoco */
{
  if ((dist=scan(ang,10))<710)
  {
    if (dist=scan(ang+5,5)) ang+=5; else ang-=5;
    if (dist>19) cannon(ang,dist);
  }
  else {
    ang+=10;
    if (ang>angfin) ang=angini;
  }
}

salto()     /* se gli avversari non si avvicinano ...  */
{
  int d;
  
  drive(180,0);
  d=damage();
  direz=5;
  while (speed()>49) fuocoright();
  cont2=0;
  drive(180,100);
  while (loc_x()>500) {
    drive(180,100);
    fuocoright();
  }
  drive(0,0);
  while (speed()>49) fuocoright();
  while (damage()<d+1) spara();
  drive(0,100);
  while (loc_x()<878) {
    drive(0,100);
    fuocoright();
  }
  drive(180,0);
  while (speed()>49) fuocoright();
  direz=2;
  drive(0,49);
}

