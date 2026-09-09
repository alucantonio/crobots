/*******************
*                  *
*    B  L  U  E    *
*                  *
 *******************/

/*
 Michelangelo Messina                         
 Torneo 2025

Robot senza nessuna pretesa, se non di tentare di far bene nel KingOfTheHill.
E' il Loneliness.r del 2020 con qualche ottimizzazione.
E' composto solo di routine f2f


*/


int     deg,odeg, /*angolo di sparo*/
        rng, /*distanza*/
        dir; /*direzione*/
        int orng;
	int x,y,b,dam;


fuoco() 
{
  drive(dir,100);
  if (scan(deg,10));
  else if (scan(deg+=21,10));
  else if (scan(deg-=42,10));
  else if (scan(deg+=63,10));
  else return search();

  if (scan(deg-17,10)) deg-=7;  
  if (scan(deg+17,10)) deg+=7;

  
  if (orng=refine()) {
    if (rng=refine(odeg=deg))
      cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
    else if(rng=scan(deg-=21,10)) cannon(deg,rng); 
    else if(rng=scan(deg+=42,10)) cannon(deg,rng);
    else deg+=41;
  }
  else if(orng=scan(deg-=21,10)) cannon(deg,orng); 
  else if(orng=scan(deg+=42,10)) cannon(deg,orng);
  else deg+=41;
}

refine() {
  if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
  if (scan(deg+12,10)) deg+=2; if (scan(deg-12,10)) deg-=2;
  if (scan(deg+10,10)) ++deg; if (scan(deg-10,10)) --deg;
  return scan(deg,10);

}

search() {
  if ((orng=scan(deg-=84,10))) cannon(deg,orng);
  else if ((orng=scan(deg-=21,10))) cannon(deg,orng);
  else if ((orng=scan(deg+=126,10))) cannon(deg,orng);
  else if ((orng=scan(deg+=21,10))) cannon(deg,orng);
  else if ((orng=scan(deg-=168,10))) cannon(deg,orng);
  else if ((orng=scan(deg-=21,10))) cannon(deg,orng);
  else if ((orng=scan(deg+=210,10))) cannon(deg,orng);
  else if ((orng=scan(deg-=231,10))) cannon(deg,orng);
  else if ((orng=scan(deg+=252,10))) cannon(deg,orng);
  else deg+=41;
}

spara()
{
	drive(dir,100);
        if ((orng=scan(deg,10)) ) { 
                if (scan(deg-15,10)) { 
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-8,10)) deg-=5;
                        }  else if (scan(deg-10,10)) deg-=8;
                } else if(scan(deg+14,10)) { 
                        if (scan(deg+=13,5)) deg+=5;
                }  else if(scan(deg+9,10)) deg+=6;
                else deg-=5;

        }  else if ((orng=scan(deg-=21,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,5)) deg-=5;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=42,10))) { 
                if (scan(deg+9,10)) deg+=12;
        }  else if ((orng=scan(deg+=21,10)));
	else return search();
        if (rng=scan(deg,10)){  
                cannon (deg, rng*135/(135+orng-rng) ); 
        }  else if(rng=scan(deg-=21,10)) cannon(deg,rng); 
        else if(rng=scan(deg+=42,10)) cannon(deg,rng);
	else deg+=41;
} 

main()
{
	spara(deg=(dir=395+(y=(loc_y()>500))*(180*(x=(loc_x()>500))-90)-270*x)-30);
	if(orng>459) fuoco();
    while(1) {
        if ((x=loc_x(y=loc_y()))>840 || x<160 || y>840 || y<160) {
			if(x>840) dir=165+30*(y>500);
           	else if (x<160) dir=345+30*(y<500);
           	else if (y>840) dir=255+30*(x<500);
           	else            dir=75+30*(x>500);
		}
		else if(orng<149) dir=((deg/90)+(b^=1))*90+180*(dam<65);
		else if(orng<640) dir=deg+70+(b^=1)*210+180*(dam>69);
		else              dir=deg+40+(b^=1)*280+180*(dam>54);
		dam=damage(spara());
		if(scan(deg-14,10)) deg-=5;
		if(scan(deg+14,10)) deg+=5;
		spara();
		if(orng>459) fuoco();
    }
}

/*
Yo, listen up here's a story
About a little guy
That lives in a blue world
And all day and all night
And everything he sees is just blue
Like him inside and outside
Blue his house
With a blue little window
And a blue corvette
And everything is blue for him
And himself and everybody around
Cause he ain't got nobody to listen to
I'm blue
Da ba dee da ba di
Da ba dee da ba di
Da ba dee da ba di
Da ba dee da ba di
Da ba dee da ba di
Da ba dee da ba di
Da ba dee da ba di
*/