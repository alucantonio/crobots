  
/*--------------------------- Torneo: CRobots (2015) ------------------------
  
  CROBOT:    frank15.r           (midi)
  CATEGORIA: 1000 istruzioni     (midi)
  AUTORE:    Andrea Jasci Cimini
  
  Code utilization: 47%   (958 / 2000)
  frank15.r compiled without errors
  
  ---------------------------------------------------------------------------
  TECHNICAL DATA SHEET:

  FRANK 15
  
  At the beginning of the robot checks whether it is a F2F battle,
  if the opponents are more than one, swings in the corner nearest each
  5 cycles controls the number of opponents, it remains only one attacking him,
  the attack was also launched at the approach of 200,000 cycles.
  
 ---------------------------------------------------------------------------*/
  
int a,oa,r,o,d,x,y,b,ne,d0,d1,d2,t,c,ang,dd;
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
            if (loc_x()<500) dd=80; else dd=920;
            while(1)
            {
               if (loc_x(t=6)<500)
               {
                  while(--t)
                  {
                     while(loc_x()<=dd) firev(d1,100); fire(d2,59);
                     while(loc_x()>=80) firev(d2,100); fire(d1,59);
                  }
               }
               else
               {
                  while(--t)
                  {
                     while(loc_x()>=dd) firev(d1,100); fire(d2,59);
                     while(loc_x()<=920) firev(d2,100); fire(d1,59);
                  }
               }
               if(ne>1)
               {
                  fire(d1,0);
                  if(((ne=scan(d0,10)+scan(d0+20,10)+scan(d0+40,10)+scan(d0+60,10)+scan(d0+80,10))<2)||((++c)>63))
                  {if (loc_x()<500) dd=400; else dd=600;}
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
      if (((x=loc_x(y=loc_y()))%850)<150) d=330+180*(x>500)+60*(y<500);
      else if ((y%850)<150)               d=60+ 180*(y>500)+60*(x>500);
      else if (r<224) d=a+180;
      else d=a+180*(b^=1);
      firev(d,100); firev(d,100); firev(d,100);
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
