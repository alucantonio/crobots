/*

Dynacond ver. 1.0 (C) Lorenzo Ancarani

Architettura: ClassicBot
Nascita     : Il cuginastro quest'anno è stato più benevolo. Mi ha ricordato del torneo ben 2 mesi prima.
              Nonostante ciò, questo e' tutto quello che sono riuscito a fare.
Strategia   : il robot raggiunge l'angolo piu' vicino e poi oscilla
              in una delle due direzioni, preferibilmente in quella con il nemico
              più lontano. 
              La lunghezza dell'attacco è fissata a circa 245 unità;
              ogni certo numero di oscillazioni (3) conta i superstiti, e se ha un unico nemico lo
              attacca con un derivato de 'iLbEsTiO.r'.

*/


int tempo,b,clock,d,dx,dy,dir,p1,p2,a,oa,or,r,ext,str;
int a,r,dir,oa,or,n,xm,ym,t,clk,limite,fx,fy;
int un1,un2,d1,flag,cl;

main() {
   
dy=20+960*(p2=(loc_y(dx=20+960*(p1=(loc_x(limite=7000)>500)))>500));
dir=(360+((fx=dx-loc_x(b=(p2)*180+(p1!=p2)*90))<0)*180+atan(((dy-loc_y())*100000)/(fx+(fx==loc_x()))));

   while (1) { 

	while (((d=((fx=dx-loc_x())*fx+(fy=dy-loc_y())*fy))>limite)==(limite==7000)) shot(d<28000);
	stop(dir+=180);
	if (limite==7000)
	{
		if ((++t%3)==1)
		{
		        oa=n=0;
        		while((oa+=20)<=360) n+=(scan(oa,10)>0);	
			flag=3;
	  		while (n<=1) 
			{	if (--flag)
				if (loc_x()>700) stop(dir=180);
				else if (loc_y()>700) stop(dir=270);
				else if (loc_x()<300) stop(dir=0);
				else if (loc_y()<300) stop(dir=90);
				else;
				else {stop(dir=(a+135)+90*(cl^=1));}
				drive(dir,100);
				fuoco();
	
			}
 
		}

		if ((scan(dir=b,10)>scan(90+b,10))==(damage(limite=60000)<80)) dir+=90;
		d1=dir;

	}
	else limite=7000;
   }
}


int shot(best)
int best;
{
 drive(dir,100);
 if (best);
 else if (scan(a,10))
    {
      if ((or=Rivela())<850)
        {
          if (r=Rivela())                
             return cannon((oa+(a-oa)*3-(sin(a-dir)/19500)),(r*200/(200+or-r-(cos(a-dir)/4167))));
        }
    }      
  if ((r=scan(a,10))&&(r<850));

  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(d1,10))) a=d1;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}

Rivela()   
{
  if(scan((oa=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

stop()
 {flag=3;
  while(speed(drive(dir,0))>50);
 }

fuoco() {
    if (or=scan(a,10));
    else if (or=scan(a-=20,10));
    else if (or=scan(a+=40,10));
    else return a+=41; 
    { 
        if (!scan(a+=354,6)) a+=12; 
        if(scan(a-6,2)) a-=6; 
        else if(scan(a+6,2)) a+=6;
        fnd();
        if (or=scan(oa=a,10)) 
        { 
           if(scan(a-7,3)) a-=7; 
           else if(scan(a+7,3)) a+=7;
           fnd(); 
           if (r=scan(a,10)) 
           { 
                cannon(a+((a-oa)*((700+r))>>9)-(sin(a-dir)>>14), 
                       r*179/(179+or-r-(cos(a-dir)>>12))); 
           } 
 
        } 
        else { 
                if (!(or=scan(a+=339,10))){  
                        if (!(or=scan(a+=41,10))) { 
                                if(!(or=scan(a+=21,10))) { 
                                        return a+=41; 
                                } 
                        } 
                } 
                else if (!scan(a+=354,6)) a+=12;  
                return cannon (a, 2*scan(a,10)-or);
        }
     } 
} 



fnd()
{
 if(scan(a-4,1)) a-=4;
 if(scan(a+4,1)) a+=4; 
 if(scan(a-2,1)) a-=2; 
 if(scan(a+2,1)) a+=2; 
}

