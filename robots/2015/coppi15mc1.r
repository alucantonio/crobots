
/*======================= Torneo: CRobots (2015) ==========================

  CROBOT:    coppi15mc1.r    (micro)
  CATEGORIA: 500 istruzioni  (micro)
  AUTORE:    Luigi Cimini
  
 ==========================================================================
 
  Versione:  21-04-2015
  Revisione: 26-04-2015
  Alias:     mic_s3k.r
  
  Code utilization: 24%   (492 / 2000) 
  mic_s3k.r compiled without errors
  
 ==========================================================================
 
  SCHEDA TECNICA:
  All'inizio dell'incontro il robot controlla se si tratta di un f2f, se gli
  avversari sono più di uno, ruota in senso orario ad una distanza dai bordi
  di circa un terzo delle dimensioni del campo di battaglia, quando i  danni
  superano il 60% viene lanciato l'attacco finale.
  
 ==========================================================================*/

int ang,a,oa,r,o,d,x,y,b,ne,k;
main()
{
   while (ang<360)
   {
      if (scan(ang+=20,10))
      {
         if ((++ne)>1)
         {
            while(damage()<61)
            {
               while (loc_x()>362) fire(180,100,1); fire(270,59,1);
               while (loc_y()>362) fire(270,100,1); fire(0,  59,1);
               while (loc_x()<638) fire(0,  100,1); fire(90, 59,1);
               while (loc_y()<638) fire(90, 100,1); fire(180,59,1);
            }
            ang=360;
         }
      }
   }
   while(1)
   {
      if (((x=loc_x(y=loc_y()))%850)<150) d=330+180*(x>500)+60*(y<500);
      else if ((y%850)<150)               d=60+ 180*(y>500)+60*(x>500);
      else if (r<224) d=a+180;
      else d=a+180*(b^=1);
      fire(d,100,0); fire(d,100,0); fire(d,100,0);
   }
}

radar()
{
   if(r=scan(a-21,10)) cannon(a-=21,r);
   else while (!(r=scan(a+=21,10)));
   return cannon(a,(scan(a,10)<<1)-r);
}

fire(d,v,k)
{
int d,v,k;
   drive(d,v);
   if (r=scan(oa=a,10))
   {
      if (scan(a-8,5)) {if(scan(a-=5,2)); else a-=4; return(cannon(a+(a-oa),2*scan(a,10)-r));}
      else
      {
         if (scan(a+8,5)) {if(scan(a+=5,2)); else a+=4 ;return(cannon(a+(a-oa),2*scan(a,10)-r));}
         else
         {
            if (k)
            {
               if (scan(a,2))
               {
                  if(scan(a-=2,2)) return(cannon(a+(a-oa),2*scan(a,10)-r));
                  else return(cannon((a+=4)+(a-oa),2*scan(a,10)-r));
               }
               else radar();
            }
            else
            {
               if (scan(a,1));
               else
               {
                  if(scan(a-=3,2)); else a+=6;
               }
               return(cannon(a+(a-oa),2*scan(a,10)-r));
            }
         }
      }
   }
   else radar();
}
