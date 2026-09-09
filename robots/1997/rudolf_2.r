/*                                RUDOLF 2.0                              */

/*  Programmato da   Alessandro Carlin                  */

/* Tattica: Rudolf_2 non presenta profonde differenze rispetto al suo      */
/*          predecessore al quale sono solamente stati eliminati alcuni    */
/*          difetti e modificate alcune routine per renderle pi— efficienti*/
/*          Rudolf_2 raggiunge inizialmente l' angolo pi— vicino           */
/*          (infatti Rudolf Š stato penalizzato dal fatto che l' anno      */
/*          scorso molti robot si posizionavano inizialmente nella stessa  */
/*          posizione predefinita creando molti fastidi).                  */
/*          La routine che controlla il movimento oscillatorio Š stata     */
/*          leggermente modificata. Come l' anno scorso se subisce troppi  */
/*          danni Rudolf_2 raggiunge il primo angolo che vede libero e     */
/*          riprende lo stesso movimento.                                  */
/*          Se Rudolf_2 lo ritiene opportuno puo' cambiare angolo anche    */
/*          altre volte nel corso dell' incontro.                          */
/*          Quando il match volge al termine Rudolf_2 distrugge i robot    */
/*          eventualmente rimasti attaccandoli uno alla volta.             */
/*          Importanti modifiche sono state apportate alla routine finale  */
/*          di attacco che ora risulta essere mediamente pi— efficiente    */
/*          contro robot che compiono piccoli spostamenti veloci.          */

/*Commento: Come Rudolf anche Rudolf_2 preferisce defilarsi finchŠ         */
/*          possibile ed usare una routine di sparo elementare per         */
/*          guadagnare in velocit…. Questa tattica Š risultata infatti     */
/*          vincente come dimostra il torneo dell' anno scorso in cui      */
/*          io sono arrivato secondo, il mio amico ! ha vinto usando una   */
/*          tattica identica alla mia (diciamo copiata spudoratamente      */
/*          anche se il listato Š stato riscritto da zero), mentre         */
/*          infinity e memories erano leggermente differenti ma si         */
/*          muovevano in modo simile, ecc.                                 */
/*          Le novit… sono quasi tutte elencate sopra, le altre scopritele */
/*          confrontando i listati.                                        */

/* INIZIO  LISTATO */

int odam,x,y,trov,deg,r,rng,dir,dam,t,l,ang,d,a1,a2,aw1,aw2,temp,l,t,p,dd,m;

main() {

/* INIZIALIZZAZIONE VARIABILI */

p=0;
deg=270;
t=245;
m=30;
dd=-4;

/* POSIZIONAMENTO INIZIALE IN UN ANGOLO */

if (loc_x()<500) {l=100;
{ if (y<500) {vai(170,170);a1=4;}
else {vai(170,970);a1=3;} }    }
else {l=900;{ if (loc_y()<500) {vai(950,170);a1=1;}
else {vai(970,970);a1=2; }}   }
aw1=(a1*90)%360;
aw2=aw1+90;


/* SI MUOVE VELOCEMENTE IN DIAGONALE NELL' ANGOLO CHE HA SCELTO        */
/* SE SUBISCE TROPPO VALUTA L' ANGOLO CHE CONVIENE RAGGIUNGERE         */
/* E LI RIPRENDE LO STESSO MOVIMENTO                                   */

while(t){
odam=damage();
while((t)&&(damage()<odam+m)) veloce(l);
if ((t<1) && (damage()>80)) {t=300;while(t) veloce(l);}
else
{if (t>1) {
cerca();
m=20;
aw1=(a1*90)%360;
aw2=aw1+90;
while(speed()>1) drive(225,0);
fuggi();   }
}
}

/* DOPO UN PO' DI TEMPO SE NON E' MORIBONDO ATTACCA */
    Centro();
    dir=dir+135;
    while (1)          
    {
        while (speed()<80) drive(dir,100);   
        fuoco_attacco();                          
        drive(dir,0);                       
        if (p) dir=deg-80; else dir=deg+80;  
        p=!p;dd=-dd;                         
        if (! Sicuro()) Centro();   
        while (speed()>49);                
    }
}

/* FINE */


/* PROCEDURE UTILITZZATE */


/* PROCEDURA CHE CONTROLLA IL MOVIMENTO DI OSCILLAZIONE DEL ROBOT DURANTE */
/* LA PRIMA FASE DELL' INCONTRO                                           */

veloce(ubi){
        drive(225,100);
        while (loc_x()>=ubi) {fuoco();drive(225,100);} 
        drive(45,100);                   
        fuoco();                    
        drive(45,100);             
        while (loc_x()<ubi) {fuoco();drive(45,100);} 
        drive(225,100);             
        fuoco();                   
        --t;
    }

/* PROCEDURE DI MIRA E SPARO UTILIZZATE ALL' INIZIO DELL' INCONTRO        */

fuoco()
{
if (!(rng=scan(deg,10)))
if (!(rng=scan(deg-=20,10)))
if (!(rng=scan(deg+=40,10))) { deg+=20; return; } 
if (!scan(deg+=5,5)) deg-=10;
if (!scan(deg+=3,3)) deg-=6;
if (r=scan(deg,10)) cannon(deg,r+r-rng);
if (r>705) deg+=40;
}


/* CONTROLLA SE UN ANGOLO E' LIBERO ALTRIMENTI RAGGIUNGE L' ALTRO         */

cerca(){
if ((!scan(aw1-9,10))&&(!scan(aw1+9,10))) {dir=aw1;a1=(a1+1)%4;}
else {dir=aw2;a1=(a1-1)%4;}  
        }

/* ROUTINE PER IL VELOCE SPOSTAMENTO NELL' ANGOLO INDIVIDUATO             */

fuggi()
{
drive (dir,100);
if (dir==0) while(loc_x()<810) fuoco();else
if (dir==180) while(loc_x()>190) fuoco();else
if (dir==90) while(loc_y()<900) fuoco();else
if (dir==270) while(loc_y()>200) fuoco();
drive(dir,0);
if(loc_x()>500) l=900;
else l=100;

}

/* ROUTINE DI FUOCO USATA NELLA SECONDA FASE DELL' INCONTRO               */

fuoco_attacco()
{
    while ( !(rng=scan(deg+=19,10)) ) ;  
    if (!scan(deg+=5,5)) deg-=10;
    if (r=scan(deg,10)) cannon(deg+dd,r+r-rng);
    if (rng<710) deg-=120; else deg-=20;
}

/* DUE PROCEDURE CHE CONTROLLANO CHE RUDOLF_2 NON SI AVVICINI TROPPO AI LATI*/

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

/* PROCEDURA PER IL VELOCE POSIZIONAMENTO INIZIALE                      */

vai(tx,ty)
{
x=loc_x()-tx;
y=(loc_y()-ty)*100000;
if (tx>loc_x()) dir=360+atan(y/x); else dir=180+atan(y/x);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>8100) { drive(dir,100); fuoco(); }
drive(dir,49);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>225);
drive(225,49);
}
