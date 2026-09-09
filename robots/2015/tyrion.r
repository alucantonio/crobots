/**

Tyrion cerca di andare diritto per la sua strada, descrivendo un quadrato intorno all'arena.
Tyrion cambia anticipatamente direzione (+90 gradi) se lungo il suo cammino incontra un avversario.
(Tyrion e' piccolino, cerca di essere smart con i piu' grossi...)

Crobots     : Tyrion
Type        : Micro
Version     : 1.0
Author      : Maurizio Camangi
Begin       : 30-04-2015
Revision    : 19-10-2015

*/
int dir, ang, oang, range, orange, posx, posy, heading;

fire(dir)
{
  int asin,acos;
  
  if (speed()<100) drive(dir,100); else { if (scan(dir,10)) ang=dir; if (range>850) { ang+=120; } }
      
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

  ang-=220;
  search();
}

int look(a)
{
       if (range = scan(a,10))    ;
  else if (range = scan(a+=20,10));
  else return 0;
  ang=a;
  return range < 720;
}


wall()
int b;
{
    if (heading&1) b=loc_y(); else b=loc_x();
    if (heading&2) return b>180;   else return b<820;
}

stop() {
    drive(dir+=90, 0); ++heading; while(speed()>59); drive(dir, 100);
}

main()
{
    posy=loc_y(posx=loc_x()>499)>499;
    dir=90*(heading=(posy<<1)|(posx^posy));
    while(1) {
        if (wall()) {
            fire(dir);
            while ( speed()<100 ) {
                fire(dir);
            }
            if (look(dir)) {
                stop(fire(dir));
            }
        } else {
           stop();
        }
    }
}

