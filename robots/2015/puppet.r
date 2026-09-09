/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots (2015)                                                */
/*                                                                          */
/*  CROBOT: puppet.r                                                        */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

  Ennesima rivisitazione di power.r e derivati in versione micro. 
  f2f devastante per la categoria ...
  
*/
int deg,odeg,rng,dir,orng,x,y,b;

main()
{
	if (loc_y(x=(loc_x()>500))>500) { if (x) deg=195; else deg=285; } else { if (x) deg=105; else deg=375; }
	spara(dir=deg);
	
    while(1) {
		if (orng>580) dir=deg+25+(b^=1)*225;
		else if (orng>100) dir=deg+80+(b^=1)*200;
        else dir=deg;                                
       
		if ((x=loc_x(y=loc_y()))>835) dir=165+30*(y>500);
        else if (x<165) dir=345+30*(y<500);
        else if (y>835) dir=255+30*(x<500);
        else if (y<165) dir=75+30*(x>500);
		else if(damage()>65) dir+=180; 
        
		spara();
		
		if(scan(deg-15,10)) deg-=5;
		if(scan(deg+15,10)) deg+=5;
		
		spara(); 
        
		if (orng<190 || orng>670) { spara(); spara(); spara(); } 
    }
}

spara()
{
    drive(dir,100);
	
	if ((orng=scan(deg, 10)) ) { 
        if (scan(deg-15,10)) { 
            if (scan(deg-=13,4)) { 
                if(scan(deg-3,5)) deg-=5; else ++deg;
            }  else if (scan(deg-5,5)) deg-=5;
        } else if(scan(deg+14,10)) { 
            if (scan(deg+=13,5)) deg+=5; else --deg;
        }  else if(scan(deg+4,5)) deg+=5; else deg-=5;
    } else if ((orng=scan(deg-=20,10))) { 
        if (scan(deg-9,10)) { 
            if (scan(deg-=13,5)) deg-=5; else ++deg;
        } else if(scan(deg+9,10)) deg+=6; 
    } else if ((orng=scan(deg+=40,10))) { 
          if (scan(deg+9,10)) deg+=12; 
    }  else if ((orng=scan(deg+=20,10))) ; 
	else {
		if ((orng=scan(deg-=80,10))) cannon(deg,orng); else deg+=300; 
		return;
	} 
	
    if (rng=scan(deg,10)){
        cannon (deg, rng*135/(135+orng-rng) ); 
    }   
} 

