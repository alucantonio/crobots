/*******************
 *                 *
 *  O   N   E  .r  *
 *                 *
 *******************

 Michelangelo Messina                         


Robot senza nessuna pretesa, se non di tentare di far bene nel KingOfTheHill.
E' composto solo di routine f2f


*/


int     deg,odeg, /*angolo di sparo*/
        rng, /*distanza*/
        dir; /*direzione*/
        int orng;
	int x,y,b,dam;


fuoco() 
{
  if (scan(deg,10));
  else if (scan(deg+=20,10));
  else if (scan(deg-=40,10));
  else if (scan(deg+=60,10));
  else if (scan(deg-=80,10));
  else {
        if (orng=scan(deg+=100,10)) return cannon(deg,orng);
        else if (orng=scan(deg-=120,10)) return cannon(deg,orng);
        else if (orng=scan(deg+=140,10)) return cannon(deg,orng); 
        else if (orng=scan(deg-=160,10)) return cannon(deg,orng);
	else if ((orng=scan(deg-=20,10))) return cannon(deg,orng);
	else if ((orng=scan(deg+=200,10))) return cannon(deg,orng);
	else return deg+=100;
  }

  if (scan(deg-18,10)) deg-=7; else deg+=1;
  if (scan(deg+18,10)) deg+=7; else deg-=1;

  
  if (orng=refine()) {
    if (rng=refine(odeg=deg))
      cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
  }
}

refine() {
  if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
  if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
  if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;
  return scan(deg,10);

}

spara()
{
	drive(dir,100);
        if ((orng=scan(deg, 10)) ) { 
                if (scan(deg-15,10)) { 
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-3,5)) deg-=5;
                                else ++deg;
                        }  else if (scan(deg-5,5)) deg-=5;
                } else if(scan(deg+14,10)) { 
                        if (scan(deg+=13,5)) deg+=5;
                        else --deg;
                }  else if(scan(deg+4,5)) deg+=5;
                else deg-=5;

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,5)) deg-=5;
                        else ++deg;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+9,10)) deg+=12;
        }  else if ((orng=scan(deg+=20,10)));
	else {
		if ((orng=scan(deg-=80,10))) cannon(deg,orng);
		else if ((orng=scan(deg-=20,10))) cannon(deg,orng);
		else if ((orng=scan(deg+=120,10))) cannon(deg,orng);
		else if ((orng=scan(deg+=20,10))) cannon(deg,orng);
		else if ((orng=scan(deg-=160,10))) cannon(deg,orng);
		else if ((orng=scan(deg-=20,10))) cannon(deg,orng);
		else if ((orng=scan(deg+=200,10))) cannon(deg,orng);
		else deg+=80;
		return;
	}
        if (rng=scan(deg,10)){  
                cannon (deg, rng*145/(145+orng-rng) ); 
        }  else if(rng=scan(deg-=20,10)) cannon(deg,rng); 
        else if(rng=scan(deg+=40,10)) cannon(deg,rng);
	else deg+=40; 
} 

main()
{
	if(loc_y(x=(loc_x()>500))>500) {
                if(x) spara(dir=deg=195);
                else spara(dir=deg=285);
        } else {
                if(x) spara(dir=deg=105);
                else spara(dir=deg=375);
        }
	fuoco(drive(dir,100));
            while(1) {
		if(orng>640) dir=deg+25+(b^=1)*250;
		else if(orng>151) dir=deg+80+(b^=1)*200;
                else dir=(deg/90)*90;                               
                if ((x=loc_x(y=loc_y()))>835) dir=165+30*(y>500);
                else if (x<165) dir=345+30*(y<500);
                else if (y>835) dir=255+30*(x<500);
                else if (y<165) dir=75+30*(x>500);
		else if(dam>80) dir+=180;
                dam=damage(spara());
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		spara();
                if(orng>459) {
                        fuoco(drive(dir,100));
                } 
                
            }
}






