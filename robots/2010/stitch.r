/* 
Nome: 	stitch.r		(micro)
Autore: 	Franco Cartieri

Torneo 2010

Descrizione squadra:
La squadra di quest'anno è formata da Stitch, Jumba, Reuben e Gantu. I nomi derivano dal film Lilo&Stitch di cui mio figlio è un grande fan.
Stitch (micro): è un piccolo esperimento creato da Jumba, ma ha una forza 3000 volte superiore al suo peso, speriamo si comporti bene anche con robot di categoria maggiore...
Reuben (midi): è un altro esperimento malriuscito di Jumba, come forza lascia molto a desiderare, però è simpatico...
Gantu (macro): è un alieno grande, grosso e un po' sfigato, penso che non combinerà molto neanche qui...
Jumba (macro): è uno scienziato un po' pazzo, le sue invenzioni sono quasi sempre improbabili, chissà se questa volta avrà un colpo di genio...

Descrizione robot:
All'inizio dell'incontro Stitch si posiziona nell'angolo e inizia a muoversi lungo lati dell'arena prima orizzontalmente poi verticalmente 
senza mai allontanarsi troppo dall'angolo.
Ogni 12 cicli controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.
Anche se il numero di oscillazioni supera una certa soglia parte all'attacco anche se è rimasto più di un nemico 
nella speranza che siano già abbastanza danneggiati.
L'attacco finale consiste in una serie di oscillazioni veloci volte a mantenere il nemico ad una distanza abbastanza costante.
Stitch utilizza un unica routine di fuoco con una leggera variazione nel caso sia un f2f o un 4vs4.
Per farlo rientrare nelle 500 istruzioni ho dovuto rinunciare alla routine di fuoco toxica e alla routine dedicata al f2f di Gantu.

Un ringraziamento a tutti gli autori da cui ho preso parti di codice, in particolare agli autori di Alien, Danica, Proud e Wgdi.
*/

int b,dir,rng,orng,deg,odeg,x,y,ff;
int xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd;

f2f()
{
	ff=1;
	while(1) 
	{
		if ((x=loc_x())>880) dir=180;
                else if (x<120 ) dir=0;
                else if ((y=loc_y())>880) dir=270;
                else if (y<120) dir=90;                      
		else if (rng>600) dir=deg+25;
		else if (rng<150) dir=deg+195;
		else dir=deg+180*(b^=1);
		fire(dir,100);
		fire(dir,100); 
		fire(dir,100);
	}
}

main()
{
 	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=3))>499)*880)>499)*880;
  	drive(xd=180*xs,100); 
 	dmax=(dmin=zd=((yd=(90+180*ys))-105+90*(xs^ys)))+100;
	ff=0;
 	while(en>1) 
	{
    		run(xd,xp,2-xs);	
	    	run(yd,yp,6-ys);	
  	}
	f2f();
}


fire(dir,v)
{
	drive(dir,v);
	if (rng=scan(odeg=deg,10)) 
	{
		if (scan(deg-8,5))  
		{ 	
			if (scan(deg-=5,2)) ; 
			else deg-=4; 
		}
		else
		{
			if (scan(deg+8,5))  
			{
				if (scan(deg+=5,2)) ; 
				else deg+=4; 
			}
			else
			{
				if (scan(deg,10))   
				{ 
					if (scan(deg-=2,2)) ; 
					else deg+=4; 
				}
			}
		}
		return(cannon(deg+ff*(deg-odeg),2*scan(deg,10)-rng)); 
	} 
	else if(scan(deg+=20,10));
	else if(scan(deg-=40,10));
	else deg+=80;
}

run(d,l,m) 
{ 
  	int r;
  	if (timer%12==2)
	{
    		en=0;
    		while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
    		dmin=zd; 
  	}
  	while(r<2) 
	{
	  	drive(d,100);
		++r;
  		if (++timer>500+damage()) f2f(); 
    		if (scan(d,10)) 
		{ 
			deg=d; 
			while (scan(d,10)>840) ; 
		} 
		else 	while(check(l,m)) ;
      		fire(d,0);  
  		while(speed()>59) ;
  		++m;  
  		d+=180;
  	} 
}

check(l,m) 
{
  	int c1;
  	if (m<5) c1=loc_x(); else c1=loc_y();
  	if (m%2) return (c1>l); else return (c1<l);	
}	


