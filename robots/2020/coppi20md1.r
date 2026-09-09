/*
  ======================= Torneo: CRobots (2020) ==========================

  CROBOT:    coppi20md1.r         (midi)
  CATEGORIA: 2000 istruzioni      (midi)
  AUTORE:    Luigi Cimini

  ==========================================================================

  Versione:  05-02-2019
  Revisione: 27-08-2020
  Alias:     md_4346x00.r

  Code utilization: 49%   (991 / 2000)
  C:\crobots\_test\Mid\md_4346x00.r compiled without errors

  ==========================================================================

  SCHEDA TECNICA:

  All'inizio il robot controlla se ha  di fronte un solo avversario, se gli
  avversari sono più di uno, ruota in  senso antiorario  lungo i bordi fino
  a quando non si superano un certo numero di giri e/o danni; in seguito il
  crobot, inizia ad oscillare  nell'angolo in cui si trova. L'attacco fina-
  le, contro uno o più  avversari, viene lanciato se i danni subiti non su-
  perano un  certo limite, l'attacco  parte anche se i cicli di oscillazio-
  ne nell'angolo superano 39.

  ==========================================================================
*/
int ang,a,oa,r,o,d,x,y,b,ne,d1,d2,dd,t,dm,c,amin,amax;

/* ======================================================================== */
/* ------------------------------------------------------------------------ */

/* -------------------------------------------------- */
dx() {while(loc_x(firev(0,  100))<925); firev(0,  0);}
up() {while(loc_y(firev(90, 100))<925); firev(90, 0);}
sx() {while(loc_x(firev(180,100))>75 ); firev(180,0);}
dn() {while(loc_y(firev(270,100))>75 ); firev(270,0);}
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

f2f100(d)
{
int d;
   drive(d,100);
   if (r=scan(oa=a,10))
   {
           if (scan(a-9,6)) {if (scan(a-=6,3)); else a-=6;}
      else if (scan(a+9,6)) {if (scan(a+=6,3)); else a+=6;}
      else if (scan(a,  1));
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

conta90()
{
   int a1; a1=amin; while (a1<amax) {if(scan(a1+=20,10)) ++ne;}
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
            amin=d1+290; amax=amin+91;
            /* Contatore dei cicli da 8 oscillazioni */
            while(++c)
            {
               /* oscilla in uno degli angoli ad Ovest */
               if (loc_x(t=9)<500)
               {
                  /* oscilla 8 volte ad Ovest */
                  while(--t)
                  {
                     while(loc_x()<=dd) firev(d1,100); firev(d2,59);
                     while(loc_x()>=dd) firev(d2,100); firev(d1,0);
                  }
               }
               /* oscilla in uno degli angoli ad Est */
               else
               {
                  /* oscilla 8 volte ad Est */
                  while(--t)
                  {
                     while(loc_x()>=dd) firev(d1,100); firev(d2,59);
                     while(loc_x()<=dd) firev(d2,100); firev(d1,0);
                  }
               }
               /* controlla danni, avversari e numero cicli. */
               if (c>9)
               {
                       if(((conta90(ne=0))==1)            && (damage()<73)) c=-1;
                  else if(((ne             >1) || (c>39)) && (damage()<51)) c=-1;
               }
            }
            ang=361; /* attacco finale */
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