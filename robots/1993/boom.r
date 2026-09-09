/*======================================================================*/
/* 			Boom.r  V 1.0 
	Autore:
   			Capparuccia Rosario
   Tattica:
   		Si muove descrivendo una traiettoria triangolare; lato destro, 
   		lato superiore, e diagonale principale. Utilizza  tre  routine 
   		di sparo diverse, a seconda del tratto che sta percorrendo.*/

/*======================================================================*/
int ang;                /* angolo di sparo */
main()
{
	ang=0;
	drive(270,100);

	while ((loc_y() > 135) && (speed() > 0)) 
		FuocoY();
	Ferma(0);

	drive(0,100);
	while ((loc_x() < 865) && (speed() > 0)) 
		FuocoX();
	Ferma(90);

	while 	(1) 
    {
		drive(90,100);
    	while ((loc_y() < 865) && (speed() > 0)) 
			FuocoY();
		Ferma(180);

		drive(180,100);
		while ((loc_x() > 135) && (speed() > 0)) 
			FuocoX();
		Ferma(315);

		drive(315,100);
   		while ((loc_y() > 135) && (speed() > 0)) 
			FuocoXY();
		Ferma(90);
	}   
}   

/*======================================================================*/
/*	Routine di sparo usata mentre si percorre il lato superiore dell'area
  	di combattimento */
/*======================================================================*/

FuocoX()
{
	int range;
	if (range = scan(ang, 10)) {
 			cannon(ang, 8 * range / 7);  /* Spara piu' lontano  */
			cannon(ang, 7 * range / 8);  /* e piu' vicino       */
		}
	else   {
		ang -= 20;
		if (ang <= 160) 
			ang = 359;
	}
}

/*======================================================================*/
/*	Routine di sparo usata mentre si percorre il lato   destro   dell'area
  	di combattimento */
/*======================================================================*/

FuocoY()
{
int range;
	if (range = scan(ang, 10)) {
 			cannon(ang, 8 * range / 7);  /* Spara piu' lontano  */
			cannon(ang, 7 * range / 8);  /* e piu' vicino       */
		}
	else   {
		ang -= 20;
		if (ang <= 70) 
			ang = 270;
	}
}

/*======================================================================*/
/*	Routine di sparo  usata  mentre  si  percorre la diagonale  principale 
	dell'area di combattimento */
/*======================================================================*/

FuocoXY()
{
int range;
	if (range = scan (ang, 3))
		cannon (ang, 7 * range / 8);
	else
	{
		ang -= 20;
		while (!(range = scan (ang, 10)))  /* Cerca finche' non trova */
			ang += 20;                     /* un bersaglio            */
		if (range < 60) 
			range = 60;
		cannon (ang, 7 * range / 8);
	};
}

/*======================================================================*/
 /*Si rallenta fino ad una velocita' adatta al cambiamento di direzione */
/*======================================================================*/
Ferma(Dir)
int Dir;
{
	drive(Dir,0);
	while (speed()>49)
		FuocoXY();
}
