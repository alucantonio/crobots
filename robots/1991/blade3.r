/*  blade3.r     (super-fast)       */
/*  by Ugolini Davide   Cesena (FO) */

int	range, dr, scdir;

main() 
{ 
	drive(180, 100); 
	while (loc_x() > 100) 
		fire();
	drive(180,  0); 
	while (speed() >  0) 
		fire();
	drive( 90, 100); 
	while (loc_y() < 500) 
		fire();
	drive( 90,  0); 
	while (speed() >  0) 
		fire();
	drive(270, 100); 
	while (loc_y() > 500) 
		fire();
	drive(270,  0); 
	while (speed() >  0) 
		fire();
	scdir = 0; 
	dr = 45; 
	drive(dr, 100);     
	fire();
	while (1) { 
		while (loc_y() < 850) 
			fire(); 
		vira();
		while (loc_x() < 850) 
			fire(); 
		vira();
		while (loc_y() > 150) 
			fire(); 
		vira();
		while (loc_x() > 150) 
			fire(); 
		vira(); 
	} 
}


vira() 
{ 
	while (speed() > 50) 
		drive(dr, 0);
	dr -= 90; 
	if (dr < 0) 
		dr = 360 + dr;   
	drive(dr, 100); 
}


fire() 
{ 
	scdir += 20; 
	if (scdir > 359) 
		scdir -= 360;
	range = scan(scdir, 10);
	if (range) { 
		cannon(scdir, range); 
		scdir += 285; 
	} 
}


