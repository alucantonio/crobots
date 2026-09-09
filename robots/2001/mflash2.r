/*
			###   MiniFlash      ###
			###   versione 2.0   ###
			###  15 - 02 - 2001  ###

Autore: Lorenzo Ancarani

	MiniFlash si sposta percorrendo in senso antiorario il perimetro
	del campo di battaglia, alla massima velocita'.
	L'algoritmo di fuoco e' ridotto al minimo per stare nelle 300
	istruzioni.
*/

int ang, dir;

main()
{
	ang=11;
	drive(dir=180,100);
	while (loc_x() > 100) fuoco();
	drive(dir=270,0);
	while (speed() > 49) fuoco();
	drive(dir,100);
	while (1)
	{
		while (loc_y() > 120)  {
			fuoco();
		}
		stop(0);
		while (loc_x() < 880) {
			fuoco();
		}
		stop(90);
		while (loc_y() < 880) {
			fuoco();
		}
		stop(180);
		while(loc_x() > 120)   {
			fuoco();
		}
		stop(270);
	}
}

int   oang,range,orange;

int search() {

if (orange=scan(ang+=340,10)) cannon(ang,orange);
   else if (orange=scan(ang+=40,10)) cannon(ang,orange);
   else ang+=40;

}

int scan2() {

      if (!scan(ang+=5,5)) ang-=10;
      if (!scan(ang+=3,3)) ang-=6;
      if (!scan(ang+=2,2)) ang-=4;
}

fuoco()
{
   if (orange=scan(ang,10)) {
      oang=ang;
      scan2();
      if (scan(ang,7)) {
       scan2();
       if (range=scan(ang,10)) {
          cannon(ang+(ang-oang)*range/500,165*range/(165+orange-range));
       } else search();
      } else search();
      if (orange>710) ang+=40;
   } else search();
}

stop(deg) { /* Fermati ed imposta la direzione successiva */
	drive(dir=deg,0);
	while (speed() > 49) if ((range=scan(dir,10)) > 50)
		cannon(ang=dir,10*range/11);
	drive(dir,100); /* Riparti */
}
