/*

  ======  Crobot ALFA99  per scontri a 4 - by L.Cimini 26-11-1999  ======


ROBOT : Alfa99.r


 Luigi Cimini


TECHNICAL CARD:

  The crobot looks for an angle in which position and it there stay up to
  when it has not suffered a superior damage to the 3 %, if the damage
  overcomes this limit the crobot it moves in one of the adjacent angles,
  if the angles have occupied oscillate for 100 cycles or up to when it
  doesn't suffer a superior damage to the 8%. 
  The general strategy of the crobot consists of the check each 100 cycles
  the number of the adversaries, if an only adversary stays and the crobot
  has suffered inferior damages to the 88% it attaches, if the damages are
  superior to the 87% it oscillate until at the end; old the 200000 cycles,
  if the surviving adversaries are two and the damages are small of the 60%
  the crobot oscillates for 100 cycles, if the damages are small of the 30%
  it oscillate for 100 cycles and it then effect the final attack also.

  The routine of fire, already note, has stayed modified for increase his
  efficiency, the routine is able to behavior 3 types of draught, from firm,
  in movement and for near target, the type of draught has selected in base
  to the distance or using the function speed() like selector. 

CHOICE: 

  If it is necessary limit the fights to an only crobot you do
  you the choice.


SCHEDA TECNICA:

  Il crobot cerca un angolo in cui posizionarsi e vi resta fino a quando
  non ha subito un danno superiore al 3 %, se il danno supera questo
  limite il crobot si trasferisce in uno degli angoli adiacenti, se gli
  angoli sono occupati oscilla per 100 cicli o fino a quando non subisce
  un danno superiore all'8 %.
  La strategia generale del crobot consiste nel controllare ogni 100 cicli
  il numero degli avversari, se resta un solo avversario e il crobot ha
  subito danni inferiori all'88 % attacca, se i danni sono superiori
  all'87 % oscilla fino alla fine; superati i 200000 cicli, se gli
  avversari sopravvissuti sono due e i danni sono minori del 60 % il
  crobot oscilla per 100 cicli, se i danni sono minori del 30 % oscilla
  per 100 cicli e poi effettua anche l`attacco finale.

  La routine di fuoco, già nota, è stata modificata per aumentare la sua
  efficienza, la routine è in grado di fare 3 tipi di tiro, da fermo,
  in movimento e per bersaglio vicino, il tipo di tiro è selezionato in
  base alla distanza o usando come selettore la funzione speed().

SCELTA:

  Se è necessario limitare i combattimenti ad un solo crobot fate voi
  la scelta.


*/


int a,d,danno,n,r,o,oa,t,tt,k,l;

main()
{
   tt=3600; /*100 x 30*/
   
   if (loc_x()<500) sx(0); else dx(999);
   if (loc_y()>500)
   {
      if (libero( 90)) up(999);
      else if (libero(270)) dn(0);
      else up(999);
   }
   else
   {
      if (libero(270)) dn(0);
      else if (libero( 90)) up(999);
      else dn(0);
   }
   danno=damage();
   
   while(1)
   {
      t=100;    
      while(--t)
      {
         fuoco(); if (damage()>(danno+3)) { scappa(); danno=damage(); }
      }
      tt-=100;
      
      n=0; a=1; while(a!=721) {if (scan(a,10)) ++n; a+=20;}
      
      if (n<3)
      {
         if (damage()<88) finale(); else oscilla(850);
      }
      else if (tt<1)
      {
         if ((n<5) && (damage()<60))
         {
            oscilla(266); if (damage()<30) finale();
         }
         else
         {
            if ( (free()) && (n>2) ) oscilla(388);
         }
      }
   }
}

libero(a)
{
   return(((scan(a,10))+(scan(a+20,10)))<150);
}

free()
{
   if (loc_y()<500) return(libero(90)); else return(libero(270));
}

sito()
{
   return (loc_x()>500)+2*(loc_y()>500);    /* 0=SO 1=SE 2=NO 3=NE */
}

sx(x) {d=180; while(loc_x()>x) {drive(d,100); fuoco();} drive(d,0); }
dx(x) {d=0;   while(loc_x()<x) {drive(d,100); fuoco();} drive(d,0); }
dn(y) {d=270; while(loc_y()>y) {drive(d,100); fuoco();} drive(d,0); }
up(y) {d=90;  while(loc_y()<y) {drive(d,100); fuoco();} drive(d,0); }

scappa()
{
   if (loc_y()< 500) { if (libero( 90)) { up(953); return; } }
   else { if (libero(270)) { dn(66 ); return; } }
   if (loc_x()< 500) { if (libero(  1)) { dx(933); return; } }
   else { if (libero(180)) { sx(66 ); return; } }
   oscilla(200);
}

oscilla(l)
{
   danno=damage();
   t=100;
   while( (--t) && (damage()<(danno+9)) )
   {
      if (loc_y()< 500) { up(l); dn(100); } else { dn(999-l); up(900); }
   }
}

finale()
{
   if ((sito()==1) || (sito()==2)) d=315; else d=45;
   while(1)
   {
      while (loc_x()<900) { drive (d,100); fuoco(); } d+=180;
      while (loc_x()>100) { drive (d,100); fuoco(); } d+=180;
   }
}

fuoco()
{
   if ((r=scan(a,10)) && (r<767))
   {
      if (!scan(a+=355,5)) a+=10;
      if (r<313)
      {
         if (!scan(a+=357,3)) a+=6;
         cannon(a,(scan(a,10)<<1)-r);
         return;
      }
      if(scan(a+355,1)) a+=355;
      if(scan(a+5,  1)) a+=5;
      if(scan(a+357,1)) a+=357;
      if(scan(a+3,  1)) a+=3;
      if(scan(a+359,1)) a+=359;
      if(scan(a+1,  1)) a+=1;
      
      if (o=scan(oa=a,5))
      {
         if(scan(a+355,1)) a+=355;
         if(scan(a+5,  1)) a+=5;
         if(scan(a+357,1)) a+=357;
         if(scan(a+3,  1)) a+=3;
         if(scan(a+359,1)) a+=359;
         if(scan(a+1,  1)) a+=1;
         
         if (r=scan(a,10))
         {
            if (speed())
            {
               cannon(a+(a-oa)*((1200+r)>>9)-(sin(a-d)>>14), r*160/(160+o-r-(cos(a-d)>>12)));
            }
            else
            {
               cannon(a+(a-oa)*((1200+r)>>9), r*160/(160+o-r));
            }
         }
      }
   }
   else
   {
      if (scan(a+=339,10)) return;
      if (scan(a+=42, 10)) return;
      a+=42; return;
   }
}
