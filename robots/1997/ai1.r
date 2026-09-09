
/* 			TORNEO DI CROBOTS 1997			*/

/*				SCHEDA				*/

/*	NOME :		AI1.R					*/
/*	AUTORE :	APUZZO DANILO				*/
/*	EMAIL :		MC4838@MCLINK.IT			*/

/*	DESCRIZIONE :						*/

/*	Ai1.r deriva chiaramente da !.r, l'eccellente crobot	*/
/*	vincitore l'anno scorso : ne riprende il movimento	*/
/*	oscillatorio in un angolo. Diversa e' la tattica di	*/
/*	gioco, i vari controlli sul movimento, la routine di	*/
/*	fuoco e il finale di partita.				*/
/*	Ai1.r si posiziona nell'angolo piu' vicino e incomincia */
/*	ad oscillare. In questa prima fase spara con vari tipi	*/
/*	di correzione sul range e sull'angolo.			*/
/*	Se il damage supera una soglia prefissata, controlla i	*/
/*	due angoli limitrofi e, se uno e' libero, vi si sposta. */
/*	Se i due angoli sono occupati, verifica l'angolo 	*/
/*	opposto in diagonale e, se libero, vi si sposta.	*/
/*	Superato circa il quarto di gara modifica alcuni 	*/
/*	parametri per avere un comportamento piu' conservativo. */
/*	Superata la meta' di gara modifica ancora alcuni	*/
/*	parametri e, soprattutto, incomincia un movimento, piu' */
/*	offensivo, di oscillazione ampia tra circa la meta' di	*/
/*	un lato e l'altra meta', con una routine di sparo piu' 	*/
/*	semplice e diretta; il tutto spostandosi intorno al	*/
/*	campo di gara.						*/





/* DICHIARAZIONE VARIABILI */

int x,y,lato,dir,flag,db,da,sb,lb,frenata,lh,r,parziale;
int deg,rng; 
int oscillazione,previsto,maxdanni,timer,tmp;
int ver, esci;
int ap, rfin, rmax;

/* PROGRAMMA */

main()
{

/* PARAMETRI IMPOSTABILI */

lato=180;
oscillazione=66;
frenata=35;
maxdanni=34;
timer=200;

ap=1;
rfin=250;
rmax=859;

while (1)
{

drive(dir+180,0);
while(speed()>49);

/* INIZIALIZZA LE VARIABILI */

db=999-oscillazione;
da=999-lato+oscillazione;
sb=lato-oscillazione;
lh=999-lato-frenata;
lb=lato+frenata;
flag=-1;

ver=0;
esci=1;


/* SI PORTA AL PUNTO DI PARTENZA */


y=loc_y();
if ((x=loc_x())<500)
{ if (y<500) vai(lato,0,135);
else vai(0,999-lato,45); }
else { if (y<500) vai(999,lato,225);
else vai(999-lato,999,315); }
previsto=damage()+maxdanni;


/* OSCILLAZIONI NELL'ANGOLO PRIMA BREVI E POI AMPIE */

while(esci)
{

/* PARAMETRI DA IMPOSTARE DOPO 1/4 DI GARA	*/

if ((ap) && (timer<120)) { maxdanni=10; previsto=damage()+maxdanni; ap=0; rmax=999; }

drive(dir,100);
if (parziale==45) while (loc_x()<db) { fuoco(); drive(dir,100); }  else
if (parziale==135) while (loc_x()>da) { fuoco(); drive(dir,100); } else
if (parziale==315) while (loc_x()<sb) { fuoco(); drive(dir,100); } else
while (loc_x()>oscillazione) { fuoco(); drive(dir,100); }
drive(dir,0);
while(speed()>89);
--timer;

/* SPOSTAMENTO LATERALE */

if ( ( !(scan((parziale=((dir+45*flag+360)%360)),10)) && !(scan(parziale+20*flag,10)) ) && ( ((timer<=0) && (damage()<95)) || (damage()>previsto) )  )

/* if ( ((timer<=0) && (damage()<95)) || ( (damage()>previsto) && !(scan((parziale=((dir+45*flag+360)%360)),10)) && !(scan(parziale+20*flag,10))) ) */
/* if ( (damage()>previsto) && !(scan((parziale=((dir+45*flag+360)%360)),10)) && !(scan(parziale+20*flag,10)) ) */
{
while(speed()>49);
drive((dir=parziale),100);
if (dir==90) while (loc_y()<lh) fuoco(); else
if (dir==180) while (loc_x()>lb) fuoco(); else
if (dir==270) while (loc_y()>lb) fuoco(); else
while(loc_x()<lh) fuoco();
drive(dir,0);
dir=(dir+45*flag+360)%360;
previsto=damage()+maxdanni;

/* PARAMETRI DA IMPOSTARE DOPO 1/2 DI GARA	*/

if (timer<=0) { timer+=6; lato=480; esci=0; oscillazione=76; ap=0; rfin=999; }

while(speed()>49);
}
else if (damage()>previsto)
	ver=((ver+1)%3);
else ver = 0;

/* SPOSTAMENTO IN DIAGONALE	*/

if (ver==2) 
{

if ( !(scan((parziale=((dir+90*flag+360)%360)),10)) && !(scan(parziale+20*flag,10)) )
{
drive(dir,0);
while(speed()>49);
	y=loc_y();
	if ((x=loc_x())<500)
	{ if (y<500) vai(999-lato,999,315);
	else vai(999,lato,225); }
	else { if (y<500) vai(0,999-lato,45);
	else vai(lato,0,135); }
	previsto=damage()+maxdanni;
}
else ver=0; 

}

/* INVERTE OSCILLAZIONE */

if (!(ver==2))
{
(dir+180)%=360;
parziale=((flag*=-1)*dir+360)%360;
}
else { ver=0; flag=-1; }


}  /* esci */
}  /* endwhile(1) */
}  /* main */

/* SPOSTAMENTO VERSO UN PUNTO FISSATO */

vai(tx,ty,tmp)
{
x=loc_x()-tx;
y=(loc_y()-ty)*100000;
if (tx>loc_x()) dir=360+atan(y/x); else dir=180+atan(y/x);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>6100) { drive(dir,100); fuoco(); }
drive(dir,49);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>225) drive(dir,49);
drive((dir=tmp),49);
parziale=(-dir+360)%360;
}



/* ROUTINE DI SPARO */


fuoco()
{
int odeg;

								
if (!(rng=scan(deg,10)))					
if (!(rng=scan(deg-=20,10)))					
if (!(rng=scan(deg+=40,10))) { deg+=40; return; }		
odeg=deg; 
if (!scan(deg+=5,5)) deg-=10;				
if (!scan(deg+=3,3)) deg-=6;					


if (rng<rmax) {  

if ( (r=scan(deg,10)) && (r>rfin) ) 
 {	
 if ( ((r-rng)>25) || ((rng-r)>25) ) 
 cannon(deg,r+r-rng+r-rng);		
 else 			
 cannon(deg+deg-odeg,r+r-rng);
 } 

 else  
 cannon(deg,r+r-rng);
		}	

if (rng>705) deg+=40;
}								




