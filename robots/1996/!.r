/* ROBOT       : !.R
/*
/* VERSIONE    : 1.0, 29 settembre 1996                                    
/*                                                                         
/* DIMENSIONE  : 892/1000
/*
/* AUTORE      : Paolo Zavarise                       
/*
/* INTRODUZIONE: Effettivamente non sapevo proprio come chiamare questa mia
/*               creazione !!! Dopo ore e ore di meditazione (praticamente ho
/*               passato piu' tempo a scegliergli il nome che a programmarlo)
/*               l'ho battezzato in questo modo per una serie di motivi:
/*               1) Non ci sono aggettivi abbastanza forti per descriverne
/*                  l'efficienza nel combattimento.
/*               2) E' sicuramente il primo in ordine alfabetico (posizione
/*                  che, comunque, occupera' anche nella classifica finale)
/*               3) Chi non avrebbe paura sapendo di doversi misurare contro
/*                  un avversario chiamato ! ???
/*
/* TATTICA     : Inizialmente il robot si sposta nell' angolo piu' vicino,
/*               tramite il percorso piu' breve. In seguito comincia a
/*               oscillare velocemente con un inclinazione di 45ø rispetto al
/*               perimetro di gioco, sparando con una routine abbastanza
/*               grossolana, ma efficiente, basata sulla bisezione. Dopo aver
/*               incassato un certo numero di colpi, si sposta lateralmente,
/*               in un angolo non occupato da un altro robot, con uno
/*               spostamento veloce. Trascorso un certo numero di cicli (tutti
/*               i paramentri sono liberamente impostabili cambiando i valori
/*               all' inizio del codice) il robot comincia la fase di attacco.
/*               La routine di attacco e' derivata dal robot B52.R (ho molta
/*               stima per questo robot, ha segnato una nuova era nella
/*               crobotica): il nostro amico si sposta in direzione del robot
/*               avversario (sperando ne sia rimasto solo uno) con delle
/*               oscillazioni velocissime, seguendo una traiettoria a zig-zag,
/*               con una routine di fuoco ad hoc, molto piu' lenta ma sicura.
/*
/* THANKS TO   : Alessandro Carlin
/* 
/* DEDICATO A  : Non si fa una dedica senza sapere ancora di aver vinto, anche
/*               se il verificarsi dell'evento e' molto probabile !!!

/* DICHIARAZIONE VARIABILI */

int x,y,lato,dir,flag,db,da,sb,lb,frenata,lh,r,parziale;
int oscillazione,deg,rng,previsto,maxdanni,timer,tmp;

/* PROGRAMMA */

main()
{

/* PARAMETRI IMPOSTABILI */

lato=180;
oscillazione=66;
frenata=35;
maxdanni=34;
timer=360;

/* INIZIALIZZA LE VARIABILI */

db=999-oscillazione;
da=999-lato+oscillazione;
sb=lato-oscillazione;
lh=999-lato-frenata;
lb=lato+frenata;
flag=-1;

/* SI PORTA AL PUNTO DI PARTENZA */

y=loc_y();
if ((x=loc_x())<500)
{ if (y<500) vai(lato,0,135);
else vai(0,999-lato,45); }
else { if (y<500) vai(999,lato,225);
else vai(999-lato,999,315); }
previsto=damage()+maxdanni;

/* OSCILLAZIONI NELL'ANGOLO */

while(timer)
{
drive(dir,100);
if (parziale==45) while (loc_x()<db) fuoco(); else
if (parziale==135) while (loc_x()>da) fuoco(); else
if (parziale==315) while (loc_x()<sb) fuoco(); else
while (loc_x()>oscillazione) fuoco();
drive(dir,0);
while(speed()>89);
--timer;

/* SPOSTAMENTO LATERALE */

if ((damage()>previsto) && !(scan((parziale=((dir+45*flag+360)%360)),10)) && !(scan(parziale+20*flag,10)))
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
while(speed()>49);
}

/* INVERTE OSCILLAZIONE */

(dir+180)%=360;
parziale=((flag*=-1)*dir+360)%360;

}

/* ROUTINE FINALE DI ATTACCO */

dir=dir+90*flag;
while(1)
{
while (speed()<80) drive(dir,100);
fuoco_attacco();
drive(dir,0);
if (flag=!flag) dir=deg-15; else dir=deg+135;
if (((x=loc_x())<150) || (x>850) || ((y=loc_y())<150) || (y>850))
{
while (loc_x()<400) { drive(0,100); fuoco_attacco(); } 
while (loc_x()>600) { drive(180,100); fuoco_attacco(); } 
while (loc_y()<400) { drive(90,100); fuoco_attacco(); } 
while (loc_y()>600) { drive(270,100); fuoco_attacco(); } 
drive(dir,0);
}
while(speed()>49);
}

}

/* SPOSTAMENTO VERSO UN PUNTO FISSATO */

vai(tx,ty,tmp)
{
x=loc_x()-tx;
y=(loc_y()-ty)*100000;
if (tx>loc_x()) dir=360+atan(y/x); else dir=180+atan(y/x);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>8100) { drive(dir,100); fuoco_attacco(); }
drive(dir,49);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>225);
drive((dir=tmp),49);
parziale=(-dir+360)%360;
}

/* ROUTINE DI ATTACCO SICURA */

fuoco_attacco()
{
if (!(rng=scan(deg,10))) while (!(rng=scan(deg+=20,10)));
if (!scan(deg+=5,5)) deg-=10;
if (!scan(deg+=3,3)) deg-=6;
if (r=scan(deg,10)) { cannon(deg,r+r-rng); deg-=40; };
}

/* ROUTINE DI ATTACCO VELOCE */

fuoco()
{
if (!(rng=scan(deg,10)))
if (!(rng=scan(deg-=20,10)))
if (!(rng=scan(deg+=40,10))) { deg+=40; return; }
if (!scan(deg+=5,5)) deg-=10;
if (!scan(deg+=3,3)) deg-=6;
if (r=scan(deg,10)) cannon(deg,r+r-rng);
if (rng>705) deg+=40;
}
