/**

Flash10 e' una buffa re-interpretazione di Jaja (Flash9): se incontra un nemico lungo
il suo cammino inizia a saltellare su e giu' lungo i bordi dell'arena, altrimenti
va diritto come tutti gli altri robot della generazione Flash.

Olga S

*/

int dir, deg, ang, oang, range, posx, posy, abra, bula, b;

main()
{
    posy=loc_y(posx=loc_x()>499)>499;
    if(posx) while(loc_x()<880) fire(0,  100);
    else     while(loc_x()>120) fire(180,100);
    if(posy) while(loc_y()<880) fire(90, 100);
    else     while(loc_y()>120) fire(270,100);
    fire(deg=90*(abra=(posy<<1)|(posx^posy)),0);
    while(1) {
        dir=deg;
        if (wall(abra)) {
            if (look(deg)) {
                fire(dir+=55, 100);
                while ( speed()<100 ) {
                    fire(dir, 100);
                }
                fire(dir-=110, 100);
                while(wall(abra+3)) {
                    fire(dir, 100);
                }
            } else {
                fire(dir, 100);
            }
        } else {
            fire(deg+=90, 0); ++abra;
        }
    }
}

fire(dir,v)
{
    drive(dir,v);
    if (range=scan(oang=ang,10))
    {
        if (scan(ang-8,5))
        {
            if (scan(ang-=5,2)) ;
            else ang-=4;
        }
        else
        {
            if (scan(ang+8,5))
            {
                if (scan(ang+=5,2)) ;
                else ang+=4;
            }
            else
            {
                if (scan(ang,1)) ;
                else if (scan(ang-=3,2)) ; else ang+=6;
            }
        }
        return(cannon((ang<<1)-oang,(scan(ang,10)<<1)-range));
    }
    else
    {
        if(range=scan(ang+=20,10))      cannon(ang,range);
        else if(range=scan(ang-=40,10)) cannon(ang,range);
        else if(range=scan(ang+=60,10)) cannon(ang,range);
        else if(range=scan(ang-=80,10)) cannon(ang,range);
        else ang+=120;
    }
}

int look(a)
{
       if (scan(a,10))    ;
  else if (scan(a+=20,10));
  else return 0;
  ang=a;
  return 1;
}

wall(a)
{
    if (a&1) b=loc_y();     else b=loc_x();
    if (a&2) return b>120;  else return b<880;
}
