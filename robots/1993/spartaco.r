/*
				  SPARTACO

      Questo crobot raggiunge uno dei due angoli di destra e ci rimane 
    fino a quando non viene colpito. A questo punto si dirige verso l'
    altro angolo.
      L' algoritmo di sparo e' derivato da cube.r.


      Realizzato da 

		Andrea Murru (MC4327)
*/

int     sc_dir, sfas, oldd, dist, scd2, d, p;

main()
{
	drive(0, 100);
	while (loc_x() < 960) 
		spara();
	drive(90, 0);
	while (speed() > 49) 
		spara();
	/* Raggiunge la parete di destra */

	while (1) {
		drive(90, 100);p=70;   
		while (loc_y() < 920) spara();
		drive(90, 10);
		while(loc_y() < 960) spara(); 
		drive(270, 0);
		d=damage();p=140;
		/* Raggiunge l' angolo in alto */
		while(!(damage()-d)) spara();
		/* Aspetta fino a quando non viene colpito */
		drive(270, 100);p=70;
		while (loc_y() > 80) spara();
		drive(270, 10);
		while(loc_y() > 30) spara();
		drive(90, 0);
		d=damage();
		/* Raggiunge l' angolo in basso */
		while(!(damage()-d)) spara();
		/* Aspetta fino a quando non viene colpito */
		  }
}

spara ()
{
	int     dist2;

	if (!(dist = scan (sc_dir, 5))) {
		if (dist = scan(sc_dir -= 10, 5)) sfas = -6;
		   else if (dist = scan(sc_dir -= 15, 10)) sfas = -10;
			   else if (dist = scan(sc_dir += 35, 5)) sfas = 6;
				   else if (dist = scan(sc_dir += 15, 10)) sfas = 10;
					   else {
					   /* Se non si e' mosso di pochi gradi     
					      inizia una ricerca a partire dalla
					      posizione p = (180 o 90) */
						if (sc_dir=115) sc_dir=250;
						else sc_dir=p;
						while (!(dist = scan(sc_dir += 20, 10)));
						sfas = 0;
						oldd = dist;
						return;
						}
					 }
	if (sc_dir==90 || sc_dir==270) sfas=0;
	if (dist<900) {
		      cannon(sc_dir + sfas, dist + 6 * (dist - oldd) / 5);
		      oldd = dist;
		      }
	   else {
	   /* Se il bersaglio e' troppo lontano ne cerca un altro */
		if (scd2<110) scd2=290;
		dist2 = scan (scd2 -= 20, 10);
		if (dist2 && dist2<dist) {sc_dir = scd2;oldd = dist2;}
		} 
}





