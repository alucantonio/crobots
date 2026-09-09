 /* 

		Trucillo Francesco

     
   Obi-Wan-Kenobi è stato allievo di Quin-Gon-gin da cui ha imparato 
   lo stile di battaglia Jedi che usa in modo personale :
   va nell'angolo vicino ed oscilla diversamente dal maestro.


*/ 

int dz,ov,dx,ang,dir,danni;
      
main()
{
                       
    if(loc_y()<500) {                                /* non sono in alto ? */
	           drive(dir=270,100);                 /* vai in basso */
                 while (loc_y() > 160) spadalaser(); /* intanto attacca */
	           alt();
             if(!scan(180,10)) {                      /* posso andare a sinistra? */
                 drive(dir=180,100);
                 dz=0;                                /* oscillazione orizzontale possibile */   
                 ov=90;                               /* oscillazione verticale possibile */
                 dx=0;                                /*  sto nell'angolo sinistro   */
                 while(loc_x() > 140)  spadalaser();
	  
                 alt(); 
         }
              else {
                   drive(dir=0,100);
                   dz=180;
                   ov=90;
                   dx=1;
                   while(loc_x() < 840) spadalaser();
	
                   alt(); 
              }
     }
     else{                                                  /*    sono in alto? */ 

              drive(dir=90,100);                            /* vai su */
              while (loc_y() < 840) spadalaser();
	        alt();
              if(!scan(0,10)) {
              drive(dir=0,100);
              dz=180;
           
              dx=1;
              while(loc_x() < 860) spadalaser();
	         ov=270;
               alt();
         }
           else {
                 drive(dir=180,100);
                 dz=0;
                 ov=270;
                 dx=0;
                 while(loc_x() > 160) spadalaser();
	
                 alt();
           }
     }


	while(1)
	{
      
                       drive(dir=dz,100);
                       if (dx==0) while(loc_x() <= 285) spadalaser();
                
                          else while(loc_x() >715)  spadalaser();
               
                          alt();
                          drive(dir=(dz+180)%360,100);
                           spadalaser();
                           spadalaser();
                             if (dx==0) while(loc_x() > 95)   armajedi();

                             else while(loc_x() < 910) armajedi();
                
                          alt(); 

              danni=damage(); 
              if(danni>50) /*se le oscillazioni orzzontali non rendono alterna con quelle in verticale */
              {   
                 if(ov==270){
                    drive(dir=ov,100);
                	  while (loc_y() > 685)  spadalaser();
		
                	  alt();
	              drive(dir=(ov+180)%360,100);  spadalaser();  	spadalaser();
	              while (loc_y() < 910) armajedi();
			
	              alt();  

                  }   else{

                     drive(dir=ov,100);
                     while (loc_y() < 285)    spadalaser();
		
                     alt();
                     drive(dir=(ov+180)%360,100); spadalaser(); spadalaser();
                     while (loc_y() > 90)  armajedi();
		
                     alt(); 

                          }
 
              }
    }
}


int   d,oang,range,orange,aa,rr,diff;






spadalaser()       
{
        if(range=scan(ang,5))
	{
                cannon(ang,range);
                if(scan(ang-5,1)) ang-=5;
		if(scan(ang+5,1)) ang+=5;
		if(scan(ang-3,1)) ang-=3;
		if(scan(ang+3,1)) ang+=3;
		if(scan(ang-1,1)) ang-=1;
		if(scan(ang+1,1)) ang+=1;
		if (range=scan(ang,5))
		{
			orange=range;
			oang=ang;
                       	if(scan(ang-5,1)) ang-=5;
			if(scan(ang+5,1)) ang+=5;
			if(scan(ang-3,1)) ang-=3;
			if(scan(ang+3,1)) ang+=3;
			if(scan(ang-1,1)) ang-=1;
			if(scan(ang+1,1)) ang+=1;

			if (range=scan(ang,10))
			{
				aa=(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14));
				rr=(range*160/(160+orange-range-(cos(ang-dir)>>12)));
				while(!cannon(aa,rr));
				if (range>700) ang+=30;
			}
			else if(scan(ang-=10,10));
			else if(scan(ang+=20,10));
			else ang+=40;
		}
		else if(scan(ang-=10,10));
		else if(scan(ang+=20,10));
		else ang+=40;
	}
	else if(scan(ang-=10,10));
	else if(scan(ang+=20,10));
	else ang+=40;
}



alt()  {                            
	drive(dir,0);
        
                
        while(speed() > 49) armajedi();

}


armajedi()
{  
 if ( (d=scan(ang,10)) && (d<750) ) 
  { 
   if (d=scan(ang+353,3)) cannon(ang+=353,d);
   else if (d=scan(ang,3)) cannon(ang,d);
   else if (d=scan(ang+7,3)) cannon(ang+=7,d); 
  }
 else
  {
   if ((d=scan(ang+21,10))&&(d<710)) {ang+=21;cannon(ang,d);}
   else if ((d=scan(ang+42,10))&&(d<710)) ang+=42;
        else ang+=63;
  }  
}                         






