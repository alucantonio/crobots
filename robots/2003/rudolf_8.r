
/*                     R  U  D  O  L  F        8





Programmato da:  Alessandro Carlin


Certo non poteva mancare il seguito della stirpe Rudolf... peccato che sia
solo un' involuzione di Zorn, molto piu' difensivista e svogliato...
Sara' per la prossima...

                                            */





int asb,asa,ss,dimitri,tt,dp,d,or,ul,ll,b,tempo,oscar,xora,flag,flag1,daa,rng,t,oldr,deg,odeg,dist;

main(){
if ((asb=(loc_y(tt=0)>500))) up(920); else dn(80);
if ((asa=(loc_x(t=11)>500))) dx(920); else sx(80);
b=asb*2+(asb!=asa);
ll=90*b-35;
ul=ll+142;
               flag=ll;
               flag1=2;
               while (flag<ul&&flag1) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1));
or=1;
while(t<10000){
daa=damage(++t);

     if (loc_x()>500){
     while(speed()>49);
     drive(d=180,100);       
     xora=loc_x()-45;
     
     sx(xora);
     if(b==1) {up(loc_y()+45);}
     else {dn(loc_y()-45);}
     d=90+180*(loc_y()>500);
     dp=d;dp=d;dp=d;
     dx(920);
     if(b==1) {d=90;d=90;d=90;d=90;dn(80);}
     else {d=270;d=270;d=270;d=270;up(920);}
     }
     else {
     while(speed()>49);
     drive(d=360,100);        
     xora=loc_x()+45;
         
     dx(xora);
     if(b==0) {up(loc_y()+45);}
     else {dn(loc_y()-45);}
     d=90+60*b;
     dp=d;dp=d;dp=d;
     sx(80);
     if(b==0) {d=90;d=90;d=90;d=90;dn(80);}
     else {d=270;d=270;d=270;d=270;up(920);}
     }
         if ((t>3&&!(oldr<800)||t>6))
              {
               flag=ll;
               flag1=2;
               while (flag<ul&&flag1) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1));
              }
}
fine();
}

up(limt) {while(loc_y()<limt) {drive(90,100);Fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);Fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(360,100);Fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);Fire();}drive(180,0);}

Fire() {
 if((oldr=scan(deg,10))&&(oldr<835))
        {
           if (oldr=scan(deg,4)){if (!(scan(deg+=2,2))) deg-=4;}
           else if (oldr=scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4;}
           else if (oldr=scan(deg+=14,4)){if (!(scan(deg+=2,2))) deg-=4;}
           else return;
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
           
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg+=14,4)){if (!(scan(deg-=2,2))) deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
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


udo(){
while(loc_x()>500) {while(loc_y()>885) {drive(240,100);Fuoco();}
                    while(loc_y()<885) {drive(120,100);Fuoco();}
                    }
}

uso(){
while(loc_x()<500) {while(loc_y()>885) {drive(300,100);Fuoco();}
                    while(loc_y()<885) {drive(60,100);Fuoco();}
                    }
}

ddo(){
while(loc_x()>500) {while(loc_y()>115) {drive(240,100);Fuoco();}
                    while(loc_y()<115) {drive(120,100);Fuoco();}
                    }
}

dso(){
while(loc_x()<500) {while(loc_y()>115) {drive(300,100);Fuoco();}
                    while(loc_y()<115) {drive(60,100);Fuoco();}
                    }
}


fine()
{
if (b==0) dso();
else if (b==1) ddo();
else if (b==2) udo();
else uso();
daa=damage();
if(b>1){
while(loc_y()>150) {drive(270,100);Fuocoe();
                     }
}
else{
while(loc_y()<850) {drive(90,100);Fuocoe();
                     }
}
daa-=5;
while (damage()<(daa+16)) {
daa=damage();
while(loc_y()>150) {drive(270,100);Fuocoe();
                     }
while(loc_y()<850) {drive(90,100);Fuocoe();
                    }                      
}
while(1)
{
while(loc_y()>150) {while(loc_x()>500) {drive(190,100);Fuoco();}
                    while(loc_x()<500) {drive(350,100);Fuoco();}
                    }
while(loc_y()<850) {
                    while(loc_x()>500) {drive(170,100);Fuoco();}
                    while(loc_x()<500) {drive(10,100);Fuoco();}
                    }
}
  
}

Fuocoe()
{
    if (oldr=scan(odeg=deg,10)) {
           
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg+=14,4)){if (!(scan(deg-=2,2))) deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
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
