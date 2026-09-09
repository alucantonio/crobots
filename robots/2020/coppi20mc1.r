/*
  ======================= Torneo: CRobots (2020) ==========================

  CROBOT:    coppi20mc1.r         (micro)
  CATEGORIA: 500  istruzioni      (micro)
  AUTORE:    Luigi Cimini

  ==========================================================================

  Versione:  05-02-2019
  Revisione: 27-08-2020
  Alias:     mc_85Y_08.r

  Code utilization: 25%   (500 / 2000)
  C:\crobots\_test\Mic\mc_85Y_08.r compiled without errors

  ==========================================================================

  SCHEDA TECNICA:

  All'inizio il robot controlla se ha di fronte un solo avversario, se gli
  avversari sono più di uno, ruota in senso antiorario ad una distanza mi-
  nima dai bordi, dopo 7 giri o se i danni superano il 60%, il crobot lan-
  cia l'attacco contro i sopravvissuti.

  ==========================================================================
*/

int ang,a,oa,r,o,d,x,y,b,ne,c;
main()
{
   while (ang<361)
   {
      if (scan(ang+=20,10))
      {
         if ((++ne)>1)
         {
            c=8;
            while((damage()<61)&&(--c))
            {
               while (loc_x()<915) f2f100(0);   fire59(90);
               while (loc_y()<915) f2f100(90);  fire59(180);
               while (loc_x()>85 ) f2f100(180); fire59(270);
               while (loc_y()>85 ) f2f100(270); fire59(0);
            }
            ang=361;
         }
         else f2f100(a=ang);
      }
   }
   f2f100(a);
   while(1)
   {
      if (((x=loc_x(y=loc_y()))%880)<120) d=330+180*(x>500)+60*(y<500);
      else if ((y%880)<120)               d=60+ 180*(y>500)+60*(x>500);
      else if (r<224) d=a+180;
      else d=a+180*(b^=1);
      f2f100(d); f2f100(d); f2f100(d);
   }
}
/* --------------------------------------------------- */

radar()
{
        if(r=scan(a-=20,10)) cannon(a,r);
   else if(r=scan(a+=40,10)) cannon(a,r);
   else {while (!(r=scan(a+=21,10)));}
   return cannon(a,2*scan(a,10)-r);
}
/* --------------------------------------------------- */

fire59(d)
{
int d;
   drive(d,59);
   if((r=scan(oa=a,10))&&(r<808))
   {
      if (!scan(a-=5, 5)) a+=11;
      if (!scan(a-=3, 2)) a+=5;
      return cannon(a+a-oa,2*scan(a,10)-r);
   }
   else radar();
}
/* --------------------------------------------------- */

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
         if (scan(a-=4,3)); else return cannon((a+=8)+a-oa,2*scan(a,10)-r);
      }
      return cannon(a+a-oa,2*scan(a,10)-r);
   }
   else radar();
}
/* --------------------------------------------------- */