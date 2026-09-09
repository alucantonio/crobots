/*                          R  U  D  O  L  F   III
                                the revenge

        AUTORE
        Nome: Carlin Bruno

SCHEDA TECNICA:
Inizialmente il crobot raggiunge l' angolo piu' vicino, dove inizia ad
oscillare inclinato di 25 gradi rispetto all' orizzontale. Se pensa
di subire troppo raggiunge un angolo adiacente, sempreche' sia libero (se
li trova entrambi occupati non si sposta) e li riprende lo stesso movimento.
Quando vede un solo nemico nell' arena lo attacca con una strategia identica a
quella usata dai crobot VISION.R e ________.R (The Invisible Man) iscritti
a questo stesso torneo da Alessandro (Carlin). Se si eccettua quest' ultima
parte il Rudolf_3 e' sostanzialmente molto simile ai suoi predecessori
Rudolf e Rudolf_2. In particolare e' stata migliorata la procedura di fuoco
che effettua una scansione di una zona piu' ampia attorno alla posizione in
cui era stato trovato in precedenza un nemico.                              */

int odam,x,y,trov,deg,r,rng,dir,dam,t,l,ang,d,a1,a2,aw1,aw2,temp,l,t,p,dd,m;

/* principale */

main() {
t=50;
m=30;
risp=0;
if (loc_x()<500) {l=100;
{ if (loc_y()<500) {vai(170,110);a1=4;}
else {vai(170,999);a1=3;} }    }
else {l=900;{ if (loc_y()<500) {vai(950,100);a1=1;}
else {vai(970,999);a1=2; }}   }
aw1=(a1*90)%360;
aw2=aw1+90;
deg=aw1;
while(1){
while(t){
odam=damage();
while((t)&&(damage()<odam+m)) veloce(l);
rad=radar();
if ((rad<2)) end();
if ((t<1) && (damage()>80)) {while(1) veloce(l);}
else
{if (t>1) {
cerca();
if (risp=1) {
fuggi();
risp=0;
m=20;
aw1=(a1*90)%360;
aw2=aw1+90;
 } }
}
}
t=20;
}
}

/* attacco finale */

end()
{
 vai(loc_x()+(500-loc_x())/15,500);
 while(1)
  {
   drive(0,100);  while (loc_x() < 900) if (pp=scan(deg,10)) 
      cannon(deg+=7*(!(scan(deg+356,7)))+353*(!(scan(deg+4,7))),2*scan(deg,10)-pp);
                                        else deg+=21;
   drive(0,0);     destroy();      
   drive(180,100); while (loc_x() > 100) if (pp=scan(deg,10)) 
      cannon(deg+=7*(!(scan(deg+356,7)))+353*(!(scan(deg+4,7))),2*scan(deg,10)-pp);
                                         else deg+=21;
   drive(180,0);   destroy();
  }

}

/* movimento oscillatorio */

veloce(ubi){
        drive(205,100);
        while (loc_x()>=ubi) {fuoco();drive(205,100);}
        drive(25,100);                   
        fuoco();                    
        drive(25,100);
        while (loc_x()<ubi) {fuoco();drive(25,100);} 
        drive(205,100);             
        fuoco();                   
        --t;
    }

/* sparo durante l' oscillazione */

fuoco()
{
if (!(rng=scan(deg,10)))
if (!(rng=scan(deg-=20,10)))
if (!(rng=scan(deg+=40,10)))
if (!(rng=scan(deg-=60,10)))
if (!(rng=scan(deg+=80,10))) { deg+=60; return; }
if (!scan(deg+=5,5)) deg-=10;
if (!scan(deg+=3,3)) deg-=6;
if (r=scan(deg,5)) cannon(deg,r+r-rng);
if (r>705) deg+=90;
}

/* cerco un angolo libero */

cerca(){
if (!r=scan(aw1,10)) {dir=aw1;a1=(a1+1)%4;risp=1;} else 
if (!rn=scan(aw2,10)) {dir=aw2;a1=(a1-1)%4;risp=1;} 
        }

/* e lo raggiungo */

fuggi()
{
drive (dir,100);
if (dir==0) while(loc_x()<810) fuoco();else
if (dir==180) while(loc_x()>190) fuoco();else
if (dir==90) while(loc_y()<950) fuoco();else
if (dir==270) while(loc_y()>130) fuoco();
drive(dir,0);
if(loc_x()>500) l=900;
else l=100;

}

vai(tx,ty)
{
x=loc_x()-tx;
y=(loc_y()-ty)*100000;
if (tx>loc_x()) dir=360+atan(y/x); else dir=180+atan(y/x);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>8100) { drive(dir,100); fuoco(); }
drive(dir,49);
while((x=tx-loc_x())*x+(y=ty-loc_y())*y>225);
drive(0,0);
while (speed()>49);
}

/* controllo dei nemici rimasti */

radar()          
{
    int n,       
        da;       
    n=0; da=1;
    while (da!=361) 
    { 
        if (scan(da,10)) ++n;  
        da+=18;
    }
    return n;
}

/* sparo veloce */

destroy()
{     
 while (speed() > 49) if ((d=scan(deg,10))) {
                      if (!scan(deg+=5,5)) deg-=10;
                      cannon(deg,d);
                      }
                      else deg+=20;
}

/*  ... perche' un Rudolf sia sempre in famiglia ... */

