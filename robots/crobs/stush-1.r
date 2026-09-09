/* C-bots Tournament 2nd place: Stush-1.r */


/*
 Move around like a bouncing ball at max. speed possible.
 Scan for targets. When a target is found, continually fire at
it. It if dissapears, scan to the left and right of last know location.
*/

main()
{
    int d,old;
    int x;
    int y;
    int flag;

    d=45;
    old=45;
    flag=1;

    while(1) {

        if (d!=old) {
            drive(d,49);
            old=d;
        }
        else drive(d,100);

        x=loc_x(); y=loc_y();

        if (x<100  && d==135) d=45;
        if (x<100  && d!=45)  d=315;

        if (x>900 && d==45)  d=135;
        if (x>900 && d!=135) d=225;

        if (y<100  && d==315) d=45;
        if (y<100  && d!=45)  d=135;

        if (y>900 && d==45)  d=315;
        if (y>900 && d!=315) d=225;

        if (flag) {
            if (s=scan(f,10)) cannon(f,s);
            else if (s=scan(f+20,10)) f+=20;
            else if (s=scan(f-20,10)) f-=20;
            else flag = 0;
            if (s=scan(f,10)) cannon(f,s);
        }
        else {
            f+=85;
            if (s=scan(f,10)) {
                cannon(f,s);
                flag=1;
            }
        }

    }

}


