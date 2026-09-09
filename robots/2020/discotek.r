/************************
 *                      *
 *  D I S C O T E K .r  *
 *                      *
 ************************

 Michelangelo Messina                         

MicroRobot senza nessuna pretesa, che deriva da Colour.r del 2015.
E' composto solo di routine f2f, che usa una versione ridotta della classica boom()


*/


int     deg, /*angolo di sparo*/
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
                                if(scan(deg-8,10)) deg-=6;
                                else ++deg;
                        }  else if (scan(deg-10,10)) deg-=5;
                } else if(scan(deg+14,10)) { 
                        if (scan(deg+=13,5)) deg+=5;
                        else --deg;
                }  else if(scan(deg+9,10)) deg+=6;
                else deg-=5;

        }  else if ((orng=scan(deg-=21,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,5)) deg-=5;
                        else ++deg;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=42,10))) { 
                if (scan(deg+9,10)) deg+=12;
        }  else if ((orng=scan(deg+=21,10)));
	else return radar();
        if (rng=scan(deg,10)){  
                cannon (deg, rng*135/(135+orng-rng) ); 
        }  else radar();
} 
radar(){while (!(orng=scan(deg+=21,10))); return cannon(deg,orng);}


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
		if(orng>550) dir=deg+25+(b^=1)*290;
		else if(orng<152) dir=(deg/90)*90;
		else dir=deg+80+(b^=1)*200;                               
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

/*
Hi, Discotek People
It's time to move your body (it's time to move your body)
It's now time to jump it to the left (it's time to jump it to the left)
And jump it to the right (and jump it to the right)
Are you ready? (are you ready?)
Now dance, dance to the left, to the left
Now dance, dance to the right, to the right.
Dance, move to the left, to the left,
Dance, move to the right, to the right,
Dance, move to the left, to the left
Dance, move to the right, to the right
Dance, move to the left, to the left,
Dance, move to the right, to the right,
Dance, move to the left, to the left
Dance, move to the right, to the right.
It's now time to move your body
It's now time to jump it to the left (left)
And now, jump it to the right, right, right, right...
Move it, move it, move it
Dance, move to the left, to the left,
Dance, move to the right, to the right,
Dance, move to the left, to the left
Dance, move to the right, to the right
Dance, move to the left, to the left,
Dance, move to the right, to the right,
Dance, move to the left, to the left
Dance, move to the right, to the right
CIAO, BABY!
*/