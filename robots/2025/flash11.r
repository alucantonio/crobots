/*
Crobot    : Flash
Type      : Micro
Version   : 11
Author    : Olga S
Begin     : 12-10-2024
Revision  : 12-10-2024

Flash 8c..... clockwise!

*/
int a,b,c,y;
int dir,range,orange,ang,oang,asin,acos;

Search()
{
  	if (range=scan(ang+=350,10)) 	return cannon(ang,range);
  	if (range=scan(ang+=20,10))  	return cannon(ang,range);
  	if (range=scan(ang+=320,10)) 	return cannon(ang,range);
  	if (range=scan(ang+=60,10))  	return cannon(ang,range);
  	if (range=scan(ang+=280,10)) 	return cannon(ang,range);
  	Search(ang-=220);
}

main()
{
   dir=90*(a=((y=loc_y()<500)<<1)|((loc_x()<500)^y));
   while(1)
   {
     if (a&1) b=loc_y(); else b=loc_x();
     if (a&2) c=b>180;   else c=b<820;
     
     if (c)
     {
         if(speed()<100) drive(dir,100); 
         if(scan(ang,10) > 100)
      	 {  
          	asin=(sin(ang-dir)/14384);
    	      acos=(cos(ang-dir)/3796)-230;
          	ang-=18*(scan(ang-18,10)>0); 
    	      ang+=18*(scan(ang+18,10)>0); 
          	if(scan(ang-16,10)) ang-=8;
    	      else if(scan(ang+16,10)) ang+=8;
          	if(scan(ang-12,10)) ang-=4;
    	      else if(scan(ang+12,10)) ang+=4;
          	if(scan(ang-11,10)) ang-=2;
    	      if(scan(ang+11,10)) ang+=2;
          	if(orange=scan(oang=ang,3))
    		    {
          	      if(scan(ang-13,10)) ang-=5;
                	else if(scan(ang+13,10)) ang+=5;
    	            if(scan(ang+12,10)) ang+=4;
          	      else if(scan(ang-12,10)) ang-=4;
                	if(scan(ang-11,10)) ang-=2;
    	            if(scan(ang+11,10)) ang+=2;
          	      cannon(ang+(ang-oang)*((880+(range=scan(ang,10)))/482)-asin, range*230/(orange-range-acos)); 
    		    }
    		else 	Search(); 
      	}
    	else 	Search();  
     }
     else
     {
       drive(dir+=270,0); if (scan(dir,10)) ang=dir; --a;
     }
   }
}
