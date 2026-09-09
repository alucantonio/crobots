/*
	Trucillo Marco

	Questo crobots si basa su Vision di Alessandro Carlin
      sembra che cosi va meglio ;)

*/
int andata,ritorno,destra,inbasso,fianco,ang,dir;



main()
{
        ang=0;                                                   
        drive(dir=90,100);                               /*   salgo su */
        while (loc_y() < 840) kill();
	stop();
        if ((!scan(0,10))&&(!scan(342,10))) {            /*decido che angolo andare */      
        	drive(dir=0,100);                            /* ci vado */ 
	        andata=180;                                /* setto le oscillazioni*/     
	        ritorno=0;
	        destra=1;                                  /* segno che sto qui */
	        while(loc_x() < 860) kill();

	        stop(); 
	}
        else {                        
        	drive(dir=180,100);                         
	        andata=0;                                           /* settaggio da altro angolo */
	        ritorno=180;
	        destra=0;                                                   
        	while(loc_x() > 160) kill();

	        stop(); 
	}
	while(1)
	{
        	inbasso=scan(270,10);                                       /* controllo a giu' */
	        fianco=scan(andata,10);                                     /*  controllo lato libero */  
	        if (inbasso<=fianco){                                        /* è libero giu'? */   
        	        drive(dir=270,100);                            /* ci vado e oscillo sparando */    
                	while (loc_y() > 685)  kill();
		
                	stop();
	                drive(dir=90,100);
        	        kill();
                	kill();
	                while (loc_y() < 910) mortal();
			
	                stop();  
		}
                else {                                        /* è meglio a lato ? */ 
                	drive(dir=andata,100);                      /* oscillo in avanti*/
	                if (destra==0)                          /* sto a sinistra? */
				while(loc_x() <= 285) kill();         /* spara fino alla fine dell' oscillazione*/
         		else                                        /* dall' altra parte ? */
			        while(loc_x() >715) kill();         /* idem */
                
                
             		stop();               
	                drive(dir=ritorno,100);                 /* oscillo dietro */
        	        kill();
                	kill();
	                if (destra==0) 
				while(loc_x() > 95) mortal();
              	        else 
				while(loc_x() < 910) mortal();
	                
			stop();  
		}
	}
}


int   d,oang,range,orange,aa,rr,diff;



kill()       
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



stop()  {                            
	drive(dir,0);
        
                
        while(speed() > 49) mortal();

}


mortal()
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

