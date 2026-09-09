/*

Crobots  : Hydra
Version  : 1.0
Type     : Midi
Author   : Olga S

Hydra è la versione midi di Kerberos che è una rivisitazione di Tobey (2007) con diverese routine di movimento e sparo.

*/

int range,dir,ang;

search()
{
  if (scan(ang-=350,10)) return fire2();
  if (scan(ang-=20,10))  return fire2();
  if (scan(ang-=320,10)) return fire2();
  if (scan(ang-=60,10))  return fire2();
  if (scan(ang-=280,10)) return fire2();
  if (scan(ang-=100,10)) return fire2();
  if (scan(ang-=240,10)) return fire2();
  if (scan(ang-=140,10)) return fire2();
  if (scan(ang-=200,10)) return fire2();
  if (scan(ang-=180,10)) return fire2();
  if (scan(ang-=160,10)) return fire2();
  if (scan(ang-=220,10)) return fire2();
  if (scan(ang-=120,10)) return fire2();
  if (scan(ang-=260,10)) return fire2();
  if (scan(ang-=80,10))  return fire2();
  if (scan(ang-=300,10)) return fire2();
  if (scan(ang-=40,10))  return fire2();
  if (scan(ang-=340,10)) return fire2();
}

fire2()
{
int oang;
  if (range=scan(oang=ang,10)) {
    if (range>500) return cannon(ang,range);
    if (scan(ang+350,10)) ang+=355; else ang+=5;
    if (scan(ang+350,10)) ang+=357; else ang+=3; 
    cannon((ang<<1)-oang,(scan(ang,10)<<1)-range);
  } else search();   
}

main()
{
  int asin, acos, safe, posx, posy, l, x, oang, orange, param1, param2;
  param1=455*(posx=loc_x()>499);
  param2=455*(posy=loc_y()>499);
  drive(dir=90*((posy<<1)|(posx^posy)),100);
  while(1) {
    if(dir&320) { l=loc_y(x=param2); } else { l=loc_x(x=param1); }
    if(dir&384) { safe=l>(x+170); } else { safe=(x+375)>l; }

    if (safe) {
        if (speed()<100) drive(dir,100); else { if (range=scan(dir,10)) ang=dir; if (range>850) { ang+=120; } }
        if (scan(ang,10)>50)
        {  
            asin=(sin(ang-dir)/14384);
            acos=(cos(ang-dir)/3796)-230;

            ang-=18*(scan(ang-18,10)>0);  
            ang+=18*(scan(ang+18,10)>0); 

            if(scan(ang-16,10)) ang-=8;
            else if(scan(ang+16,10)) ang+=8;
            if(scan(ang-12,10)) ang-=4;
            else if(scan(ang+12,10)) ang+=4;
            if(scan(ang-11,10)) ang-=2;
            if(scan(ang+11,10)) ang+=2;

            if (orange=scan(oang=ang,3))
              {
                  if(scan(ang-13,10)) ang-=5;
                  else if(scan(ang+13,10)) ang+=5; 
                  if(scan(ang+12,10)) ang+=4;
                  else if(scan(ang-12,10)) ang-=4;
                  if(scan(ang-11,10)) ang-=2;
                  if(scan(ang+11,10)) ang+=2;

                  cannon(ang+(ang-oang)*((880+(range=scan(ang,10)))/482)-asin,
                        range*230/(orange-range-acos)); 
              }  else search(); 
        } else search();
    }
    else {
      drive(dir+=270,59);
      if((range=scan(oang=ang,10))&&(range<808))
      {
         if (!scan(ang-=5, 5)) ang+=11;
         if (!scan(ang-=3, 2)) ang+=5;
         cannon(ang<<1-oang,scan(ang,10)<<1-range);
      } else search();
      drive(dir%=360,100);
    }
 }
}
