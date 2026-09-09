/* CROBOT*/
/* Name: smart.r*/
/* Date: 05/10/2010 */
/* Author: Simone Chiarelli */
/* Category: 1925/2000 (macro)*/

/**********************************************************************************
Introduzione:
-------------------
Durante la creazione di smart.r ho cercato di essere il piu'
possibile originale. Ovviamente per quanto riguarda le routine
di fuoco, si sa che ormai, dopo l'evoluzione che c'e' stata negli
anni, e' difficile esserlo; infatti sono copiate da altri c-robots
ed ogni tentativo di migliorarle e' stato vano, o quasi.
Nella strategia invece e' stato possibile fare di meglio.

Descrizione:
-------------------
All' inizio dell' incontro smart.r si posiziona nell'angolo
piu' vicino ed assume subito di trovarsi nel peggiore dei casi.
In seguito entra nella prima fase della sua strategia,
la quale prevede il costante controllo degli angoli adiacenti
ed un eventuale spostamento in caso uno di essi risulti
piu' o meno libero (il "piu' o meno" e' importante perche' fa
parte di una scelta strategica). L'eventuale spostamento consiste
nel muoversi verso l'angolo libero fino a meta' percorso,
per poi oscillare sul posto finche' non riceve un danno consistente
o l'angolo non torna a essere occupato (o un certo numero di oscillazioni
non sia stato raggiunto); se una volta spostatosi decide di ritirarsi
nel suo angolo perche' danneggiato troppo, passa alla seconda fase
della strategia, nella quale non viene considerato lo spostamento verso
gli eventuali angoli liberi. Nel caso in cui gli angoli risultino
tutti e due occupati, smart.r spara con la routine di fuoco specifica
per il 4v4 agli avversari, controllando il range di tiro e
rimandendo fermo. Se un avversario si avvicina troppo,
smart.r si muove a seconda della distanza dell'avversario:
se e' a media distanza fa un movimento aggressivo,
muovendosi a triangolo verso uno dei due angoli adiacenti, che
non sia vuoto e comunque prediligendo l'angolo lungo l'asse y;
se e' troppo vicino, fa un movimento evasivo a forma di quadrato
vicino al proprio angolo, che varia grandezza a seconda del danno
subito fino a quel momento.
Smart.r non ha nessuna routine per il controllo degli avversari,
ne un attacco finale, in quanto non li ho ritenuti necessari
( e comunque non ci sarebbero entrati ). Una nota importante
a riguardo e' che il robot sceglie la routine di fuoco in base
alla distanza dall'avversario: se la distanza e' abbastanza
ravvicinata sceglie quella piu' aggressiva per il f2f, altrimenti l'altra.
**********************************************************************************/

int rng,orng,deg,odeg,dir,en,dam,xs,ys,phase,t,ccflag;

main()
{
    en=3;
    Corner(ccflag=0);
    WorstCase(phase=0);
    while(en>1)
    {
		if(phase==0)
		{
			if(rng>599&&!Look(180*xs)&&(++ccflag)>=6) /*free right/left */
			{
				dam=damage(t=0)+5;
				while(damage()<dam&&!Look(180*xs)&&(++t)<240){
					if(xs){sx(500,180);dx(500,0);}
					else{dx(500,0); sx(500,180);}
				}
				if(Look(180*xs))
					VoidCorner(WorstCase());
				else
					phase=1;
			}
			else if(rng>599&&!Look(90+180*ys)&&(++ccflag)>=6) /*free up/down */
			{
				dam=damage(t=0)+5;
				while(damage()<dam&&!Look(90+180*ys)&&(++t)<240){
					if(ys){ dw(500,270); up(500,90);}
					else{up(500,90); dw(500,270);}
				}
				if(Look(90+180*ys))
					VoidCorner(WorstCase());
				else
					phase=1;
			}
		}
		if(rng>0 && rng<(780+(2*damage())/*828+50*phase*/)){
			WorstCase();
		} else{
			Fire();
		}
    }
}

up(l,d) { while(loc_y()<l) {  Fire(drive(dir=d,100)); } Stop(); }
dw(l,d) { while(loc_y()>l) {  Fire(drive(dir=d,100)); } Stop();  }
dx(l,d) { while(loc_x()<l) {  Fire(drive(dir=d,100)); } Stop(); }
sx(l,d) { while(loc_x()>l) {  Fire(drive(dir=d,100)); } Stop();   }

WorstCase()
{
	int dm;
	if(rng>649)
	{
		if(Look(90+180*ys)>0) /*Y*/
		{
			deg=90+180*ys;
			if(ys) dw(500,270+22-44*xs); else up(499,90-22+44*xs);
			if(xs) dx(850,0); else sx(150,180);
			if(ys) up(850,90); else dw(150,270);
		}
		else
		{
			deg=180*xs;
			if(xs) sx(500,180-22+44*ys); else dx(499,22+360-44*ys);
			if(ys) up(850,90); else dw(150,270);
			if(xs) dx(850,0); else sx(150,180);
			
		}
	}
	if(rng<=649)
	{
		dm = ((damage()>24))*200;
		if(ys) dw(750-dm,270); else up(250+dm,90);
		if(xs) sx(750-dm,180); else dx(249+dm,0);
		if(ys) up(850,90); else dw(150,270);
		if(xs) dx(850,0); else sx(150,180);
	}
	
}

VoidCorner()
{
	int ly,lx;
	Corner();
	ly = Look(90+180*ys);
	lx = Look(180*xs);
	if(!ly && !lx){
		phase=1;
	}
	else if(!ly)
		ChangeCorner(90+180*ys);
	else if(!lx)
		ChangeCorner(180*xs);
}

ChangeCorner(where)
{
	if(where==180){
		sx(400,where);
	}
	else if(where==0){
		dx(600,where);
	}
	else if(where==90){
		up(600,where);
	}
	else if(where==270){
		dw(400,where);
	}
	else {
		if(ys) dw(150,where); else up(850,where);
	}
	Corner(phase=0);
}

Corner()
{
	if ((xs=loc_x(ys=loc_y()>499)>499)){ dx(860,0); }else{ sx(140,180); }
    if (ys){ up(860,90); }else{ dw(140,270); }
}

Stop()
{
    while(speed(drive(dir,0))>50) FireXX();
	drive(dir,0);
}

Look(d)
{
	return(/*(scan(d-10,10)+scan(d+10,10))/2*/scan(d,10));
}

Fuoco()
{
  	int asin,acos;
    
	if(scan(deg,10) > 100)
  	{  
      	asin=(sin(deg-dir)/14384);
	      acos=(cos(deg-dir)/3796)-230;
      	deg-=18*(scan(deg-18,10)>0); 
	      deg+=18*(scan(deg+18,10)>0); 
      	if(scan(deg-16,10)) deg-=8;
	      else if(scan(deg+16,10)) deg+=8;
      	if(scan(deg-12,10)) deg-=4;
	      else if(scan(deg+12,10)) deg+=4;
      	if(scan(deg-11,10)) deg-=2;
	      if(scan(deg+11,10)) deg+=2;
      	if(orng=scan(odeg=deg,3))
		{
      	      if(scan(deg-13,10)) deg-=5;
            	else if(scan(deg+13,10)) deg+=5;
	            if(scan(deg+12,10)) deg+=4;
      	      else if(scan(deg-12,10)) deg-=4;
            	if(scan(deg-11,10)) deg-=2;
	            if(scan(deg+11,10)) deg+=2;
      	      cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin, rng*230/(orng-rng-acos)); 
		}
		else 	Find(); 
  	}
	else 	Find();  
}

Find()
{
  	if (rng=scan(deg+=350,10)) 	return cannon(deg,rng);
  	if (rng=scan(deg+=20,10))  	return cannon(deg,rng);
  	if (rng=scan(deg+=320,10)) 	return cannon(deg,rng);
  	if (rng=scan(deg+=60,10))  	return cannon(deg,rng);
  	if (rng=scan(deg+=280,10)) 	return cannon(deg,rng);
  	Find(deg-=220);
}

fire()
{
  	int asin,acos;
  	if(rng > 850) deg+=180;
  	if (scan(deg,10) > 100)
  	{  
      	asin=(sin(deg-dir)/14384);
      	acos=(cos(deg-dir)/3796)-230;
      	deg-=18*(scan(deg-18,10)>0);  
      	deg+=18*(scan(deg+18,10)>0); 
      	if(scan(deg-16,10)) deg-=8;
      	else if(scan(deg+16,10)) deg+=8;
      	if(scan(deg-12,10)) deg-=4;
      	else if(scan(deg+12,10)) deg+=4;
      	if(scan(deg-11,10)) deg-=2;
      	if(scan(deg+11,10)) deg+=2;
      	if (orng=scan(odeg=deg,3))
     		{
            	if(scan(deg-13,10)) deg-=5;
            	else if(scan(deg+13,10)) deg+=5; 
            	if(scan(deg+12,10)) deg+=4;
            	else if(scan(deg-12,10)) deg-=4;
            	if(scan(deg-11,10)) deg-=2;
            	if(scan(deg+11,10)) deg+=2;
            	cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin, rng*230/(orng-rng-acos)); 
     		}  
		else 	Search(); 
  	} 
	else 	Search();  
}

Search()
{
  	if (scan(deg-=350,10)) return FireXX();
  	if (scan(deg-=20,10))  return FireXX();
  	if (scan(deg-=320,10)) return FireXX();
  	if (scan(deg-=60,10))  return FireXX();
  	if (scan(deg-=280,10)) return FireXX();
  	if (scan(deg-=100,10)) return FireXX();
  	if (scan(deg-=240,10)) return FireXX();
  	if (scan(deg-=140,10)) return FireXX();
  	if (scan(deg-=200,10)) return FireXX();
  	if (scan(deg-=180,10)) return FireXX();
  	if (scan(deg-=160,10)) return FireXX();
  	if (scan(deg-=220,10)) return FireXX();
  	if (scan(deg-=120,10)) return FireXX();
  	if (scan(deg-=260,10)) return FireXX();
  	if (scan(deg-=80,10))  return FireXX();
  	if (scan(deg-=300,10)) return FireXX();
  	if (scan(deg-=40,10))  return FireXX();
  	if (scan(deg-=340,10)) return FireXX();
}

FireXX()
{
  	if (rng=scan(odeg=deg,10)) 
	{    
    		if (scan(deg-13,10))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    		if (scan(deg+13,10))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    		if (scan(deg,10))     { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
  	}  
	else 	Find();
}

Fire(d)
{
	if(rng>0 && rng<450) Fuoco(); else fire();
}