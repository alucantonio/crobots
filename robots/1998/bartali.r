/*

     ========   VIII  Torneo Crobots MCmicrocomputer 1998   =========


ROBOT : BARTALI.R


 Luigi Cimini


SCHEDA TECNICA:

  Questo robot si posiziona nell`angolo S-O, per quanto riguarda il gover-
  no delle oscillazioni adotta un comportamento invertito rispetto a quanto
  faceva il vincitore dello scorso torneo. Per quanto attiene la  strategia
  generale il robot controlla ogni 25 cicli il numero degli avversari e se ne
  resta uno solo e non a subito danni superiori al 90 per cento lo attacca,
  quando i cicli CPU si avvicinano alle 400000 attacca comunque a prescindere
  dal numero deli avversari e dai danni subiti.


SCELTA:

  Nel caso si rendesse necessario limitare i combattimenti ad un solo
  robot preferisco veder combattere COPPI.R

*/

int a,aa,b,d,n,r,rr,o,oa,xx,yy,t,tt;

main()
{
  tt=250;
  while(1)
    {
     fuoco(); go(200,200);
     fuoco(); go(44,44); 
     t=25;
     while(--t)
       {
        fuoco(); drive(45, 1);
        if (scan(90,10)<=scan(1,10))
          {
           drive(d=90, 100); while(loc_y()<254) fuoco();
           drive(90,     0); while(speed()> 49) fire();
           drive(d=270,100); while(loc_y()>100) fuoco();
           drive(270,    0); while(speed()> 49) fire();
          }
        else
          {
           drive(d=0,  100); while(loc_x()<254) fuoco();
           drive(0,      0); while(speed()> 49) fire();
           drive(d=180,100); while(loc_x()>100) fuoco();
           drive(180,    0); while(speed()> 49) fire();
          }
       }
     drive(n=0,0); b=-11; while(b<350) if(scan(b+=20,10)) n+=1;
     if( ((n<2) && (damage()<90)) || ((tt-=25)<0) )
       {
        fuoco(); go(166,166);
        while(damage()<90)
          {
           d=45;  while (loc_x()<833) {drive (45, 100); fuoco();}
           d=225; while (loc_x()>166) {drive (225,100); fuoco();}
          }
       }
    }
}

scan14()
{
  if(scan(a+354,1)) a+=354;
  if(scan(a+6,  1)) a+=6;
  if(scan(a+356,1)) a+=356;
  if(scan(a+4,  1)) a+=4;
  if(scan(a+358,1)) a+=358;
  if(scan(a+2,  1)) a+=2;
}

scan140()
{
        if (r=scan(a+340,10)) cannon(a+=340,(scan(a,10)<<1)-r);
   else if (r=scan(a+20, 10)) cannon(a+=20, (scan(a,10)<<1)-r);
   else if (r=scan(a+320,10)) cannon(a+=320,(scan(a,10)<<1)-r);
   else if (r=scan(a+40, 10)) cannon(a+=40, (scan(a,10)<<1)-r);
   else if (r=scan(a+300,10)) cannon(a+=300,(scan(a,10)<<1)-r);
   else if (r=scan(a+60, 10)) cannon(a+=60, (scan(a,10)<<1)-r);
   else a+=140;
}

fuoco()
{
  if (!scan(a,7))
  if (!scan(a+=345,7))
  if (!scan(a+=30,7)) {scan140(); return;}
  if ((o=scan(a,10))<300) {fire(); return;}

   if (o<755)
     {
      scan14();
      if (o=scan(a,7))
        {
         oa=a;
         scan14();
         if (r=scan(a,10))
           {
            aa=(a+(a-oa)*((1200+r)>>9)-(sin(a-d)>>14));
            rr=(r*160/(160+o-r-(cos(a-d)>>12)));
            while(!cannon(aa,rr));
           }
        }
      else scan140();
     }
   else scan140();
}

fire()
{
  if( (r=scan(a,10)) && (r<755) )
    {
          if (scan(a+353,3))  cannon(a+=353,(scan(a,10)<<1)-r);
     else if (scan(a+7,  3))  cannon(a+=7,  (scan(a,10)<<1)-r);
     else if (scan(a,    5))  cannon(a,     (scan(a,10)<<1)-r);
     else scan140();
    }
   else scan140();
}

go(xx,yy)
{
  int x,y;
  x = loc_x() - xx; y = (loc_y() - yy) * 100000;
  if (x<0) d=360+atan(y/x); else d=180+atan(y/x);
  while((x=xx-loc_x())*x+(y=yy-loc_y())*y>9999) {drive(d,100); fire();}
  while((x=xx-loc_x())*x+(y=yy-loc_y())*y>584) drive(d,22); drive(d,0);
}
