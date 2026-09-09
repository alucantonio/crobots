/*

Crobots  : Kerberos
Version  : 1.0
Type     : Micro
Author   : Olga S

Kerberos è una rivisitazione di Tobey (2007) con differenti routine di movimento e sparo.

*/

int range,dir,ang;


find()
{
  if(scan(ang-13,10)) ang-=5;
  else if(scan(ang+13,10)) ang+=5;
  if(scan(ang+12,10)) ang+=4;
  else if(scan(ang-12,10)) ang-=4;
  if(scan(ang-11,10)) ang-=2;
  if(scan(ang+11,10)) ang+=2;
}

search()
{
  if (range=scan(ang+=350,10)) return cannon(ang,range);
  if (range=scan(ang+=20,10))  return cannon(ang,range);
  if (range=scan(ang+=320,10)) return cannon(ang,range);
  if (range=scan(ang+=60,10))  return cannon(ang,range);
  if (range=scan(ang+=280,10)) return cannon(ang,range);

  search(ang-=220);
}

main()
{
  int asin, acos, safe, posx, posy, l, x, oang, orange, param1, param2;
  param1=375*(posx=loc_x()>499);
  param2=375*(posy=loc_y()>499);
  drive(dir=90*((posy<<1)|(posx^posy)),100);
  while(1) {
    if(dir&320) { l=loc_y(x=param2); } else { l=loc_x(x=param1); }
    if(dir&384) { safe=l>(x+200); } else { safe=(x+425)>l; }

    if (safe) {
        if (speed()<100) drive(dir,100); else { if (range=scan(dir,10)) ang=dir; if (range>850) { ang+=120; } }
        if (scan(ang,10)) {  
                asin=(sin(ang-dir)/14384); 
                acos=(cos(ang-dir)/3796)-230;

                find();
                if (orange=scan(oang=ang,3)) {
                        find();
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
