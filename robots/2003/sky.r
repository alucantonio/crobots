
/*                               S    K    Y





Programmato da:  Alessandro Carlin

Niente da dire su questo robottino... non sapendo cosa spedire per la
categoria midi ho optato per riproporre Enigma dell'anno scorso. Un po' come per
Cyborg vediamo cosa combina, tuttavia mentre Cyborg lo ho rimodernato
questo e' rimasto proprio lo stesso.
SOB!
:.(

P.S. Il nome non fa riferimento ad alcun marchio televisivo... 

*/

int pezzo,asb,asa,ss,dimitri,dp,d,or,ul,ll,b,tempo,oscar,xora,flag,flag1,daa,rng,t,oldr,deg,odeg,dist;

main(){
if (asa=(loc_y(t=11)>500)) up(920); else dn(80);
if (asb=(loc_x()>500)) dx(920); else sx(80);
b=2*asa+(asa!=asb);      /* per questa devo ringraziare Simone Ascheri */
ll=90*b-35;

sganna(ul=ll+130);
while(t<10000){
daa=damage(++t);
pezzo=(ss*(dist-850+oscar));

     while(speed()>49);
     drive(d=360+180*asb,100);
       if (ss){if (or) look(350-180*asb);
       else look(80+180*asa);
     }


     if (asb) sx(xora=loc_x()-45-or*pezzo); else dx(xora=loc_x()+45+or*pezzo);
              zozzo=45+!or*pezzo;
     if(!asa) {d=90;up(loc_y()+zozzo);}
     else {d=270;dn(loc_y()-zozzo);}
     tempo();
     if (asb) dx(920); else sx(80);
     tempo();
     if(!asa) {dn(80);}
     else {up(920);}

     if (ss) if((damage())>daa) or=!or;
     
         if ((t>3&&!(oldr<800)||t>6))
              {
               if (++tempo>20) {oscar=60;or=!or;}
               if (tempo>5) ss=1;
               if (damage()>85) {ss=0;}
              sganna();
              }
}
fine();
}

up(limt) {while(loc_y()<limt) {drive(90,100);Fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);Fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(360,100);Fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);Fire();}drive(180,0);}

Fire() {
 if((oldr=scan(deg,10))&&(oldr<830))
        {
           if (oldr=scan(deg,4));
           else if (oldr=scan(deg-=7,3));
           else if (oldr=scan(deg+=14,3));
           else return;
           if (!scan(deg+=2,2)) deg-=4;
           cannon (deg,oldr);
        }
     else
       if(scan(deg+=20,10));
       else
         if(scan(deg-=40,10));
         else
           if(scan(d,10)) deg=d;
           else
             return (deg+=80);
}


Fuoco()
{
    if (oldr=scan(odeg=deg,10)) {
           if (scan(deg-=7,4));
           else if (scan(deg+=14,4));
           else if (scan(deg-=7,4));
    if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));
    }
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=300,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=80,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=260,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=120,10)) return cannon(deg,oldr);
        deg+=80;
    }
}

fine()                                
{
if (!b||b==3) while(loc_x()<500) zzy(115+257*b,300,60);
else while(loc_x()>500) zzy(115+(b-1)*770,240,120);
while(1)
{
while(loc_y()>150) zz(190,350);
 while(loc_y()<850) zz(170,10);
} 
}


zz(d1,d2){
                    while(loc_x()>500) {drive(d1,100);Fuoco();}
                    while(loc_x()<500) {drive(d2,100);Fuoco();}
}

zzy(lom,d1,d2){
                    while(loc_y()>lom) {drive(d1,100);Fuoco();}
                    while(loc_y()<lom) {drive(d2,100);Fuoco();}
}


look(par)
{if (!(dist=scan(par,10))) if (!(dist=scan(par+20,10))) dist=850;}

sganna(){
               flag=ll;
               flag1=2;
               while (flag<=ul&&flag1) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1>0));
        }

tempo(){
dn=d;dn=d;dn=d;
}
