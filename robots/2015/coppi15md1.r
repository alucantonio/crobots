
/*======================= Torneo: CRobots (2015) ==========================
  
  CROBOT:    coppi15md1.r      (midi)
  CATEGORIA: 1000 istruzioni   (midi)
  AUTORE:    Luigi Cimini
  
 ==========================================================================
  
  Versione:  21-04-2015
  Revisione: 26-04-2015
  Alias:     mid_sne300.r
  
  Code utilization: 49%   (988 / 2000)
  mid_sne300.r compiled without errors
  
 ==========================================================================
  
  SCHEDA TECNICA:
  All'inizio dell'incontro il robot controlla se si tratta di un f2f, se gli
  avversari sono più di uno, ruota in senso orario ad una distanza dai bordi
  di circa un terzo delle dimensioni del campo di battaglia, quando i  danni
  superano il 60% viene lanciato l'attacco finale.
  
 ==========================================================================*/

int ang,a,oa,r,o,d,x,y,b,ne;
main()
{
   while (ang<360)
   {
      if (scan(ang+=21,10))
      {
         if ((++ne)>1)
         {
            while(damage()<61)
            {
               while (loc_x()>362) firevs(180,100); fire(270,59);
               while (loc_y()>362) firevs(270,100); fire(0,  59);
               while (loc_x()<638) firevs(0,  100); fire(90, 59);
               while (loc_y()<638) firevs(90, 100); fire(180,59);
            }
            while(1)
            {
               if (((x=loc_x(y=loc_y()))%850)<150) d=330+180*(x>500)+60*(y<500);
               else if ((y%850)<150)               d=60+ 180*(y>500)+60*(x>500);
               else if (r<180) d=a+180;
               else d=a+180*(b^=1);
               firef2f(d,100); firef2f(d,100); firef2f(d,100);
            }
         }
         else a=ang;
      }
   }
   while(1)
   {
      if (((x=loc_x(y=loc_y()))%850)<150) d=330+180*(x>500)+60*(y<500);
      else if ((y%850)<150)               d=60+ 180*(y>500)+60*(x>500);
      else if (r<224) d=a+180;
      else d=a+180*(b^=1);
      firef2f(d,100); firef2f(d,100); firef2f(d,100);
   }
}

fire(d,v)
{
int d,v;
   drive(d,v);
   if((r=scan(oa=a,10))&&(r<808))
   {
      if (scan(a+350,10)) a+=355; else a+=5;
      if (scan(a+350,10)) a+=357; else a+=3;
      return cannon(a+(a-oa),(scan(a,10)<<1)-r);
   }
   else if(r=scan(a-21,10)) cannon(a-=21,r);
   else if(r=scan(a+=21,10)) cannon(a,r);
   else {while (!(r=scan(a+=21,10))); cannon(a,r);}
   return cannon(a,(scan(a,10)<<1)-r);
}

firevs(d,v)
{
int d,v;
   drive(d,v);
   if (r=scan(oa=a,10))
   {
      if (scan(a-8,5)){if (scan(a-=5,2)); else a-=4;}
      else
      {
         if (scan(a+8,5)){if (scan(a+=5,2)); else a+=4;}
         else
         {
            if (scan(a,2))
            {
               if (scan(a-=2,2)) return(cannon(a+(a-oa),2*scan(a,10)-r));
               else return(cannon((a+=4)+(a-oa),2*scan(a,10)-r));
            }
            else if(r=scan(a-21,10)) cannon(a-=21,r);
            else {while (!(r=scan(a+=21,10))); cannon(a,r);}
            return cannon(a,(scan(a,10)<<1)-r);
         }
      }
      return(cannon(a+(a-oa),2*scan(a,10)-r));
   }
   else if(r=scan(a-21,10)) cannon(a-=21,r);
   else if(r=scan(a+=21,10)) cannon(a,r);
   else {while (!(r=scan(a+=21,10))); cannon(a,r);}
   return cannon(a,(scan(a,10)<<1)-r);
}

firef2f(d,v)
{
int d,v;
   drive(d,v);
   if (r=scan(oa=a,10))
   {
      if (scan(a-8,5)){if (scan(a-=5,2)); else a-=4;}
      else
      {
         if (scan(a+8,5)){if (scan(a+=5,2)); else a+=4;}
         else
         {
            if (scan(a,ne)) return(cannon(a+(a-oa),2*scan(a,10)-r));
            else
            {
               if (scan(a-=3,2)) return(cannon(a+(a-oa),2*scan(a,10)-r));
               else return(cannon((a+=6)+(a-oa),2*scan(a,10)-r));
            }
         }
      }
      return(cannon(a+(a-oa),2*scan(a,10)-r));
   }
   else if(r=scan(a+=20,10)) cannon(a,r);
   else if(r=scan(a-=40,10)) cannon(a,r);
   else if(r=scan(a+=60,10)) cannon(a,r);
   else if(r=scan(a-=80,10)) cannon(a,r);
   else return (a+=140);
   return cannon(a,(scan(a,10)<<1)-r);
}
