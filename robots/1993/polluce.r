/*        ีออออออออออออออออออออออออออออออออออออออออออออออธ      */
/*        ณ     Autore :        Paolo Torda              ณ      */
/*        ณ                                              ณ      */
/*        ณ     Nome Robot :  Polluce                    ณ      */
/*        ณ                 MC6617@mclink.it             ณ      */
/*        ณ                                              ณ      */
/*        ิออออออออออออออออออออออออออออออออออออออออออออออพ      */

/*    Strategia :       Il Robot esegue inizialmente un         */
/*                  movimento a rombo nel campo di bat-         */
/*                  taglia. Dopo 2 giri completi verra'         */
/*                  eseguito un  conto per  determinare         */
/*                  quale e' stato l'angolo in cui si e'        */
/*                  subito il minor numero di danni.            */
/*                  Dopo di cio' il robot  si spostera'         */
/*                  in quell'angolo e vi rimarra a meno         */
/*                  che non venga colpito per un certo          */
/*                  numero di cicli della routine spara         */
/*                  e si i danni non superano il 65%.           */
/*                                                              */
/*                                                              */
/*                                                              */



int     angolo,
        vecchia_distanza,
        distanza;

/* ----- */

main()
{
int volte;
int dam;
int     d_1,
        d_2,
        d_3,
        d_4;

/* ---- */

	/* Si posiziona */
        while (loc_y() < 890)
                {
                drive (90, 100);
                spara();
                }
	drive (90, 0);
	while (speed() > 45)
        	spara();


        while((loc_x()>550)||(loc_x()<450))
                {
                drive(180*(loc_x()> 550), 100);
                spara();
                }

	drive (0, 0);

 /* inizializzazione variabili */
        volte = 3;
        d_1 = 0;
        d_2 = 0;
        d_3 = 0;
        d_4 = 0;

        while (speed() > 45)
                spara();

        dam = damage();

        /* movimento sulle diagonali */
        while (--volte)
                {
                drive (225, 100);
                while (loc_x() > 110 )
                        spara();
                drive (225, 0);
                while (speed() > 45)
                        spara();

                d_1 += damage()-dam;
                dam = damage();

                drive (315, 100);
                while (loc_y() > 110)
                        spara();
		drive (315, 0);
                while (speed() > 45)
                        spara();

                d_2 += damage() - dam;
                dam = damage();

                drive (45, 100);
                while (loc_x() < 890)
                        spara();
		drive (45, 0);
                while (speed() > 45)
                        spara();

                d_3 += damage() - dam;
                dam = damage();

                drive (135, 100);
                while (loc_y() < 890)
                        spara();
                drive (135, 0);
                while (speed() > 50)
                        spara();

                d_4 += damage() - dam;
                dam = damage();
	}
        spara();

        if ((d_1<=d_2)&&(d_1<=d_3)&&(d_1<=d_4))
                {
                while (loc_x() > 130)
                        {
                        drive (180, 100);
                        spara();
                        }
                drive (180, 0);
                bomb(265,365);
                }

        if ((d_2<=d_3)&&(d_2<=d_4))
                {
	/* Si posiziona */
                while (loc_x() > 130)
                        {
                        drive (180, 100);
                        spara();
                        }
                drive (180, 0);
                while (speed() > 45)
                        spara();

                while (loc_y() > 130)
                        {
                        drive (270, 100);
                        spara();
                        }
                drive (270, 0);
                bomb(-5,95);
                }

        if (d_3<=d_4)
                {
                while (loc_y() > 130)
                        {
                        drive (270, 100);
                        spara();
                        }
                drive (270, 0);
                while (speed() > 45)
                        spara();

                while (loc_x() < 870)
                        {
                        drive (0, 100);
                        spara();
                        }
                drive (0, 0);
                bomb(85,185);
                }

        while (loc_x() < 870)
                {
                drive (0, 100);
                spara();
                }
        drive (0, 0);
        bomb(175,275);

}





bomb(min,max)
int min,max;
{
int x,ox,range,orange;
int danni,colpi;

danni = damage();

while (1)
    {
    while(!(range=scan(x,8)))
        {
        x+=16;
        if (x > max)  x = min;
        }

    while ((range)&&(range<700))
        {
        if (range>200)
                {
                ox=x;
                orange=range;
                x+=4-(scan(x-4,4) != 0)*8;
                x+=2-(scan(x-2,2) != 0)*4;
                x+=1-(scan(x-1,1) != 0)*2;
                if (range=scan(x,10))
                        cannon(x+(x-ox)*range/300,range+(range-orange+20)*range/300);
                }
        else
                if (range=scan(x,10))
                        cannon(x,range);
        }

    x+=16;

    if (danni == damage())
        ++colpi;
    else
        {
        danni = damage();
        colpi=0;
        }

    if ((colpi > 80)&&(damage()< 65))
        main();
    }
}


spara()
{

if (distanza = scan(angolo, 10)) 
	{
        if (vecchia_distanza < distanza) 
                cannon(angolo, 8 * distanza / 7);
	else
                cannon(angolo, 7 * distanza / 8);
        angolo+=8;
        vecchia_distanza = distanza;
	} 
else   
        angolo -= 20;
}

