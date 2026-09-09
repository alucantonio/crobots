
/*======================= Torneo: CRobots (2015) ==========================
  
  CROBOT:    coppi15ma1.r     (macro)
  CATEGORIA: 2000 istruzioni  (macro)
  AUTORE:    Luigi Cimini
  
 ==========================================================================
  
  Versione:  21-04-2015
  Revisione: 26-04-2015
  Alias:     mac_sz68n2.r
  
  Code utilization: 95%   (1915 / 2000) 
  mac_sz68n2.r compiled without errors
  
 ==========================================================================
  
  SCHEDA TECNICA:
  All'inizio dell'incontro il robot controlla se si tratta di uno scontro a
  due, se gli avversari sono più di uno, oscilla nell'angolo più vicino, ogni
  5 cicli controlla il numero degli avversari, se ne resta solo 1 lo attacca,
  l'attacco viene lanciato anche se, all'approssimarsi dei 200000 cilcli i
  danni subiti sono sono minori del 40%.
  
 ==========================================================================*/

int a,oa,r,o,d,x,y,b,ne,d0,d1,d2,t,c,ang;
main()
{
   while (ang<360)
   {
      if (scan(ang+=21,10))
      {
         if ((++ne)>1)
         {
            if (loc_x()<500) sx(); else dx();
            if (loc_y()<500) {if(scan(270,10)==0) dn(); else up();}
            else             {if(scan(90, 10)==0) up(); else dn();}
            if (loc_x()<500){if (loc_y()<500) {d0=5; d1=45; d2=225;} else {d0=275;d1=315;d2=135;}}
            else            {if (loc_y()<500) {d0=95;d1=135;d2=315;} else {d0=185;d1=225;d2=45; }}
            while((++c)<67)
            {
               if (loc_x(t=6)<500)
               {
                  while(--t)
                  {
                     while(loc_x()<=80) firev(d1,100); fire(d2,59);
                     while(loc_x()>=80) firev(d2,100); fire(d1,59);
                  }
               }
               else
               {
                  while(--t)
                  {
                     while(loc_x()>=920) firev(d1,100); fire(d2,59);
                     while(loc_x()<=920) firev(d2,100); fire(d1,59);
                  }
               }
               if(c>65) if(damage()<40) c=999;
               else
               {
                  fire(d1,0);
                  if((ne=scan(d0,10)+scan(d0+20,10)+scan(d0+40,10)+scan(d0+60,10)+scan(d0+80,10))<2)
                     {c=999; ne=1;}
                  else firev(d1,100);
               }
            }
            ang=360;
         }
         else firev(a=ang,100);
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
      else if (y<167) d=75+ 30*(x>500);
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
   else if(r=scan(a+=21,10)) return cannon(a,r);
   else if(r=scan(a-=42,10)) return cannon(a,r);
   else return (a+=84);
}

sx() {while(loc_x()>80)  fire(180,100); fire(180,0);}
dx() {while(loc_x()<920) fire(0,  100); fire(0,  0);}
dn() {while(loc_y()>80)  fire(270,100); fire(270,0);}
up() {while(loc_y()<920) fire(90, 100); fire(90, 0);}

firev(d,v)
{
int d,v;
   drive(d,v);
   if((r=scan(oa=a,10))&&(r<808))
   {
      if (scan(a-8,5)){if (scan(a-=5,2)); else a-=4; return(cannon(a+(a-oa),2*scan(a,10)-r));}
      else
      {
         if (scan(a+8,5)){if (scan(a+=5,2)); else a+=4; return(cannon(a+(a-oa),2*scan(a,10)-r));}
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
   }
   else if(r=scan(a+=21,10)) return cannon(a,2*scan(a,10)-r);
   else if(r=scan(a-=42,10)) return cannon(a,2*scan(a,10)-r);
   else if(r=scan(a+=63,10)) return cannon(a,r);
   else if(r=scan(a-=84,10)) return cannon(a,r);
   else return (a+=142);
}

/*---------------------*/

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
      
      if (o=scan(oa=a,4))
      {
         if(scan(a-13,10)) a-=5; else if(scan(a+13,10)) a+=5;
         if(scan(a+12,10)) a+=4; else if(scan(a-12,10)) a-=4;
         if(scan(a-11,10)) a-=2; if(scan(a+11,10)) a+=2;
         
         cannon(a+(a-oa)*((880+(r=scan(a,10))>>9))-asin, r*230/(o-r-acos));
      }
      else if (scan(a-20,10)) return firev(a-=12,100);
      else if (scan(a+20,10)) return firev(a+=12,100);
      else {while (!(scan(a+=20,10))); return firev(a,100);}
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
      if (r>740)
      {
         if ((r>o) || (r>808))
         {
            if(ne<2) return drive(a,100);
            else {a+=21; while (!(scan(a+=21,10))); return;}
         }
      }
      return;
   }
   else if (r=scan(a-21, 10)) return cannon(a-=21,r);
   else if (r=scan(a+21, 10)) return cannon(a+=21,r);
   else if (r=scan(d,    10)) return cannon(a=d,  r);
   else a+=63;
}
