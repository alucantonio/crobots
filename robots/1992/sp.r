/* SP.r, crobot da combattimento
   Autore:Filippo Quondam
*/
int	r, s, ang, ag;
main()  
{

ang:
	 = 0;
	while (1) {

		while (loc_x() > 200) {                /* lato sud */
			drive(180, 100);

			s = 701;

			while ( (s > 700) && (loc_x() > 230)) {
				while (scan(ang, 10) < 40)         /*1^ ciclo di scan */
					ang += 18;
				ang += 355;
				if (!(s = scan(ang, 6))) {
					ang += 10; /* 2^ ciclo di scan */
					if ((s = scan(ang, 6)) < 40) 
						s = 701;
				}
			}

			spara();                          /*chiama la procedura*/
			ang += 325 + r / 35;                    /*retrocede ang per lo scan successivo */

		}

		drive(180, 0);                          /*spegne il motore*/
		while (speed() > 52)                     /*aspetta che si rallenti*/
			while (((scan(ang, 10)) < 10) && (speed() > 56))
				ang += 18;             /*frattempo si cerca con lo scan....*/


		while (loc_y() < 800) {                /* lato ovest */
			drive(90, 100);
			s = 701;
			while ( (s > 700) && (loc_y() < 770)) {
				while ((scan(ang, 10)) < 40)
					ang += 18;
				ang += 355;
				if (!(s = scan(ang, 6))) {
					ang += 10;
					if ((s = scan(ang, 6)) < 40) 
						s = 701;
				}
			}
			spara();
			ang += 325 + r / 35;

		}

		drive(90, 0);
		while (speed() > 52)
			while (((scan(ang, 10)) < 10) && (speed() > 56))
				ang += 18;

		while (loc_x() < 800) {                  /* lato nord */
			drive(0, 100);
			s = 701;
			while ( (s > 700) && (loc_x() < 770)) {
				while ((scan(ang, 10)) < 40)
					ang += 18;
				ang += 355;
				if (!(s = scan(ang, 6))) {
					ang += 10;
					if ((s = scan(ang, 6)) < 40) 
						s = 701;
				}
			}
			spara();
			ang += 325 + r / 35;

		}

		drive(0, 0);
		while (speed() > 52)
			while (((scan(ang, 10)) < 10) && (speed() > 56))
				ang += 18;


		while (loc_y() > 200) {                   /* lato est */
			drive(270, 100);
			s = 701;
			while ((s > 700) && (loc_y() > 230)) {
				while ((scan(ang, 10)) < 40)
					ang += 18;
				ang += 355;
				if (!(s = scan(ang, 6))) {
					ang += 10;
					if ((s = scan(ang, 6)) < 40) 
						s = 701;
				}
			}

			spara();
			ang += 325 + r / 35;
		}

		drive(270, 0);
		while (speed() > 52)
			while (((scan(ang, 10)) < 10) && (speed() > 56))
				ang += 18;
	}
}






spara()                         /* procedura spara */
{
	if (s < 180) 
		cannon(ang, s);       /* se siamo vicini, spara! */
	else
	 {
		ang += 350;    /* 3^ livello di scan */
		/*350*/     if (scan(ang, 3) > 10);
else
{
	ang += 5;
	/*355*/         if (scan(ang, 3) > 10)
		;
	else
	 {
		ang += 5;
		/*360*/         if (scan(ang, 3) > 10)
			;
		else
		 {
			ang += 5;
			/*365*/           if (scan(ang, 3) > 10)
				;
			else
			 {
				ang += 5;
				/*370*/           if (scan(ang, 3) > 10)
					;
			}
		}
	}
}


s = scan(ang, 6);
ag = ang + 352;          /* 4^ livello di scan */
/*352*/     if (scan(ag, 2)
 > 10);
else
{
	ag += 4;
	/*356*/         if (scan(ag, 2) > 10)
		;
	else
	 {
		ag += 4;
		/*360*/         if (scan(ag, 2) > 10)
			;
		else
		 {
			ag += 4;
			/*364*/           if (scan(ag, 2) > 10)
				;
			else
			 {
				ag += 4;
				/*368*/           if (scan(ag, 2) > 10)
					;
			}
		}
	}
}


if (((ag-ang + 722)
 % 360)
 < 50) 
ang = 4 + ag-ang;
else 
	ang = 356 + ag - ang; /* decide l'angolo
       correttore prevedendo la direzione avversaria;722 serve per
       correggere l'avvistamento secondo il movimento di SP;*/

if ((r = scan(ag, 8)
)
 > 80)
cannon(ag + ang + 3, r + 36*(r-s)
 / 25); /* spara,
       correggendo la direzione di SP (il +3), e il range */
ang = ag + ang;
	}
}


