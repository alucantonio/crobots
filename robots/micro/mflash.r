/*
			###   MiniFlash      ###
			###   versione 1.0   ###
			###  15 - 03 - 2000  ###

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
		while (loc_y() > 100)  {
			fuoco();
		}
		stop(0);
		while (loc_x() < 900) {
			fuoco();
		}
		stop(90);
		while (loc_y() < 900) {
			fuoco();
		}
		stop(180);
		while(loc_x() > 100)   {
			fuoco();
		}
		stop(270);
	}
}

int   oang,range,orange;

fuoco() /* fuoco() - routine di gestione del cannone */        
{
   if (orange=scan(ang,10)) {

      if (!scan(ang+=5,5)) ang-=10;
      if (!scan(ang+=3,3)) ang-=6;
      if (!scan(ang+=2,1)) ang-=4;

      if (range=scan(ang,10)) { cannon(ang,2*range-orange); }
      if (orange>700) ang+=40;
   } else if (orange=scan(ang+=340,10)) cannon(ang,orange);
   else if (orange=scan(ang+=40,10)) cannon(ang,orange);
   else ang+=40;

}

stop(deg) { /* Fermati ed imposta la direzione successiva */
	drive(dir=deg,0);
	while (speed() > 49) if (range=scan(dir,10) > 50)
		cannon(dir,9*range/10);
	drive(dir,100); /* Riparti */
}
