/*        ีออออออออออออออออออออออออออออออออออออออออออออออธ      */
/*        ณ     Autore :        Paolo Torda              ณ      */
/*        ณ                                              ณ      */
/*        ณ     Nome Robot :  Castore                    ณ      */
/*        ณ                 MC6617@mclink.it             ณ      */
/*        ณ                                              ณ      */
/*        ิออออออออออออออออออออออออออออออออออออออออออออออพ      */

/*    Strategia :           Il Robot esegue un movimento        */
/*                  lungo il perimetro del campo di bat-        */
/*                  taglia.                                     */
/*                  Inizia sempre sul lato sinistro e           */
/*                  rimane su ogni lato finche' non subisce     */
/*                  almeno 25%  di danni                        */
/*                                                              */

int ang,newrange,oldrange,angolo2,range2;
int     danni;

main()
{

/* Si posiziona sull'angolo in alto a sinistra */
        while (loc_y() < 910)
                {
                drive (90, 100);
                spara(0,360);
                }
	drive (90, 0);
        while (speed() > 45)
                spara(170,370);

        while (loc_x() > 90)
                {
                drive (180, 100);
                spara(170,370);
		}
	drive (0, 0);
        while (speed() > 45)
                spara(260,370);

/* movimento su e giu' sul lato sinistro */
	while (damage() < 25) {
                drive (270, 100);
		danni = damage();
                while (loc_y() > 90 && ((damage() - danni) < 9))
                        spara(260,460);
                drive (270, 0);
                while (speed() > 45)
                        spara(260,460);

                drive (90, 100);
		danni = damage();
                while ((loc_y() < 910) && ((damage() - danni) < 9))
                        spara(260,460);
                drive (90, 0);
                while (speed() > 45)
                        spara(260,460);
	}

/* angolo in alto a sinistra */
        drive (90,100);
        while (loc_y() < 910)
                spara(260,460);

        drive (90,0);
        while(speed() > 45)
                spara(260,460);

/* movimento sinistra destra lato superiore */
	while (damage() < 50) 
		{
                drive (0, 100);
		danni = damage();
                while ((loc_x() < 910) && ((damage() - danni) < 9))
                        spara(170,370);
                drive (0, 0);
                while (speed() > 45)
                        spara(170,370);

                drive (180, 100);
		danni = damage();
                while ((loc_x() > 90) && ((damage() - danni) < 9))
                        spara(170,370);
                drive (180, 0);
                while (speed() > 45)
                        spara(170,370);
		}

/*  angolo in alto a sinistra */
        drive (180,100);
        while (loc_x() > 90)
                spara(170,370);

        drive (180,0);
        while(speed() > 45)
                spara(170,370);


/* angolo in basso a sinistra */
        while (loc_y()>100 )
		{
		drive(315,100);
                spara(0,360);
		}
        drive (315,0);
        while (speed() > 45)
                spara(0,360);
/* * * */


/* movimento sinistra destra sul lato basso */
	while (damage() < 75) 
		{
                drive (180, 100);
		danni = damage();
                while ((loc_x() > 90) && ((damage() - danni) < 9))
                        spara(-10,190);
                drive (180, 0);
                while (speed() > 45)
                        spara(-10,190);

                drive (0, 100);
		danni = damage();
                while ((loc_x() < 910) && ((damage() - danni) < 9))
                        spara(-10,190);
                drive (0, 0);
                while (speed() > 45)
                        spara(-10,190);
		}

/* angolo in basso a destra */
        drive (0,100);
        while (loc_x() < 910)
                spara(-10,190);

        drive (0,0);
        while(speed() > 45)
                spara(-10,190);

/* ultimo lato, movimento su e giu' lato destro */
	while (1) 
		{
                drive (90, 100);
		danni = damage();
                while ((loc_y() < 910) && ((damage() - danni) < 9))
                        spara(80,180);
                drive (90, 0);
                while (speed() > 45)
                        spara(80,180);

                drive (270, 100);
		danni = damage();
                while ((loc_x() > 90) && ((damage() - danni) < 9))
                        spara(80,180);
                drive (270, 0);
                while (speed() > 45)
                        spara(80,180);
		}
}


spara(amin,amax)
int amin,amax;
{

        if ((newrange = scan(ang, 10))&&(newrange<700))
                {
                if (oldrange < newrange)
			cannon(ang, 8 * newrange / 7);
                else
			cannon(ang, 7 * newrange / 8);
                oldrange = newrange;
                ang+=5;
                }
        else
		{
		ang -= 20;
		if (ang < amin)
			ang = amax;
		}

        range2 = scan (angolo2,10);

        if ((range2) && (range2 < newrange))
                {
                oldrange = range2;
                ang = angolo2;
                }

        else
		{
                angolo2+=20;
		if (angolo2>amax)
			angolo2=amin;
		}
}

