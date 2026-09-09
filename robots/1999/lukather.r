/*----------------------------------------------------------------*/	
/*----------NOME C-ROBOT:    LUKATHER					  --------*/
/*----------PROGETTO E REALIZZAZIONE: LORENZO STRAMBI     --------*/
/*																  */
/*--TATTICA: Lukather si piazza nel più vicino angolo libero e ---*/
/*--		 aspetta, sparando, finche i suoi danni non ----------*/
/*--		 raggiungono il 20%. A questo punto si dirige verso---*/
/*--		 l'angolo vicino e vi rimane fino al 50% dei danni ---*/
/*--		 Poi comincia ad oscillare verticalmente e a sparare -*/
/*																  */
/*----------------------------------------------------------------*/
/*--COMMENTI:E' il mio primo crobot. Riesce a difendersi bene ma -*/
/*--		 la routine d'attacco lascia un po a desiderare. -----*/
/*--		 La funzione attacca() e' presa in prestito da Goblin */
/*----------------------------------------------------------------*/


  int x, y, vel, ctr, deg, dist, ang, loc;
  main()
{

  x = loc_x();
  y = loc_y();
  if (x < 500){
	if (y < 500){
		giul();}
    else sul();}
  else {
	if (y < 500){
		giur();}
    else sur();}
}

  giul()
{
	loc=1;
	if (!scan(225,10)){
		while(loc_y() > 80) {drive(270,100); attacca(); attacca(); attacca();}
		drive(270,0);
		while(speed()>49);
		while(loc_x() > 80) {drive(180,100); attacca(); attacca(); attacca();}
		drive(180,0);}
	else sul();
	while(damage() < 20) attacca();
	scappa(loc);	

}

  sul()
{
	loc=4;
	if (!scan(135,10)){
		while(loc_y() < 900)  {drive(90,100); attacca(); attacca(); attacca();}
		drive(90,0);
		while(speed()>49);
		while(loc_x() > 80)  {drive(180,100); attacca(); attacca(); attacca();}
		drive(180,0);}
	else giur();
	while(damage() < 20) attacca();
	scappa(loc);
}

  giur()
{
	loc=2;
	if (!scan(315,10)){
		while(loc_y() > 80) {drive(270,100); attacca(); attacca(); attacca();}
		drive(270,0);
		while(speed()>49);
		while(loc_x() < 900) {drive(0,100); attacca(); attacca(); attacca();}
		drive(0,0);}
	else sur();
	while(damage() < 20) attacca();
	scappa(loc);
}

  sur()
{
	loc=3;
	if (!scan(45,10)){
		while(loc_y() < 900) {drive(90,100); attacca(); attacca(); attacca();}
		drive(90,0);
		while(speed()>49);
		while(loc_x() < 900) {drive(0,100); attacca(); attacca(); attacca();}
		drive(0,0);}
	else giul();
	while(damage() < 20) attacca();
	scappa(loc);
}



  scappa(loc)

{
  if (loc==1  || loc==2){
	while(loc_y() < 900) {drive(90,100); attacca();}
	drive(90,0);
	while(damage() < 50) attacca();
	while(1)
	{
	while(loc_y() > 130) {drive(270,100); attacca();}drive(270,0);
	while(loc_y() < 900) {drive( 90,100); attacca();}drive( 90,0);	
	}
	}
  else {
	while(loc_y() > 130) {drive(270,100); attacca();}
	drive(270,0); 
	while(damage() < 50) attacca();
	while(1)
	{
	while(loc_y() < 900) {drive( 90,100); attacca();}drive( 90,0);
	while(loc_y() > 130) {drive(270,100); attacca();}drive(270,0);
	}
  }
}

  attacca()

{
  	int     rng,orng;

	if ((rng=scan(deg, 10))) { 
		if (scan(deg-7,4)) {
			if (scan(deg-=7-2,2)) {
				if(scan(deg-=2-1,1)) deg-=1;
			}
			else if (scan(deg+2,2)) deg+=2;
		}
		else if(scan(deg+7,4)) {
			if (scan(deg+=7+2,2)) deg+=2;
		}
		else if(scan(deg+2,2)) deg+=2;
	}
	else if ((rng=scan(deg-=20,10)))  {  
		if (scan(deg-7,4)) {
			if (scan(deg-=7-2,2)) deg-=2;
		}
		else if(scan(deg+7,4)) deg+=7;
	}
	else if ((rng=scan(deg+=40,10)))  {   
		if (scan(deg-7,4)) deg-=7;
	}
	else if (!(rng=scan(deg+=20,10))) {
		if (!(rng=scan(deg+=20,10))) {
			deg+=20;
			if (!(scan(deg,10))) deg+=40;
		}
		else {
			cannon(deg,7*rng/8);
			if (rng>710) deg+=60;
		}
		deg%=360;
		return;
	}
	if (orng=scan(deg,10)){     
    
		  cannon (deg, orng*183/(183+rng-orng) ); 
		if(orng>710) deg+=60;
	}
}


 
