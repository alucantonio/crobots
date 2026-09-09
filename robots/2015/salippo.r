/**

Salippo e' un'altra buffa re-interpretazione di Jaja: come Flash9 ma con una diversa angolazione
nel movimento saltellante.

Olga S

*/

int dir, deg, ang, oang, range, posx, posy, abra, bula;

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

runX()
{
    dir=180*!posx;
    if(posx) while(loc_x()<880) fire(dir,100);
    else     while(loc_x()>120) fire(dir,100);
    fire(dir,0);
}

runY()
{
    dir=270-180*posy;
    if(posy) while(loc_y()<880) fire(dir,100);
    else     while(loc_y()>120) fire(dir,100);
    fire(dir,0);
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
int b;
{
    if (a&1) b=loc_y();     else b=loc_x();
    if (a&2) return b>120;  else return b<880;
}

main()
{
    posy=loc_y(posx=loc_x()>499)>499;
    if (posx^posy) runY(runX()); else runX(runY());
    deg=90*(abra=(posy<<1)|(posx^posy));
    while(1) {
        dir=deg;
        if (wall(abra)) {
            if (look(deg)) {
                fire(dir+=40, 100);
                while ( speed()<100 ) {
                    fire(dir, 100);
                }
                fire(dir-=130, 100);
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

