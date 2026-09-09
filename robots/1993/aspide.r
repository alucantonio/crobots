
/* ASPIDE.r                                                             */
/* Comportamento: Si muove lungo la diagonale NO-SE dell'arena e spara  */
/*                correggendo range e angolo di tiro in funzione dello  */
/*                spostamento relativo del bersaglio.                   */
/*                                                                      */
/* Autore: Luciano Mei                                                  */



int  Dir, Ang, Ris, Range1, Range2, Delta;

main()
{
	Dir=dir_xy(150,850);

	while (1) 
	{
		drive(Dir,100);
		while(loc_y()<850) spara();
		Dir=dir_xy(850,150);
		drive(Dir,0);
		while(speed()>49) spara();

		drive(Dir,100);
		while(loc_y()>150) spara();
		Dir=dir_xy(150,850);
		drive(0,0);
		while(speed()>49) spara();
	}
}



spara()
{   
    if(Range1=scan(Ang,10))
    {    if(Range1<50) cannon(Ang,50);
         else
         {    Ris=(1000-Range1)/100;
              if(Range2=scan(Ang,Ris)) 
              {    if(Range2<Range1) 
                        cannon(Ang,7*Range2/8);
		   else 
                        cannon(Ang,7*Range2/6);
	      }
	      else
	      {    Delta=10-Ris;
                   Ang+=10;
                   if(Range2=scan(Ang,Delta))
                   {   if(Range2<Range1) 
                   	     cannon(Ang,7*Range2/8);
		       else 
                             cannon(Ang,7*Range2/6);
                   }
	           else
	           {   Ang-=20;
                       if(Range2=scan(Ang,Delta)) 
                       {     if(Range2<Range1) 
                   	          cannon(Ang,7*Range2/8);
		             else 
                                  cannon(Ang,7*Range2/6);
                       }     
 		   };
	      }
         }
    }
    else
    {    Ang-=13;
         while(!(scan(Ang,10)))
         {    Ang+=20;
              if(Ang>359) Ang=360-Ang;
         };
    };
}



dir_xy(x,y)
int x,y;
{	int d,x0,y0;

	x0=loc_x();
	y0=loc_y();

	if(x0==x)
	{	if(y>y0) d=90;
		else d=270;
	}
	else
	{	d=atan((100000*(y0-y))/(x0-x));
		if(x<x0) d+=180;
		if((y<y0) && (x>x0)) d+=360;
	};
	return(d);
}
