/*                             K O N G Z I L L A

fusione genetica di KING KONG e GODZILLA.

Programmato da Alessandro Carlin

COME RAGIONA:
Kongzilla e' stupido e non sa che in questo torneo l'F2F non c'e', quindi
attacca senza pensarci 2 volte fin dal primo istante.
La sua fine prematura e' ovvia.

COMMENTO:
E' praticamente la routine di attacco di Rudolf_5.
A dire il vero Kongzilla era nato per il 4vs4, ma quando ho visto che
Rudolf_5 era molto meglio, ho deciso che era inutile mandare un altro
robot a sfigurare nel 4vs4.
Uno basta e avanza.

Ciao
   Ale.
*/

int qs,ra1,dist,ra,qwer,max,xxx,con,yyy,p,dd,fine,reg,tt,centre,b,rng,orng,
    deg,odeg,dir,t,q,dam,odeg,ddeg,anco,corr,alfa,rg,org,nrg,drg,verso;

main(){
deg=0;
end();
}

dx(l) { while(loc_x()<l) { drive(dir=  0,100);   Kill(0); }   drive(180,0); 
}
sx(l) { while(loc_x()>l) { drive(dir=180,100);   Kill(0); }   drive(0,0);  }

end(){
dx(450);
sx(550);
while(1){
        verso = 90;
        while (loc_y() < 800) colpire();
	verso = 270;
        while (loc_y() > 200) colpire();
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
   cannon ( ddeg, drg ) ;
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
dir = verso+55;
drive (dir,100);
fuoco();
dir = verso-55;
drive (dir,100);
}

ur(){
       if (!(orng=scan(deg,10)))
       if (!(orng=scan(deg-=20,10)))
       if (!(orng=scan(deg+=40,10))) {deg+=40; return;}
       if (scan(deg,10)) {
        
cannon(deg+=7*(!(scan(deg+356,7)))+353*(!(scan(deg+4,7))),2*scan(deg,10)-orng);
       if (orng>800)  {deg+=40; }}
       }

Kill(hh)
{
    if ((orng=scan(deg,10)))
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
            }
            else ur();
        }
        else ur();
     }
     else
     {
        if ((orng=scan(deg-=20,10))) return;
        if ((orng=scan(deg+=40,10))) return;
        deg+=40; return;
     }
}



