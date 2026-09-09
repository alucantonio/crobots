  
/*--------------------------- Torneo: CRobots (2015) -----------------------
  
  CROBOT:    LinaBo15           (micro)
  CATEGORIA: 500 istruzioni       (micro)
  AUTORE:    Andrea Jasci Cimini
  
  Code utilization: 24%   (495 / 2000)
  LinaBo15.r compiled without errors
  
 ----------------------------------------------------------------------------

  TECHNICAL DATA SHEET: Micro Crobot that emulates Power.r e Lamela.r.
  
 ---------------------------------------------------------------------------*/
  
int x,y,b,d,r,o,a,oa;
main()
{
   spara(drive(d=180*(loc_x()>499),100));
   while(1)
   {       if (r>850) d=a+25+(b^=1)*225;
      else if (r>40 ) d=a+57+(b^=1)*207;
      else;
      if ((x=loc_x(y=loc_y()))>833) d=165+30*(y>500);
      else if (x<167) d=345+30*(y<500);
      else if (y>833) d=255+30*(x<500);
      else if (y<167) d=75+30*(x>500);
      else if(damage()>80) d+=180;
      spara(drive(d,100));
      if(scan(a-15,10)) a-=4;
      if(scan(a+15,10)) a+=4;
      spara(drive(d,100));
   }
}

spara()
{
   if (o=scan(a, 10))
   {
      if (scan(a-15,10)) {if (scan(a-=13,4)) {if(scan(a-3,6)) a-=6; else ++a;} else if (scan(a-5,5)) a-=5;}
      else if(scan(a+14,10)) {if(scan(a+=13,5)) a+=5; else --a;}
      else if(scan(a+4,6)) a+=6; else a-=6;
   }
   else
   {
      if (o=scan(a-=20,10)) {if (scan(a-9,10)) {if (scan(a-=13,5)) a-=5; else ++a;} else if(scan(a+9,10)) a+=6;} 
      else
      {
         if (o=scan(a+=40,10)) {if (scan(a+9,10)) a+=12;}
         else
         {
            if (o=scan(a+=20,10));
            else
            {
               if (r=scan(a-=80,10)) return cannon(a,r); else return radar(a+=80);
            }
         }
      }
   }
   if (r=scan(a,10))
   {  
      cannon (a, r*175/(175+o-r)); 
      if (r>740){if ((r>o) || (r>800)) return radar(a+=42);}
      return;
   }
   else return radar(a-=42);
}

radar(){while (!(r=scan(a+=21,10))); return cannon(a,r);}