/*
  ======================= Torneo: CRobots (2020) ==========================

  CROBOT:    coppi20ma1.r         (macro)
  CATEGORIA: 2000 istruzioni      (macro)
  AUTORE:    Luigi Cimini

  ==========================================================================

  Versione:  05-02-2019
  Revisione: 27-08-2020
  Alias:     ma_4346x00.r

  Code utilization: 99%   (1997 / 2000)
  C:\crobots\_test\Mac\ma_4346x00.r compiled without errors

  ==========================================================================

  SCHEDA TECNICA:

  All'inizio il robot controlla se ha  di fronte un solo avversario, se gli
  avversari sono più di uno, ruota in  senso antiorario  lungo i bordi fino
  a quando non si superano un certo numero di giri e/o danni; in seguito il
  crobot, inizia ad oscillare  nell'angolo in cui si trova. Se i dannni su-
  biti sono inferiori al 67% cerca anche  di attaccare gli avversari. L'at-
  tacco finale, contro uno o più  avversari, viene  lanciato se i danni su-
  biti non  superano un  certo limite, l'attacco  parte anche se i cicli di
  oscillazioni nell'angolo superano 39.

  ==========================================================================
*/
int ang,a,oa,r,o,d,x,y,b,ne,d1,d2,dd,t,dm,c;

/* ======================================================================== */
/* ------------------------------------------------------------------------ */

/* -------------------------------------------------- */
dx() {while(loc_x(firev(0,  100))<925); fire0(0,  0);}
up() {while(loc_y(firev(90, 100))<925); fire0(90, 0);}
sx() {while(loc_x(firev(180,100))>75 ); fire0(180,0);}
dn() {while(loc_y(firev(270,100))>75 ); fire0(270,0);}
/* -------------------------------------------------- */

/* ------------------------------------------------------------------------ */
radar()
{
        if(r=scan(a-=21,10)) cannon(a,r);
   else if(r=scan(a+=42,10)) cannon(a,r);
   else {while (!(r=scan(a+=21,10))); cannon(a,r);}
   return cannon(a,2*scan(a,10)-r);
}

radar0()
{
        if (r=scan(a+=20,10));
   else if (r=scan(a-=40,10));
   else if (r=scan(a+=60,10));
   else return a+=40;
   cannon(a,r);  return cannon(a,2*scan(a,10)-r);
}

/* ------------------------------------------------------------------------ */

fire0(d,v)
{
int d,v;
   drive(d,v);
   if((r=scan(oa=a,10))&&(r<808))
   {
      if (!scan(a-=5, 5)) a+=11;
      if (!scan(a-=3, 2)) a+=5;
      return cannon(a+a-oa,2*scan(a,10)-r);
   }
   else radar0();
}
/* ------------------------------------------------------------------------ */

f2f100(d)
{
int d;
   drive(d,100);
   if(r=scan(oa=a,10))
   {
           if (scan(a-9,6)) {if (scan(a-=6,3)); else a-=6;}
      else if (scan(a+9,6)) {if (scan(a+=6,3)); else a+=6;}
      else if (scan(a,  1)) return cannon(a+a-oa,2*scan(a,10)-r);
      else
      {
         if (scan(a-=4,3)) return cannon(a+a-oa,2*scan(a,10)-r);
         else return cannon((a+=8)+a-oa,2*scan(a,10)-r);
      }
      return cannon(a+a-oa,2*scan(a,10)-r);
   }
   else radar();
}
/* ------------------------------------------------------------------------ */

firev(d,v)
{
int d,v;
   drive(d,v);
   if((r=scan(oa=a,10))&&(r<808))
   {
           if (scan(a-9,6)) {if (scan(a-=6,3)); else a-=6;}
      else if (scan(a+9,6)) {if (scan(a+=6,3)); else a+=6;}
      else if (scan(a,  2));
      else                  {if (scan(a-=3,2)); else a+=6;}
      return cannon(a+a-oa,2*scan(a,10)-r);
   }
   else radar0();
}
/* ------------------------------------------------------------------------ */

cerca()
{
   if(scan(a-13,10)) a-=5; else if(scan(a+13,10)) a+=5;
   if(scan(a+12,10)) a+=4; else if(scan(a-12,10)) a-=4;
   if(scan(a-11,10)) a-=2;      if(scan(a+11,10)) a+=2;
}
fuoco()
{
int asin,acos;
   if (scan(a,10))
   {
      asin=(sin(a-d)>>14); acos=(cos(a-d)>>12)-230;
      a-=7*(scan(a-18,10)>0); a+=7*(scan(a+18,10)>0);
      cerca();
      if (o=scan(oa=a,4))
      {
         cerca();
         cannon(a+(a-oa)*((880+(r=scan(a,10))>>9))-asin, r*230/(o-r-acos));
         if (r>808)
         {
            if(ne<2) return drive(a,100);
            else return radar0(a+=42);
         }
      }
      else f2f100(a);
   }
   else radar0();
}
/* ------------------------------------------------------------------------ */

spara(){
   if (o=scan(a, 10))
   {
      if (scan(a-15,10)) {if (scan(a-=13,4)) {if(scan(a-3,6)) a-=6; else ++a;} else if (scan(a-5,5)) a-=5;}
      else if(scan(a+14,10)) {if(scan(a+=14,5)) a+=5;}
      else if(scan(a+4,6)) a+=6; else a-=6;
   }
   else
   {
      if (o=scan(a-=21,10)) {if (scan(a-9, 10)) {if(scan(a-=13,5)) a-=5; else ++a;} else if(scan(a+9, 10)) a+=6;}
      else
      {
         if (o=scan(a+=42,10)) {if (scan(a+9,10)) a+=12;}
         else
         {
            if (o=scan(a+=21,10));
            else
            {
                    if (r=scan(a-=84, 10));
               else if (r=scan(a-=21, 10));
               else if (r=scan(a+=126,10));
               else if (r=scan(a+=21, 10));
               else if (r=scan(a-=168,10));
               else return a+=264;
               return cannon(a,2*scan(a,10)-r);
            }
         }
      }
   }
   if (r=scan(a,10))
   {
      cannon(a, r*145/(145+o-r));
      if (r>808)
      {
         if(ne<2) return drive(a,100);
         else return radar0(a+=42);
      }
   }
   else radar();
}
/* ------------------------------------------------------------------------ */

finale(k1,k2)
{
int k1,k2;
   firev(a,100);
   while(1)
   {       if (r>850) d=a+25+(b^=1)*225;
      else if (r>40 ) d=a+57+(b^=1)*208;
      if ((x=loc_x(y=loc_y()))>850) d=165+30*(y>500);
      else if (x<150) d=345+30*(y<500);
      else if (y>850) d=255+30*(x<500);
      else if (y<150) d=75+30*(x>500);
      else if(damage()>k1) d+=180;
      spara(drive(d,100));
      if(scan(a-15,10)) a-=4;
      if(scan(a+15,10)) a+=4;
      spara(drive(d,100)); if(r>k2) fuoco(drive(d,100));
   }
}
/* ------------------------------------------------------------------------ */
/* ======================================================================== */
/* ------------------------------------------------------------------------ */

main()
{
   while (ang<361)
   {
      if (scan(ang+=21,10))
      {
         if ((++ne)>1)
         {
            /* gira lungo i bordi */
            if (loc_x(a=ang)<500)
            {
               if (loc_y(t=8)<500) {while((damage()<43)&&(--t)) dn(sx(up(dx()))); d1=45;  d2=225;}  /* p=0; */
               else                {while((damage()<43)&&(--t)) sx(up(dx(dn()))); d1=315; d2=135;}  /* p=3; */
               dd=75;
            }
            else
            {
               if (loc_y(t=8)<500) {while((damage()<43)&&(--t)) dx(dn(sx(up()))); d1=135; d2=315;}  /* p=1; */
               else                {while((damage()<43)&&(--t)) up(dx(dn(sx()))); d1=225; d2=45; }  /* p=2; */
               dd=925;
            }

            dm=damage();
            /* Contatore dei cicli da 8 oscillazioni */
            while(++c)
            {
               /* oscilla in uno degli angoli ad Ovest */
               if (loc_x(t=9)<500)
               {
                  if (c>13)
                  {
                     /* cerca di attaccare da Ovest*/
                     if(damage()<67)
                     {
                        if(damage()>dm) {dm=damage(dd=75); t=2;}
                        else            {if(dd<=352)    dd+=10;}
                     }
                     else dd=75;
                  }
                  /* oscilla 8 volte ad Ovest */
                  while(--t)
                  {
                     while(loc_x()<=dd) firev(d1,100); firev(d2,59);
                     while(loc_x()>=dd) firev(d2,100); fire0(d1,0);
                  }
               }
               /* oscilla in uno degli angoli ad Est */
               else
               {
                  if (c>13)
                  {
                     /* cerca di attaccare da Est*/
                     if(damage()<67)
                     {
                        if(damage()>dm) {dm=damage(dd=925); t=2;}
                        else            {if(dd>=648)     dd-=10;}
                     }
                     else dd=925;
                  }
                  /* oscilla 8 volte ad Est */
                  while(--t)
                  {
                     while(loc_x()>=dd) firev(d1,100); firev(d2,59);
                     while(loc_x()<=dd) firev(d2,100); fire0(d1,0);
                  }
               }
               /* controlla danni, avversari e numero cicli. */
               if (c>9)
               {
                  if (((ne=
                     ((scan(d1-50,10))>0)+
                     ((scan(d1-30,10))>0)+
                     ((scan(d1-10,10))>0)+
                     ((scan(d1+10,10))>0)+
                     ((scan(d1+30,10))>0)+
                     ((scan(d1+50,10))>0))==1)            && (damage()<73)) c=-1;
                  else if ((ne            ==2)            && (damage()<61)) c=-1;
                  else if(((ne            ==3) || (c>39)) && (damage()<41)) c=-1;
               }
            }
            /* attacco finale in base al numero di avversari */
            if (ne>1) finale(75,342); else finale(80,372);
         }
         else f2f100(a=ang);
      }
   }
   /* f2f */
   f2f100(a);
   while(1)
   {
      if (((x=loc_x(y=loc_y()))%880)<120) d=330+180*(x>500)+60*(y<500);
      else if ((y%880)<120)               d=60+ 180*(y>500)+60*(x>500);
      else if (r<224)                     d=a+180;
      else                                d=a+180*(b^=1);
      f2f100(d); f2f100(d); f2f100(d);
   }
}
/* ------------------------------------------------------------------------ */
/* ======================================================================== */
