/*                         Torneo di C-Robots 1998                       */
/*                                                                       */
/*   Nome   :  AI2.R                                                     */
/*   Autore :  Apuzzo Danilo                                             */
/*   E-Mail :  mc4838@mclink.it                                          */
/*                                                                       */
/*                         Descrizione                                   */
/*                                                                       */
/*   Si colloca nell'angolo Sud-Ovest e percorre ripetutamente un        */
/*   quadrato; se colpito controlla gli angoli adiacenti e, se uno       */
/*   e' libero, vi si trasferisce. Nella fase finale, se ancora in       */
/*   buone condizioni, aumenta il lato del quadrato fino a centro del    */
/*   campo di battaglia.                                                 */
/*   Se puo' partecipare un solo c-robot preferisco che sia scelto       */
/*   QUESTO mio c-robot.                                                 */



int timer,deg,lato,d,n;
int x,y,ap;
main()

{
timer=90;
lato=100;
n=0;
              /* si colloca nell'angolo */

while(loc_x()>50) drive(180,100); 
drive(180,0);
while(speed()>49);         
while(loc_y()>50) drive(270,100);  
drive(270,0);
while(speed()>49);

while(1)
{
up();right();down();left();
}


} /* main */

up()
{
d=damage();
y=loc_y();
drive(90,100); fuoco();  fuoco();     fuoco();
while(((loc_y()-y)<lato)&&(loc_y()<950)) {drive(90,100);  }
drive(90,0);    fuoco();
timer=timer-1;
if((timer==0)&&(damage()<90)) lato=500;        /* fine gara  */
while(speed()>49);
                                    
}

right()
{
x=loc_x();
drive(0,100);   fuoco();   fuoco();     fuoco(); 
while(((loc_x()-x)<lato)&&(loc_x()<950)) {drive(0,100); }
drive(0,0);    fuoco();
while(speed()>49); 
}

left()
{
x=loc_x();
drive(180,100);   fuoco();  fuoco();    fuoco(); 
while( ((x-loc_x())<lato)&&(loc_x()>50)) {drive(180,100);}
drive(180,0);    fuoco();
while(speed()>49) {if(((damage()-d)>3))     /* se colpito prova a spostarti */      
			     {
			     if (go((n+=1)%4))  {ap=1; (go((n+=3)%4)); ap=0; }
			     }
		}
}

down()
{
y=loc_y();
drive(270,100);  fuoco();    fuoco();    fuoco();  
while( ((y-loc_y())<lato)&&(loc_y()>50)) {drive(270,100);  }
drive(270,0);    fuoco();
while(speed()>49); 
}


fuoco()

{
	int     rng,orng;

	if ((rng=scan(deg, 10))) { 
		if (scan(deg-7,4)) {
			if (scan(deg-=7-2,2)) {
				if(scan(deg-=2-1,1)) deg-=1;
			}
			else if (scan(deg+2,2)) deg+=2;
		}
		else if(scan(deg+7,4)) {
			if (scan(deg+=7+2,2)) deg+=2;
		}
		else if(scan(deg+2,2)) deg+=2;
	}
	else if ((rng=scan(deg-=20,10)))  {  
		if (scan(deg-7,4)) {
			if (scan(deg-=7-2,2)) deg-=2;
		}
		else if(scan(deg+7,4)) deg+=7;
	}
	else if ((rng=scan(deg+=40,10)))  {   
		if (scan(deg-7,4)) deg-=7;
	}
	else if (!(rng=scan(deg+=20,10))) {
		if (!(rng=scan(deg+=20,10))) {
			deg+=20;
			if (!(scan(deg,10))) deg+=40;
		}
		else {
			cannon(deg,7*rng/8);
			if (rng>710) deg+=60;
		}
		deg%=360;
		return;
	}
	if (orng=scan(deg,10)){     
    
		  cannon (deg, orng*183/(183+rng-orng) ); 
		if(orng>710) deg+=60;
	}
}


go(n)
{
    int curx,nx,ny,dist;
    int x1,y1;
    int nok;
  nok=0;

if (n==3)
{x1=950;y1=50;}
else if (n==1)
{x1=50;y1=950;}
else if (n==2)
{x1=950;y1=950;}
else
{x1=50;y1=50;}



    /* Calcola la direzione per recarsi al punto stabilito: */    
    nx=(curx=loc_x())-x1;
    ny=(loc_y()-y1)*100000;
    if (x1>curx) dir=360+atan(ny/nx);
	   else dir=180+atan(ny/nx);


 if( (!(scan(dir,10))) )
 {              /* Si reca nel punto stabilito: */    
    
    dist=35001;
    drive(dir,0);

    while(dist>35000)
    {    
	drive(dir,100);
	
	fuoco(); 
	nx=x1-loc_x();
	ny=y1-loc_y();
	dist=(nx*nx)+(ny*ny);
    }

 } /* if */
 else                      /* se non posso spostarmi rimetto n come prima */
 {
 if(!ap) ((n-=1)%4);
 else    ((n-=3)%4);
 nok=1;
 }

drive(dir,0);
d=damage();
return(nok);
}





     

