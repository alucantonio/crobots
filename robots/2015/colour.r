/********************
 *                  *
 *  C O L O U R .r  *
 *                  *
 ********************

 Michelangelo Messina                         

U96 - LOVE SEES NO COLOUR 

Robot senza nessuna pretesa, che deriva da Eternity.r del 2013.
E' composto solo di routine f2f
(doveva essere presentato già per il torneo 2013... ma me ne scordai)


*/


int     deg,odeg, /*angolo di sparo*/
        rng, /*distanza*/
        dir; /*direzione*/
        int orng;
	int x,y,b,dam;


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
	else return deg+=37;
        if (rng=scan(deg,10)){  
                cannon (deg, rng*145/(145+orng-rng) ); 
        }  else if(scan(deg-=18,10)); 
        else if(scan(deg+=36,10));
	else deg+=37; 
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
	spara();
            while(1) {
		if(orng>650) dir=deg+25+(b^=1)*250;
		else if(orng>151) dir=deg+80+(b^=1)*200;
                else dir=(deg/90)*90;                               
                if ((x=loc_x(y=loc_y()))>870) dir=165+30*(y>500);
                else if (x<130) dir=345+30*(y<500);
                else if (y>870) dir=255+30*(x<500);
                else if (y<130) dir=75+30*(x>500);
		else if(dam>80) dir+=180;
                dam=damage(spara());
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		spara();                
            }
}





