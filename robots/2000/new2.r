/*

New2 - 12/ott/2000

Autore: Andrea Barbaresi

 * Causa tesi, lavoro, famiglia... non ho avuto granche' tempo di mettere
 * mano al robot "New.r" del Torneo 1999. Ho apportato alcune marginali
 * modifiche che spero facciano guadagnare qualche punto percentuale.
 * Per qualsiasi altro riferimento guardare "New.r" (1999).

 * Schema del movimento:
                                        (x=999,y=999)
           +------------------------------------+ 
           |        <--==(( New ))==-->         |
           .                                    .
           .                                    .
           |                                    |
        (y |                                    |
           |                                    |
        a  |                                    |
        x  |                                    |
        i  |                                    |
        s) |                                    |
           |                                    |
           .                                    .
           |        <--==(( New ))==-->         |
           +------------------------------------+
        (x=0,y=0)         (x axis)

*/

int ang,        /* Angolo di scanning                           	*/
    oldang,	/* Angolo di scanning precedente			*/
    range,	/* Gittata corrente					*/
    oldrange,	/* Gittata precedente					*/
    dir,        /* Direzione di spostamento                        	*/
    diff,       /* Variazione del range nella funzione finale		*/
    maxcount;	/* Massimo numero di cicli virtuali della funz. princ.	*/

main() /* Procedura principale */
{
   ang=11;
   maxcount=90;
   Vai(90+180*(loc_y() < 500),150+700*(loc_y() > 500));
   Vai(180*(loc_x() > 500),400+200*(loc_x() < 500));
   if (loc_x() > 500) Vai(180,300);
   while (--maxcount) {
	Vai(0,600);
	Vai(180,400);
   }
   Vai(180,150);
   if (damage() < 80) {
      drive(180*(loc_x()>500),100);
      ang=336;
      diff=50;
      while(1)
	{
		ang+=328;
		while(!(range=scan(ang+=16,8)));
		cannon(ang,range);
		if(range>200) drive(dir=ang,100);
		while (range  && (range<770))
		{
			if (range>200)
			{
				oldang=ang;
				oldrange=range;
				ang+=4-(scan(ang-4,4) != 0)*8;
				ang+=2-(scan(ang-2,2) != 0)*4;
				ang+=1-(scan(ang-1,1) != 0)*2;
				if (range=scan(ang,10))
					cannon(ang+(ang-oldang)*range/200,range+(range-oldrange+diff)*range/275);
				if (speed()<51 || ((ang-dir)*(ang-dir)>400))
				{
					drive(dir=ang,100);
					diff=25;
				}
				else diff=50;
			}
			else
			{
				ang+=20;
				while(range<300)
				{
					ang+=320;
					while(!(range=scan(ang+=20,10)));
					cannon(ang,range);
					if(speed()<50 || range>200) drive(dir=ang,100);
				}
			}
		}
	}
   } else {
	if (loc_y() > 500) Vai(270,150,1);
	while(1) {
		drive(dir=90,100);
		while (loc_y() < 850) Kill(1);
		Stop();
       	        drive(dir=270,100);
		while(loc_y() > 150) Kill(1);
		Stop();
	}
   }
}

Vai(deg,limit)
{
 drive(dir=deg,100);
 if (deg == 90) {
	while(loc_y() < limit) Kill(1);
	while(loc_y() < (limit + 50)) Kill(0);
 } else if (deg == 270) {
	while(loc_y() > limit) Kill(1);
	while(loc_y() > (limit - 50)) Kill(0);
 } else if (deg == 180) while(loc_x() > limit) Kill(1);
   else while(loc_x() < limit) Kill(1);
 Stop();
}

Kill(x)
{
 if (scan(dir,10)) ang=dir;
 else if (scan(dir+180,10)) ang=dir+180;
 if (oldrange=scan(ang,10))
     {if (x) Fuoco(); else Fuoco2();}
 else Find();
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

int Find()
{
   if(scan(ang-=10,10)) return;
   else if(scan(ang+=20,10)) return;
   ang+=40;
}

Fuoco()
{
if ((oldrange < 300) || (oldrange > 700)) { Fuoco2(); return; }
   else {
	scan_();
	if (oldrange=scan(oldang=ang,5))
	{
		scan_();
		if (range=scan(ang,10)) {
		 cannon(ang+(ang-oldang)*((1200+range)>>9)-(sin(ang-dir)>>14),range*160/(160+oldrange-range-(cos(ang-dir)>>12)));
		 if (range > 770) ang+=40;
		}
	} else Find();
   }
}

Fuoco2()
{
   if (range=scan(ang+353,4)) cannon(ang+=350,3*range-2*oldrange);
   else if (range=scan(ang,4)) cannon(ang,3*range-2*oldrange);
   else if (range=scan(ang+7,4)) cannon(ang+=10,3*range-2*oldrange);
   else if((range=scan(ang+339,10))&&(range<800)) cannon(ang+=339,range);
    else if((range=scan(ang+21,10))&&(range<800)) cannon(ang+=21,range);
      else if((range=scan(ang+318,10))&&(range<900)) cannon(ang+=318,range);
        else if((range=scan(ang+42,10))&&(range<900)) cannon(ang+=42,range);
          else ang+=105;
}

Stop()		/*  Ferma il motore					*/
{
   drive(dir,0);
   while (speed() > 49) ;
}
