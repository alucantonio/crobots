/*
			###      Flash       ###
			###   versione 7.0   ###
			###  15 - 10 - 2000  ###

Autore: Lorenzo Ancarani

	Flash7 si sposta percorrendo in senso antiorario il perimetro
	del campo di battaglia, alla massima velocita'.
	L'algoritmo di fuoco e' ispirato a quello dei miglior robot del
	1999 Songohan, per cui la documentazione relativa e' reperibile
	nella scheda tecnica di tale crobot.
*/

int ang, dir;

main()
{
	ang=11;
	drive(dir=180,100);
	while (loc_x() > 150) fuoco();
	drive(dir=270,0);
	while (speed() > 49) ;
	drive(dir,100);
	while (1)
	{
		while (loc_y() > 150)  {
			fuoco();
		}
		stop(0);
		while (loc_x() < 850) {
			fuoco();
		}
		stop(90);
		while (loc_y() < 850) {
			fuoco();
		}
		stop(180);
		while(loc_x() > 150)   {
			fuoco();
		}
		stop(270);
	}
}

int   oang,range,orange;

/*Spara con media precisione*/

fuoco2()
{
  if((orange=scan(ang,10))&&(orange<770))
  {
   if (range=scan(ang+353,4))
     cannon(ang+=353,range);
   else if (range=scan(ang,3))
          cannon(ang,range);
   else if (range=scan(ang+7,4))
          cannon(ang+=7,range);
   }
  else
    if((range=scan(ang+=339,10)))
      cannon(ang,range);
    else
      if((range=scan(ang+=42,10)))
        cannon(ang,range);
      else
            return (ang+=40);
}

/*Spara mentre decelera*/

stop(deg) {
     drive(dir=deg,0);
     while (speed()>49)
          if ((range=scan(ang,10))&&(range<770))
            cannon (ang,range);
          else
            trova();
     drive(dir,100);
}

trova()
   {
          if (range=scan(ang+=340,10));
          else if (range=scan(ang+=40,10));
          else if (range=scan(dir,10))
            ang=dir;
          else
             return (ang+=40);
          return cannon(ang,2*scan(ang,10)-range);
    }


/*Spara con buona precisione sia da fermo che in movimento*/

fuoco()
{
    if (orange=scan(ang,10))
      {
        if ((orange>700))
          return fuoco2();
        else
        {
        if (scan(ang-=5,5));else ang+=10;
        scan_();
        if (orange=scan(oang=ang,5))
          {
            scan_();
            if (range=scan(ang,10))
              return cannon((ang+(ang-oang)*((1150+range)>>9)-(sin(ang-dir)>14)),(range*160/(160+orange-range-(cos(ang-dir)>>12))));
          }
        else
          return fuoco2();
        }
      }
    else
      return trova();
}

scan_()
{
  if(scan(ang+354,1)) ang+=354;
  if(scan(ang+6,  1)) ang+=6;
  if(scan(ang+356,1)) ang+=356;
  if(scan(ang+4,  1)) ang+=4;
  if(scan(ang+358,1)) ang+=358;
  if(scan(ang+2,  1)) ang+=2;
}

