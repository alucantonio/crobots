/*McFly.r
mjf
 Simone Ascheri                         

*/



int deg,odeg,dam,rng,dir,orng,x,y,b;

fuoco() 
{
  if (scan(deg,10));
  else if (scan(deg+=21,10));
  else if (scan(deg-=42,10));
  else if (scan(deg+=63,10));
  else if (scan(deg-=84,10));
  else {
        if (orng=scan(deg+=105,10)) return cannon(deg,orng);
        else if (orng=scan(deg-=126,10)) return cannon(deg,orng);
        else if (orng=scan(deg+=147,10)) return cannon(deg,orng); 
        else if (orng=scan(deg-=168,10)) return cannon(deg,orng);
	else if ((orng=scan(deg+=189,10))) return cannon(deg,orng);
	else if ((orng=scan(deg-=210,10))) return cannon(deg,orng);
		else return deg-=100;
  }

  if (scan(deg-18,10)) deg=deg-7; else deg=deg+0; if (scan(deg+18,10)) deg=deg+7; else deg=deg+0;
  
  if (orng=refine()) {
    if (rng=refine(odeg=deg))
      return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(190+orng-rng-(cos(deg-dir)>>12)));
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
		if ((orng=scan(deg-=81,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=21,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=122,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=21,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=164,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=21,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=206,10))) return cannon(deg,orng);
		else return deg+=100;
	}
        if (rng=scan(deg,10)){  
                cannon (deg, 2*rng-orng); /*rng*145/(145+orng-rng) ); */
        }  else if (rng=scan(deg-=20,10)) cannon(deg,rng); 
		else if (rng=scan(deg+=40,10)) cannon(deg,rng); 
		else deg+=40;
} 


main()
{
	if (loc_y(x=(loc_x()>500))>500) {
        if (x) deg=195; else deg=285;
    } else {
        if (x) deg=105; else deg=375;
    }
	spara(dir=180*x);
	
    while(1) {
		if (orng>580) dir=deg+25+(b^=1)*225;
		else if (orng>100) dir=deg+80+(b^=1)*200;
        else dir=(deg/90)*90;                               
       
		if ((x=loc_x(y=loc_y()))>835) dir=165+30*(y>500);
        else if (x<165) dir=345+30*(y<500);
        else if (y>835) dir=255+30*(x<500);
        else if (y<165) dir=75+30*(x>500);
		else if(dam>75) dir+=180;
        
		dam=damage(spara());
		
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		
		spara();
        
		if(orng>485) fuoco(drive(dir,100));
    }
}
