/*

     ========   VIII  Torneo Crobots MCmicrocomputer 1998   =========


ROBOT : COPPI.R


 Luigi Cimini


SCHEDA TECNICA:

  Questo robot si posiziona nell`angolo piu` vicino e vi resta fino a quando
  non subisce un danno superiore al 8%, se il danno supera questo limite si
  trasferisce in uno degli angoli adiacenti se libero.
  Per quanto attiene la  strategia generale il robot controlla ogni 133 cicli
  il numero degli avversari e se ne resta uno solo e non a subito danni supe-
  riori al 90 per cento lo attacca, quando i cicli CPU si avvicinano alle
  400000 attacca comunque a prescindere dal numero deli avversari e dai danni
  subiti.
  Per quanto riguarda le routine di fuoco queste vengono selezionate in base
  alla distanza del bersaglio e usando come selettore la funzione speed().
  Le routine di fuoco sono delle basiche gia` note modificate per aumentarne
  l`efficienza (almeno spero).


SCELTA:

  Nel caso si rendesse necessario limitare i combattimenti ad un solo
  robot preferisco veder combattere questo crobot ( COPPI.R ).

*/


int a,aa,b,d,danno,n,r,rr,o,oa,t,tt;

main()
{
   tt=2527;
   if (loc_y()<500) dn(); else up();
   if (loc_x()<500) sx(); else dx();
   danno=damage();
 while(1)
   {
    t=133;    
    while(--t)
      {
       if (damage()<(danno+9))
         {if (scan(a,10)<313) fire(); else fuoco();}
       else
         {
          danno=damage();
          if (!speed())
            {
 b=sito();
      if (b==0) {if (!(scan(  8,10))) dx(); else if (!(scan( 82,10))) up();}
 else if (b==1) {if (!(scan( 98,10))) up(); else if (!(scan(172,10))) sx();}
 else if (b==2) {if (!(scan(278,10))) dn(); else if (!(scan(352,10))) dx();}
 else           {if (!(scan(188,10))) sx(); else if (!(scan(262,10))) dn();}
            }
         }
      }
    drive(n=0,0); b=-11; while(b<350) if(scan(b+=20,10)) n+=1;
    if ( ((n<2) && (damage()<90)) || ((tt-=133)<0) )
      {
       b=sito(); if ((b==1) || (b==2)) d=315; else d=45;
       while(1)
         {          
                  while (loc_x()<866) { drive (d,100); fuoco(); }
          d+=180; while (loc_x()>133) { drive (d,100); fuoco(); }
          d+=180;
         }
      }
   } 
}

sito()
{
  fuoco(); return (loc_x()>500)+2*(loc_y()>500);
}

up()
{ while(loc_y()<933) {drive( 90,100); fire();} drive(270,0);}
dn()
{ while(loc_y()> 66) {drive(270,100); fire();} drive(90, 0);}
sx()
{ while(loc_x()> 66) {drive(180,100); fire();} drive(0,  0);}
dx()
{ while(loc_x()<933) {drive(  0,100); fire();} drive(180,0);}

scan14()
{
  if(scan(a+354,1)) a+=354;
  if(scan(a+6,  1)) a+=6;
  if(scan(a+356,1)) a+=356;
  if(scan(a+4,  1)) a+=4;
  if(scan(a+358,1)) a+=358;
  if(scan(a+2,  1)) a+=2;
}

scan_low()
{
        if (o=scan(a+340,10)) cannon(a+=340,(scan(a,10)<<1)-o);
   else if (o=scan(a+20, 10)) cannon(a+=20 ,(scan(a,10)<<1)-o);
   else if (o=scan(a+320,10)) cannon(a+=320,(scan(a,10)<<1)-o);
   else if (o=scan(a+40, 10)) cannon(a+=40 ,(scan(a,10)<<1)-o);
   else if (o=scan(a+300,10)) cannon(a+=300,o);
   else if (o=scan(a+60, 10)) cannon(a+=60 ,o);
   else a+=140;
}

fuoco()
{
  if (!scan(a,7))
  if (!scan(a+=345,7))
  if (!scan(a+=30,7)) {scan_low(); return;}
  scan14();
  if ((o=scan(a,7)) && (o<755))
     {
      oa=a;
      scan14();
      if (r=scan(a,10))
         {
          if (speed())
            {
             aa=(a+(a-oa)*((1200+r)>>9)-(sin(a-d)>>14));
             rr=(r*160/(160+o-r-(cos(a-d)>>12)));
            }
          else
            {
             aa=(a+(a-oa)*((1200+r)>>9));
             rr=(r*165/(165+o-r));
            }
          while(!cannon(aa,rr));
         }
      else scan_low();
     }
  else scan_low();
}

fire()
{
  if( (r=scan(a,10)) && (r<755) )
    {
          if (scan(a+353,3)) cannon(a+=353,(scan(a,10)<<1)-r);
     else if (scan(a+7,  3)) cannon(a+=7,  (scan(a,10)<<1)-r);
     else if (scan(a,   10)) cannon(a,     (scan(a,10)<<1)-r);
     else scan_low();
    }
   else scan_low();
}
