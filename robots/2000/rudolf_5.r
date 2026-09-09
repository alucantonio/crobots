/*                         R  U  D  O  L  F     5


Programmato da Alessandro Carlin

COME RAGIONA:
Il robot all'inizio va verso il lato piu' vicino (est o ovest), dopodiche'
si porta a nord o sud scegliendo possibilmente quello libero tra i due.
Una volta sull'angolo se il numero di cicli e' minore di 40000 circa compie
delle piccole oscillazioni verticali sparando in modo clamorosamente
impreciso. Se un nemico si avvicina troppo o si accorge di subire alquanto,
Rudolf (pavido) scappa con la stessa routine che usava Cyborg.
Nella seconda parte di gara raccoglie tutto il coraggio che ha e, se i danni
non superano l'85% e nel verso dell'oscillazione orizzontale vede un robot,
lo attacca (vedi Rudy) spostandosi fino ad 1/3 dell'arena. Altrimenti
senza altri controlli fa una bella oscillazione verticale della stessa
ampiezza sperando in cuor suo di non incappare in un robot in movimento.
Anche in questa fase se un nemico condivide l'angolo o se subisce troppo
Rudolf fluidifica verso lande piu' sicure (si spera).
La procedura di attacco viene attivata se resta f2f. E' una routine 
piuttosto
datata un po' sistemata l'ultimo giorno utile (31/10).

COMMENTO:
Il modo in cui e' stato scritto Rudolf_5 penso faccia raccapricciare
chiunque partecipi a questo torneo: in pratica non c'e' una mazza di nuovo,
(quindi evitate di perdere tempo a leggere il listato) sono solo
state implementate assieme molte idee sfruttando le 2000
istruzioni, cercando di farle convivere. Il risultato fa abbastanza schifo, 
ma
non so che farci, visto che il tempo effettivo netto di programmazione e 
test
non ha superato le 30 ore (per la vita??).
Comunque sono molto contento del fatto che i progressi favoriti dalle 2000
istruzioni sono stati incredibili, visti i test di alcuni di voi, a
conferma della longevita' straordinaria di questo giochetto.
Un saluto a tutti i membri della ML e un ringraziamenti a Joshua, Simone e
Mick per l'organizzazione e i programmini di test.
Ciao
   Ale.

*/

int qs,ra1,dist,ra,qwer,max,xxx,con,yyy,p,dd,fine,reg,tt,centre,b,rng,orng,
    deg,odeg,dir,t,q,dam,odeg,ddeg,anco,corr,alfa,rg,org,nrg,drg,verso;

main()
{
    deg=0;
    dd=165;
    if (loc_x()<500) {sx(90);
    if (Z(270)) dw(100); else up(900);}
    else {dx(910);
    if (Z(250)) dw(100); else up(900);}
    qwer=1;
    con=0;
    Pos(max=6);
    while(1)
    {
    dam=damage();
    while ((!orng || orng>450) && (damage()<dam+max))
    {
        if (t>12) if (orng>780||t>20)
           if (Radar()) end();
        dam=damage(++con);
        if (qwer) Oscillation();
        else {drive(dir,0);while(speed()); muovi();}
        if (con>60) {if (dam<85) {qwer=0;max=15;}
                      else {qwer=1;max=6;}}
    }
    cambia();
    }
}

cambia(){
      if (b==0)     {if (Z(75)) up(900); else sx(80);}
      else if (b==1) {if (Z(85)) up(900); else dx(920);}
      else if (b==2) {if (Z(265)) dw(100); else sx(80);}
      else           {if (Z(255)) dw(100); else dx(920);}
    Pos();
         }

Q(du){
if (!(dist=scan(du-10,10))) if (!(dist=scan(du+10,10))) return(0);
return(dist);
}

muovi(){
if (b==0) {if ((ra=Q(5))&&(ra==Q(5))) dessen(300,140); else sugiu(280,140);}
else if (b==1) {if ((ra=Q(175))&&(ra==Q(175))) sendes(700,860); else 
sugiu(280,140);}
else if (b==2) {if ((ra=Q(355))&&(ra==Q(355))) dessen(300,140); else 
giusu(720,860);}
else {if ((ra=Q(185))&&(ra==Q(185))) sendes(700,860); else giusu(720,860);}
}

Pos(){
    b= (loc_x()>500)+2*(loc_y()>500);
}

up(l) { while(loc_y()<l) { drive(dir= 90,100);  Kill(0); }   drive(270,0); }
dw(l) { while(loc_y()>l) { drive(dir=270,100); Kill(0); }   drive(90,0); }
dx(l) { while(loc_x()<l) { drive(dir=  0,100);   Kill(0); }   drive(180,0); 
}
sx(l) { while(loc_x()>l) { drive(dir=180,100); Kill(0); }   drive(0,0);  }

sugiu(xc,yc){up(xc);ug(45);dw(yc);}
giusu(xc,yc){dw(xc);ug(45);up(yc);}
dessen(xc,yc){dx(xc);ug(45);sx(yc);}
sendes(xc,yc){sx(xc);ug(45);dx(yc);}

ug(rr){drive(dir+=180,0);while(speed()>rr);/*if (rr==45) 
{drive(dir,100);deg=dir+177+rand(6);Kill(1);}*/}

Z(www){
return (!scan(www,10)&&!scan(www+20,10));
}

Oscillation(){
             if (loc_y()<500){
             while (loc_y()<65) {drive(90,100); Kill(1);}
             while (loc_y()>=65) {drive(dir=270,70); Kill(1);}}
             else {
             while (loc_y()>935) {drive(270,100); Kill(1);}
             while (loc_y()<=935) {drive(dir=90,70); Kill(1);}}
             drive(dir,0);
             }

Radar()
{
    reg=10; t=0;
    while((reg+=20)!=730) if (scan(reg,10)) if(++t>2) {t=0; return 0;}
    return 1;
}

end(){
dx(450);
sx(550);
while(1){
        verso = 90;
        while (loc_y() < 750) colpire();
	verso = 270;
	while (loc_y() > 250) colpire();
	}
}

find()
{

if ( nrg = scan(deg,10) )
{ if ( scan(deg+6,5) )
   {  if ( scan(deg+2,2) )
      {  if ( scan(deg+4,1) )
         {  if ( scan(deg+3,0) )
             deg+=3;
	    else
             deg+=4;
	 }
	 else
            if ( scan(deg+2,0) )
             deg+=2;
	    else
             deg+=1;
      }
      else
      {  if ( scan(deg+8,1) )
         {  if ( scan(deg+7,0) )
             deg+=7;
	    else
             deg+=9;
	 }
      else
         if ( scan(deg+6,0) )
            deg+=6;
	 else
            deg+=5;
      }
   }
   else
   {  if ( scan (deg-1,2) )
      {  if ( scan(deg-3,1) )
         {  if ( scan(deg-2,0) )
             deg-=2;
	    else
             deg-=3;
	 }
	 else
           if ( scan(deg-1,0) )
            deg-=1;
	   else
            deg-=0;
      }
      else
      {  if ( scan(deg-4,1) )
         {  if ( scan(deg-5,0) )
             deg-=5;
	    else
             deg-=4;
	 }
	 else
           if ( scan(deg-6,1) )
            deg-=6;
	   else
            deg-=8;
      }
   }
return 1;
}
else
{ if ( nrg = scan(deg+15,5) )
   {  if ( scan(deg+12,2) )
      {  if ( scan(deg+14,1) )
         {  if ( scan(deg+13,0) )
             deg+=13;
	    else
             deg+=14;
	 }
	 else
            if ( scan(deg+12,0) )
             deg+=12;
	    else
             deg+=11;
      }
      else
      {  if ( scan(deg+18,1) )
         {  if ( scan(deg+17,0) )
             deg+=17;
	    else
             deg+=19;
	 }
      else
         if ( scan(deg+16,0) )
            deg+=16;
	 else
            deg+=15;
      }
   }
   else
   {  if ( nrg = scan (deg-13,2) )
      {  if ( scan(deg-11,1) )
         {  if ( scan(deg-11,0) )
             deg-=11;
	    else
             deg-=12;
	 }
	 else
           if ( scan(deg-13,0) )
            deg-=13;
	   else
            deg-=14;
      }
      else
      {  if ( nrg = scan(deg-17,1) )
         {  if ( scan(deg-16,0) )
             deg-=16;
	    else
             deg-=17;
	 }
	 else
           if ( scan(deg-18,1) )
            deg-=18;
	   else
	    return 0;
      }
   }
return 1;
}
}



fuoco()
{
if ( find() )
   {
   spara();
   }
else
   {
   deg += 29;
   drive (dir,40);
   while ( ! scan(deg,10) ) deg += 19;
   while (speed() > 40) ;
   }
}

spara()
{
drive (dir,100);
odeg=deg;
if ( find() )
{
drive (dir,40);

alfa = (deg-dir) - ((deg-dir)/360)*360;

corr = cos(alfa);
anco = - sin(alfa);

ddeg = deg + (deg-odeg)*3 + anco/17000;

if (rg=scan(deg,10))
   {
   drg =  rg*350/(350+nrg-rg-corr/3000);
   while ( ! cannon ( ddeg, drg ) ) ;
   }
else
   {
   drg = nrg;
   cannon ( ddeg, drg);
   }
}
else
{
drive (dir,40);
deg += 29;
while ( ! scan (deg,10) ) deg += 19;
while (speed() > 40);
}

}

colpire()
{
fuoco();
dir = verso+50;
drive (dir,100);
fuoco();
dir = verso-50;
drive (dir,100);
}


ur(){
       if (!(orng=scan(deg,10)))
       if (!(orng=scan(deg-=20,10)))
       if (!(orng=scan(deg+=40,10))) {deg+=40; return;}
       if (scan(deg,10)) {
        
cannon(deg+=7*(!(scan(deg+356,7)))+353*(!(scan(deg+4,7))),2*scan(deg,10)-orng);
       if (orng>800)  {++t;deg+=40; }}
       }

Kill(hh)
{      if (hh) ur();
    else{
    if ((orng=scan(deg,10))&&(orng<950))
    {
        if (!scan(deg-=5,5)) deg+=10;
        if(scan(deg-5,1)) deg-=5;
        if(scan(deg+5,1)) deg+=5;
        if(scan(deg-3,1)) deg-=3;
        if(scan(deg+3,1)) deg+=3;
        if(scan(deg-1,1)) deg-=1;
        if(scan(deg+1,1)) deg+=1;

        if (orng=scan(odeg=deg,5))
        {
        if(scan(deg-5,1)) deg-=5;
        if(scan(deg+5,1)) deg+=5;
        if(scan(deg-3,1)) deg-=3;
        if(scan(deg+3,1)) deg+=3;
        if(scan(deg-1,1)) deg-=1;
        if(scan(deg+1,1)) deg+=1;
            if (rng=scan(deg,10))
            {
                cannon(deg+(deg-odeg)*((1200+rng)>>9)-((sin(deg-dir)>>14)),
                       rng*dd/(dd+orng-rng-((cos(deg-dir)>>12))));
                ++t;
            }
            else ur();
        }
        else ur();
     }
     else
     {
        if ((orng=scan(deg-=20,10))&&(orng<950)) return;
        if ((orng=scan(deg+=40,10))&&(orng<950)) return;
        deg+=40; return;
}     }
}



