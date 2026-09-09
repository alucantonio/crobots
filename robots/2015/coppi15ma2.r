
/*======================= Torneo: CRobots (2015) ==========================
  
  CROBOT:    coppi15ma2.r      (macro)
  CATEGORIA: 2000 istruzioni   (macro)
  AUTORE:    Luigi Cimini
  
 ==========================================================================
  
  Versione:  21-04-2015
  Revisione: 26-04-2015
  Alias:     mac_tox33s1.r
  
  Code utilization: 96%   (1933 / 2000)
  mac_tox33s1.r compiled without errors
  
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
         else firevs(a=ang,100);
      }
   }
   while(1)
   {
           if (r>850) d=a+25+(b^=1)*225;
      else if (r>40 ) d=a+57+(b^=1)*208;
      else;
      if ((x=loc_x(y=loc_y()))>833) d=165+30*(y>500);
      else if (x<167) d=345+30*(y<500);
      else if (y>833) d=255+30*(x<500);
      else if (y<167) d=75+30*(x>500);
      else if(damage()>75) d+=180;
      spara(drive(d,100));
      if(scan(a-15,10)) a-=4;
      if(scan(a+15,10)) a+=4;
      spara(drive(d,100)); if(r>372) fuoco(drive(d,100));
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
      return cannon(a+(a-oa),2*scan(a,10)-r);
   }
   else if(r=scan(a-21,10)) cannon(a-=21,r);
   else if(r=scan(a+=21,10)) cannon(a,r);
   else {while(!(r=scan(a+=21,10)));}
   return cannon(a,2*scan(a,10)-r);
}

firevs(d,v)
{
int d,v;
   drive(d,v);
   if (r=scan(oa=a,10))
   {
      if(scan(a-8,5)) {if(scan(a-=5,2)); else a-=4; return(cannon(a+(a-oa),2*scan(a,10)-r));}
      else
      {
         if(scan(a+8,5)) {if(scan(a+=5,2)); else a+=4; return(cannon(a+(a-oa),2*scan(a,10)-r));}
         else
         {
            if (scan(a,2))
            {
               if (scan(a-=2,2)) return(cannon(a+(a-oa),2*scan(a,10)-r));
               else return(cannon((a+=4)+(a-oa),2*scan(a,10)-r));
            }
            else if(r=scan(a-21,10)) cannon(a-=21,r);
            else {while (!(r=scan(a+=21,10))); cannon(a,r);}
            return cannon(a,2*scan(a,10)-r);
         }
      }
   }
   else if(r=scan(a-21,10)) cannon(a-=21,r);
   else if(r=scan(a+=21,10)) cannon(a,r);
   else {while (!(r=scan(a+=21,10))); cannon(a,r);}
   return cannon(a,2*scan(a,10)-r);
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
   else if(r=scan(a-21,10)) cannon(a-=21,r);
   else if(r=scan(a+=21,10)) cannon(a,r);
   else {while (!(r=scan(a+=21,10))); cannon(a,r);}
   return cannon(a,2*scan(a,10)-r);
}

/* -------------------*/

fuoco()
{
int asin,acos;
   if (speed()>90){if (r=scan(d,10)) {if (r<850) a=d; else return drive(d,100);}}
   if (scan(a,10))
   {
      asin=(sin(a-d)>>14); acos=(cos(a-d)>>12)-230;
      a-=7*(scan(a-18,10)>0); a+=7*(scan(a+18,10)>0);

      if(scan(a-13,10)) a-=5; else if(scan(a+13,10)) a+=5;
      if(scan(a+12,10)) a+=4; else if(scan(a-12,10)) a-=4;
      if(scan(a-11,10)) a-=2; if(scan(a+11,10)) a+=2;
      
      if (o=scan(oa=a,3))
      {
         if(scan(a-13,10)) a-=5; else if(scan(a+13,10)) a+=5;
         if(scan(a+12,10)) a+=4; else if(scan(a-12,10)) a-=4;
         if(scan(a-11,10)) a-=2; if(scan(a+11,10)) a+=2;
         
         cannon(a+(a-oa)*((880+(r=scan(a,10))>>9))-asin, r*230/(o-r-acos));
      }
      else if (scan(a-20,10)) return firef2f(a-=12,100);
      else if (scan(a+20,10)) return firef2f(a+=12,100);
      else {while (!(scan(a+=20,10))); return firef2f(a,100);}
   }
   else if (r=scan(a-21, 10)) return cannon(a-=21,r);
   else if (r=scan(a+21, 10)) return cannon(a+=21,r);
   else if (r=scan(d,    10)) return cannon(a=d,  r);
   else a+=63;
}

spara()
{
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
                    if (r=scan(a-=84, 10)) return cannon(a,r);
               else if (r=scan(a-=21, 10)) return cannon(a,r);
               else if (r=scan(a+=126,10)) return cannon(a,r);
               else if (r=scan(a+=21, 10)) return cannon(a,r);
               else if (r=scan(a-=168,10)) return cannon(a,r);
               else if (r=scan(a-=21, 10)) return cannon(a,r);
               else if (r=scan(a+=210,10)) return cannon(a,r);
               else return a+=69;
            }
         }
      }
   }
   if (r=scan(a,10))
      {
         cannon (a, r*165/(165+o-r));
         if (r>740) {if ((r>o) || (r>808)) return drive(a,100);}
         return;
      }
   else if (r=scan(a-21, 10)) return cannon(a-=21,r);
   else if (r=scan(a+21, 10)) return cannon(a+=21,r);
   else if (r=scan(d,    10)) return cannon(a=d,  r);
   else a+=63;
}
