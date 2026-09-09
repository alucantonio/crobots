/*

New_Mini ver. 1.0 (C) Lorenzo Ancarani 2004

Architettura: MicroBot
Strategia   : Versione evoluta di Minicond, raggiunge l'angolo piu' vicino e poi oscilla
              in una delle due direzioni, preferibilmente in quella con il nemico
              più lontano. 
              La lunghezza dell'attacco è fissata a circa 245 unità;
              Controlla sempre il numero dei nemici superstiti, e se ne trova solo 1, attacca
	      lungo la bisettrice del quadrante. Se si accorge di avere sbagliato, e che in effetti i 
	      cattivi sono di +, oppure ha subito troppi danni, oscilla sulla bisettrice.
Note:	      Minicond cerca di usare al minimo le subroutine. Infatti l'unica richiamata è la shot().
	      Il resto è tutto nel ciclo principale.

*/


int tempo,b,clock,d,dx,dy,dir,p1,p2,a,oa,or,r,ext,str;
int a,r,dir,oa,or,n,xm,ym,t,clk,limite,n_limite,fx,fy,en_dis;
int un1,un2,d1;

main() {
   
dy=30+940*(p2=(loc_y(dx=30+940*(p1=(loc_x(limite=7000)>500)))>500));
dir=(360+((fx=dx-loc_x(b=(p2)*180+(p1!=p2)*90))<0)*180+atan(((dy-loc_y(en_dis=850))*100000)/(fx+(fx==loc_x()))));

   while (1) { 
	n=(limite==7000);
	while (((d=((fx=dx-loc_x(drive(dir,100)))*fx+(fy=dy-loc_y(shot(d<28000)))*fy))>limite)==n) ;

	drive(dir+=180,0);shot(1);

	if (n)
	{
		oa=b-40;
        	while((oa+=20)<=b+130) limite+=(scan(oa,10)>0);	
	  	if (limite<=7001) 
			{
				en_dis=n_limite=1000000;
				dir=b+45;
			}
		else n_limite=35000;
			
		if (dir%90);else
		if (damage(dir=b+45)>60);
		else if ((scan(dir=b,10)>scan(90+b,10))==(damage(n_limite=60000)<30)) dir+=90;
		limite=n_limite;

	}
	else limite=7000;
	d1=dir;
   }
}


int shot(best)
int best;
{
 
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
