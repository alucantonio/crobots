/*                                 SARA_6.R


    Francesco Pierobon
    Via V. Scamozzi, 17
    35013 Cittadella (PD)

    Tel. 049/5972508
    Fax. 049/9401100

    Versione 6.1


								*/

int	range, cont, ang;
int	com, pxmax;


main()
{

	ang = 170;
	com = -20;
	cont = 0;

	pri_mov();

}


pri_mov()
{

	while (1) {

		drive(90, 100);
		while (loc_y() < 960) 
			spara2();
		drive(180, 0);
		while (speed() > 49)  
			spara2();
		drive(180, 100);
		while (loc_x() > 70)  
			spara2();
		drive(0, 0);
		while (speed() > 49)  
			spara2();

		if (cont < 0)
			pxmax = 220;
		else
			pxmax = 420;

		while (cont < 45) {
			drive(0, 100);
			while (loc_x() < pxmax)  
				spara2();
			drive(180, 0);
			while (speed() > 49)     
				spara2();
			drive(180, 100);
			while (loc_x() > 70)     
				spara2();
			drive(0, 0);
			while (speed() > 49)     
				spara2();

			if (damage() > 45 && cont < 7 && com == -20)
				comp2();

			cont++;
		}

		com = damage();
		while (damage() < 80) {
			com = damage();
			drive(0, 100);
			while (loc_x() < 960)    
				spara2();
			drive(270, 0);
			while (speed() > 49)     
				spara2();
			drive(270, 100);
			while (loc_y() > 40)     
				spara4();
			drive(180, 0);
			while (speed() > 49)     
				spara4();
			if (damage() < 80) {
				drive(180, 100);
				while (loc_x() > 40)     
					spara6();
				drive(90, 0);
				while (speed() > 49)     
					spara6();
				drive(90, 100);
				while (loc_y() < 960)    
					spara8();
				drive(0, 0);
				while (speed() > 49)     
					spara8();
			}
		}

		cont = -80;
	}


}


spara2()
{

	range = scan(ang, 10);
	if (range > 10 && range < 780)
		cannon(ang, range);
	else {
		ang += 15;
		if (ang > 360) 
			ang = 180;
	}

}


spara4()
{

	range = scan(ang, 10);
	if (range > 10 && range < 780) {
		cannon(ang, range);
	} else {
		ang -= 15;
		if (ang < 90) 
			ang = 270;
	}

}


spara6()
{

	range = scan(ang, 10);
	if (range > 10 && range < 780)
		cannon(ang, range);
	else {
		ang += 15;
		if (ang > 180) 
			ang = 0;
	}

}


spara8()
{

	range = scan(ang, 10);
	if (range > 10 && range < 780)
		cannon(ang, range);
	else {
		ang += 15;
		if (ang > 450) 
			ang = 270;
	}

}


comp2()
{

	int	com;
	int	pxmax;

	drive(270, 100);
	while (loc_y() > 40)   
		spara8();
	drive(0, 0);
	while (speed() > 49)   
		spara6();

	pxmax = 420;

	while (1) {
		while (cont < 40) {
			drive(0, 100);
			while (loc_x() < pxmax) 
				spara6();
			drive(180, 0);
			while (speed() > 49)    
				spara6();
			drive(180, 100);
			while (loc_x() > 70)    
				spara6();
			drive(0, 0);
			while (speed() > 49)    
				spara6();

			cont++;
			if (damage() > 90 && cont > 10) {
				com = -40;
				main();
			}
		}

		com = damage();
		while (damage() < 80) {
			com = damage();
			drive(90, 80);
			while (loc_y() < 960)    
				spara8();
			drive(0, 0);
			while (speed() > 49)     
				spara8();
			drive(0, 80);
			while (loc_x() < 960)    
				spara2();
			drive(270, 0);
			while (speed() > 49)     
				spara2();
			if (damage() < 80) {
				drive(270, 80);
				while (loc_y() > 40)     
					spara4();
				drive(180, 0);
				while (speed() > 49)     
					spara4();
				drive(180, 80);
				while (loc_x() > 40)     
					spara6();
				drive(90, 0);
				while (speed() > 49)     
					spara6();

			}
		}

		drive(270, 100);
		while (loc_y() > 40)   
			spara6();
		drive(180, 0);
		while (speed() > 49)   
			spara6();
		drive(180, 100);
		while (loc_x() > 70)   
			spara6();

		cont = -280;
		pxmax = 220;
	}
}


