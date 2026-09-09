
/*                                RUDOLF 1.0                              */

/*  Programmato da   Alessandro Carlin                  */

/* Tattica: Rudolf raggiunge inizialmente l' angolo nord-est dell' arena   */
/*          e qui oscilla lungo una direzione a 40ø rispetto all' orizzon- */
/*          tale. Se subisce troppi danni raggiunge il primo angolo che    */
/*          vede libero da nemici dove riprende lo stesso movimento.       */
/*          Se Rudolf lo ritiene opportuno puo' cambiare angolo anche      */
/*          altre volte nel corso dell' incontro.                          */
/*          Quando il match volge al termine Rudolf distrugge i robot      */
/*          eventualmente rimasti attaccandoli uno alla volta.             */

/* Commento: Osservando i listati delle precedenti edizioni (e' il primo   */
/*           anno che partecipo al torneo) ho notato la presenza di        */
/*           robot dotati di sparo efficiente e movimenti limitati         */
/*           e di altri che invece preferivano evitare di essere colpiti   */
/*           senza curarsi piu' di tanto di dove andavano a finire i loro  */
/*           proiettili. Rudolf appartiene alla seconda categoria.         */
/*           Ritengo infatti che, essendo 4 i robot che prendono parte ad  */
/*           ogni match, sia meglio lasciare che gli altri si distruggano  */
/*           e defilarsi il piu' possibile. Rudolf cambia posizione nel    */
/*           corso dell' incontro per evitare di essere penalizzato        */
/*           eccessivamente dai robot che si piazzano in una zona del-     */
/*           l' arena e non la lasciano durante l' incontro (come Boss,    */
/*           Biro, Ninus99 e altri). Alcuni spunti sono stati presi dal    */
/*           grande B52 e in particolare la routine finale di attacco che  */
/*           considero ottima.                                             */

/* INIZIO  LISTATO */

int odam,x,y,trov,deg,r,rng,dir,dam,t,l,ang,d,a1,a2,aw1,aw2,temp,l,t,p,dd,m;

main() {

/* INIZIALIZZAZIONE VARIABILI */

p=0;
deg=270;
a1=2;
t=245;
l=920;
m=30;
aw1=(a1*90)%360;
aw2=aw1+90;
dd=-4;

/* POSIZIONAMENTO INIZIALE IN ALTO A DESTRA */

    while (loc_x()>850) { drive(180,100); fuoco(); }
    drive(0,0);
    while (loc_x()<810) { drive(0,100); fuoco(); }
    while (speed()>49) drive(0,0);
    while (loc_y()>870) { drive(270,100); fuoco(); }
    while (speed()>49) drive(0,0);
    while (loc_y()<850) { drive(90,100); fuoco(); }
    while (speed()>49) drive(270,0);

/* SI MUOVE VELOCEMENTE IN DIAGONALE NELL' ANGOLO NORD-EST DELL' ARENA */
/* SE SUBISCE TROPPO VALUTA L' ANGOLO CHE CONVIENE RAGGIUNGERE         */
/* E LI RIPRENDE LO STESSO MOVIMENTO                                   */

while((t)||(damage()>88)){
odam=damage();
trov=1;
while((t)&&(damage()<odam+m)) veloce(l);
while((trov)&&(t)){
veloce(l);
cerca();
}
m=20;
aw1=(a1*90)%360;
aw2=aw1+90;
while(speed()>1) drive(240,0);
fuggi();
}

/* DOPO UN PO' DI TEMPO SE NON E' MORIBONDO ATTACCA */

    dir=270;
    while (1)          
    {
        while (speed()<80) {drive(dir,100);}   
        fuoco_attacco();                          
        drive(dir,0);                       
        if (p) dir=deg-15; else dir=deg+135;  
        p=!p; dd=-dd;                        
        if (! Sicuro()) Centro();   
        while (speed()>49);                
    }
}

/* FINE */


/* PROCEDURE UTILITZZATE */


/* PROCEDURA CHE CONTROLLA IL MOVIMENTO DI OSCILLAZIONE DEL ROBOT DURANTE */
/* LA PRIMA FASE DELL' INCONTRO                                           */

veloce(ubi){
        drive(220,100);
        while (loc_y()>=ubi-1) {fuoco();drive(220,100);} 
        drive(40,100);                   
        fuoco();                    
        while (speed()>85) ;          
        drive(40,100);             
        while (loc_y()<=ubi+1) {fuoco();drive(40,100);} 
        drive(220,100);             
        fuoco();                   
        while (speed()>85) ;              
        --t;
    }

/* PROCEDURE DI MIRA E SPARO UTILIZZATE ALL' INIZIO DELL' INCONTRO        */

fuoco()
{
    if (rng=scan(deg,10)) spara();           
    else if (rng=scan(deg-=20,10)) spara();  
    else if (rng=scan(deg+=40,10)) spara();  
    else deg+=40;
}

spara()
{
if (!scan(deg+=5,5)) deg-=10;
if (!scan(deg+=3,3)) deg-=6;
if (r=scan(deg,10)) cannon(deg,r+r-rng);
if (r>705) deg+=40; 
}

/* CONTROLLA L' ANGOLO CHE SI LIBERA PRIMA IN CASO DI DANNI               */

cerca(){
if ((!scan(aw1-9,10))&&(!scan(aw1+9,10))) {dir=aw1;a1=(a1+1)%4;trov=0;}
else {dir=aw2;a1=(a1-1)%4;trov=0;}  
        }

/* ROUTINE PER IL VELOCE SPOSTAMENTO NELL' ANGOLO INDIVIDUATO             */

fuggi()
{
drive (dir,100);
if (dir==0) while(loc_x()<810) fuoco();else
if (dir==180) while(loc_x()>200) fuoco();else
if (dir==90) while(loc_y()<810) fuoco();else
if (dir==270) while(loc_y()>200) fuoco();
drive(dir,0);
if(loc_y()>500) l=920;
else l=80;

}

/* ROUTINE DI FUOCO USATA NELLA SECONDA FASE DELL' INCONTRO               */

fuoco_attacco()
{
    while ( !(rng=scan(deg+=19,10)) ) ;  
    if (!scan(deg+=5,5)) deg-=10;
    if (!scan(deg+=3,3)) deg-=6;
    if (r=scan(deg,10)) cannon(deg+dd,r+r-rng);
    if (rng<700) deg-=60; else deg+=20;
}

/* DUE PROCEDURE CHE CONTROLLANO CHE RUDOLF NON SI AVVICINI TROPPO AI LATI */
/* VEDI B52                                                                */

Sicuro()       
{
    x=loc_x();
    y=loc_y();
    if ((x<150) || (x>850) || (y<150) || (y>850)) return 0;
    return 1;
}

Centro()
{
    while (loc_x()<400) { drive(0,100); fuoco_attacco(); } 
    while (loc_x()>600) { drive(180,100); fuoco_attacco(); } 
    while (speed()>49) drive(dir,0);
    while (loc_y()<400) { drive(90,100); fuoco_attacco(); } 
    while (loc_y()>600) { drive(270,100); fuoco_attacco(); } 
    while (speed()>49) drive(dir,0);
}

