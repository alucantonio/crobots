/*
Crobot    : Flash
Type      : Micro
Version   : 8e
Author    : Olga S
Begin     : 22-03-2011
Revision  : 13-01-2012

Generazioni di robot della famiglia "Flash" sono passate di mano in mano. Ora
tocca a me!
Questa versione è piuttosto innovativa: usa praticamente un'unica rountine Main,
ad esclusione della utility fire (per risparmiare spazio). Come i suoi
predecessori, gira lungo i bordi in senso anti-orario, sparando a chi capita.
Nella Main è inclusa la routine F2F.
*/
int a,b,c,x,y,z,t;
int dir,range,orange,ang,oang/*,asin,acos*/;

fire(d,v)
{
	drive(d,v);
	if (range=scan(oang=ang,10)) 
	{
		if (scan(ang-8,5))  
		{ 	
			if (scan(ang-=5,2)) ; 
			else ang-=4; 
		}
		else
		{
			if (scan(ang+8,5))  
			{
				if (scan(ang+=5,2)) ; 
				else ang+=4; 
			}
		}
		return(cannon((ang<<1)-oang,(scan(ang,10)<<1)-range)); 
	} 
	else 
	{
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else ang+=80;
	}
}

main()
{
  dir=90*(a=((y=loc_y(t=2)<500)<<1)|((x=loc_x()<500)^y));
   while(1)
   {
     if (a&1) b=loc_y(); else b=loc_x();
     if (a&2) c=b>110;   else c=b<890;
     
     if (c)
     {
      fire(dir,100);
     }
     else
     {
       drive(dir+=90,0);
       if (++t==4)
       {
         t=0;
         if (
            ((scan(dir,    10)!=0)
            +(scan(dir+19, 10)!=0)
            +(scan(dir+38, 10)!=0)
            +(scan(dir+57, 10)!=0)
            +(scan(dir+76, 10)!=0)
            +(scan(dir+95, 10)!=0)
            )<2)
         {
         	while(1) 
        	{
        		if ((x=loc_x())>880) dir=180;
            else if (x<120 ) dir=0;
            else if ((y=loc_y())>880) dir=270;
            else if (y<120) dir=90;
        		else if (range>600) dir=ang+20;
        		else if (range<150) dir=ang+200;
        		else dir=ang+180*(z^=1);
        		fire(dir,100);
        		fire(dir,100);
        		fire(dir,100);
        	}
         }
       }
       if (scan(dir,10)) fire(ang=dir,100); ++a;
     }
   }
}
