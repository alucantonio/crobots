/* PACCU.R       Crobot a cura di Cristiano De Mei       5/9/95

  Paccu.r e' ispirato al mio precedente PatCioca.r migliorato nella
  routine di fuoco mediante la tecnica di "puntamento angolare" di
  Lazyii.
  Il robot scorre l'arena in senso verticale sul lato destro del campo
  di gara e sosta sui due angoli. 
  Se la gara e' agli sgoccioli e gli avversari "non si fanno sotto" 
  Paccu.r parte per un raid al centro dell'arena alla ricerca degli
  avversari.

  Cristiano De Mei
  internet: mc7655@mclink.it

*/
                            
int ang,dist,distp,angini,angfin,dprec,cont;

main()
{
  ang=0;
  while (loc_x()<940) { drive(0,100);fuocoall(); }
  drive(0,49);
  while (loc_x()<978) fuocoright();
  while (loc_x()<988) { drive(0,19);fuocoright(); }
  drive(180,0);
  if (loc_y()>900) drive(270,25);     /* evita di urtare un muro */
              else drive(90,25);
  while (speed()>49) fuocoright();
  drive(270,49);ang=270;

  while(1)
  {   
     while (loc_y()>100) fuocoright();     /* spostamento in giu */
     drive(270,49);
     while (loc_y()>30) fuocoright();
     drive(90,0);
     angini=90;angfin=181;
     angolo();

     drive(90,100);ang=90;                /* spostamento in su */
     while (loc_y()<900) fuocoright();
     drive(90,49);
     while (loc_y()<970) fuocoright();
     drive(270,0);
     angini=180;angfin=271;
     angolo();

     drive(270,100);ang=270;
  }
}

fuocoall()           /* prima routine di fuoco */
{
  if (seiqui())
  {
    cannon(ang,(distp=scan(ang,10)));
  }
  else 
    ang+=12;
}

fuocoright()          /* seconda routine di fuoco */
{
  if (seiqui2())
  {
    cannon(ang,(distp=scan(ang,10)));
    if (distp>700) 
    {
      ang+=12;
      ang%=360;
      if (ang>270) ang=90;
    }
  }
  else
  {
    ang+=12;
    ang%=360;
    if (ang>270) ang=90;
  }
}

angolo()   /* routine di fermata e ricerca dell'avversario */
{
  dprec=damage();
  ang=angini;
  cont=0;
  while (damage()<dprec+4)
  {
     if (seiqui())
     {
      if (seiqui2())
      {
        cannon(ang,(distp=scan(ang,10)));
        if (distp>700)
        {
          ang+=9;
          ang%=360;
          if (ang>angfin) ang=angini;
        }
      }
     }
     else
     {
       ang+=9;
       ang%=360;
       if (ang>angfin) ang=angini;
     }
     ++cont;
     if ((cont==2000) && (damage()<65)) { cont=300;salto(); }
  }
}

salto()     /* fa un "salto" verso il centro dell'arena */
int dd;
{
  dd=damage();
  drive(180,100);
  while (loc_x()>490) { fuocoright();drive(180,100); }
  drive(0,0);
  while (speed()>49) fuocoright();
  while (damage()<dd+9) fuocoright();
  drive(0,100);
  while (loc_x()<940) { drive(0,100);fuocoright(); }
  drive(0,49);
  while (loc_x()<980) fuocoright();
  while (loc_x()<990) { drive(0,19);fuocoright(); }
  drive(0,0);
}

seiqui()   /* routine veloce di precisione */   
{
  if (scan(ang,5))  
  {
    if (scan(ang+3,2))
      if (scan(ang+4,1)) 
      { 
        if (scan(ang+3,0)) 
           ang+=3; 
        else   
            ang+=4;
        }
      else
        if (scan(ang+2,0))
           ang+=2; 
        else
           ang+=1; 
   else
      if (scan(ang-4,2))
        if (scan(ang-2,1)) 
           ang-=2;
        else
           ang-=3;        
      else
        if (scan(ang-1,0))
           ang-=1;
   return 1;
   }
else 
   return 0;
}

seiqui2()       /* routine di precisione tratta di Lazyii */
{
  if (dist=scan(ang,5))  
  {
    if (scan(ang+3,2))
      if (scan(ang+4,1)) 
      { 
        if (scan(ang+3,0)) 
           ang+=3; 
        else   
           ang+=4;
        }
      else
        if (scan(ang+2,0))
           ang+=2; 
        else
           ang+=1; 
   else
      if (scan(ang-4,2))
        if (scan(ang-2,1)) 
           ang-=2;
        else
           ang-=3;        
      else
        if (scan(ang-1,0))
           ang-=1;
   ang%=360;
   return 1;
   }
else 
   return 0;
}

