/*

Minicond ver. 1.0 (C) Lorenzo Ancarani 2003

Architettura: MicroBot
Nascita     : Il cuginastro quest'anno è stato più benevolo. Mi ha ricordato del torneo ben 2 mesi prima.
              Nonostante ciò, questo e' tutto quello che sono riuscito a fare.
Strategia   : Versione ridotta di Dynacond, raggiunge l'angolo piu' vicino e poi oscilla
              in una delle due direzioni, preferibilmente in quella con il nemico
              più lontano. 
              La lunghezza dell'attacco è fissata a circa 245 unità;
              ogni certo numero di oscillazioni (6) conta i superstiti, e se ha un unico nemico lo
              attacca con un la routine finale di idefix.

*/


int tempo,b,clock,d,dx,dy,dir,p1,p2,a,oa,or,r,ext,str;
int a,r,dir,oa,or,n,xm,ym,t,clk,limite,fx,fy,en_dis;
int un1,un2,d1;

main() {
   
dy=20+960*(p2=(loc_y(dx=20+960*(p1=(loc_x(limite=7000)>500)))>500));
dir=(360+((fx=dx-loc_x(b=(p2)*180+(p1!=p2)*90))<0)*180+atan(((dy-loc_y(en_dis=850))*100000)/(fx+(fx==loc_x()))));

   while (1) { 

	while (((d=((fx=dx-loc_x())*fx+(fy=dy-loc_y())*fy))>limite)==(limite==7000)) shot(d<28000);
	stop(dir+=180);
	if (limite==7000)
	{
		if ((++t%6)==1)
		{
		        oa=n=0;
        		while((oa+=20)<=360) n+=(scan(oa,10)>0);	
	  		while (n<=1) 
			{
				en_dis=12000;
	                        if ((scan(a,10))>700) dir=a;
        	                else stop(dir+=180); 
        	                shot();
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
      if ((or=Rivela())<en_dis)
        {
          if (r=Rivela())                
             return cannon((oa+(a-oa)*3-(sin(a-dir)/19500)),(r*200/(200+or-r-(cos(a-dir)/4167))));
        }
    }      
  if ((r=scan(a,10))&&(r<en_dis));

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
 {
  while(speed(drive(dir,0))>50);
 }

