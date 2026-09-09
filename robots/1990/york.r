/*    YORK I  -  (C) 1991 Ettore De Simone       */

int place;
int c1x, c1y;
int c2x, c2y;
int c3x, c3y;
int c4x, c4y;
int c5x, c5y;
int c6x, c6y;
int c7x, c7y;
int c8x, c8y;
int s1, s2, s3, s4, s5, s6, s7, s8;
int d, dd;
int dir;
int ciclo;
int maxdam, maxcicli;


main()
{
    int closest;
    int range;

    c1x = 100; c1y = 100; s1 = 225;
    c2x = 100; c2y = 500; s2 = plot_course(0, 0);
    c3x = 100; c3y = 900; s3 = 135;
    c4x = 500; c4y = 100; s4 = plot_course(999, 0);
    c5x = 900; c5y = 900; s5 = 45;
    c6x = 500; c6y = 900; s6 = plot_course(0, 999);
    c7x = 900; c7y = 100; s7 = 315;
    c8x = 900; c8y = 500; s8 = plot_course(999, 999);
    closest = 9999;

    maxdam = 0;
    maxcicli = 5;

    d = 0; dd = 0;
    new_place();
    d = damage();
    dd = 2;

    while (1) {

        ciclo = 0;
        if (damage() > 50) {
            maxcicli = 10;
            maxdam = 1;
        }
        while (ciclo < maxcicli) { /* tot cicli di scan, poi lo va a cercare */
            range = cerca();
            if (d != damage())
                range = 0;      /* esce dal ciclo se colpito */
            while (range > 0) {
                closest = range;
                range = cerca();
                if (d != damage())
                    range = 0;      /* esce dal ciclo se colpito */
            }
            if (d != damage()) {    /* se colpito scappa */
                d = damage();
                ciclo = 0;
                ++dd;
                if (dd >= maxdam)
                    new_place();
            }
            ++ciclo;
        }

        if (closest == 9999)
            new_place();
        closest = 9999;
    }

}


cerca()
{
    int angle, dist, tgt;

    angle = dir;
    dist = 0;
    while (angle <= dir + 360) {
        dist = scan(angle, 10);
        if (dist > 0 && dist <= 700) {
            tgt = angle - 10;
            while (tgt <= angle + 10) {
                dist = scan(tgt, 2);
                if (dist > 0 && dist <= 700) {
                    if (dist > 40)
                        cannon(tgt, dist);
                    else
                        cannon(tgt, 45);    /* non spararsi addosso ! */
                    ciclo = 0;
                }
                tgt += 3;
            }
        }
        angle += 17;
        if (d != damage()) {
            d = damage();
            ++dd;
            if (dd >= maxdam) {
               new_place();
               angle = dir;
            }
        }
    }
    if (dist <= 700)
        return (dist);
    else
        return (0);
}

new_place()
{
    int x, y, angle, new, tgt, dist;

    new = rand(8);
    if (new == place)
        place = (new + 1) % 4;
    else
        place = new;
    if (place == 0) {
        x = c1x;
        y = c1y;
        dir = s1;
    }
    if (place == 1) {
        x = c2x;
        y = c2y;
        dir = s2;
    }
    if (place == 2) {
        x = c3x;
        y = c3y;
        dir = s3;
    }
    if (place == 3) {
        x = c4x;
        y = c4y;
        dir = s4;
    }
    if (place == 4) {
        x = c5x;
        y = c5y;
        dir = s5;
    }
    if (place == 5) {
        x = c6x;
        y = c6y;
        dir = s6;
    }
    if (place == 6) {
        x = c7x;
        y = c7y;
        dir = s7;
    }
    if (place == 7) {
        x = c8x;
        y = c8y;
        dir = s8;
    }
    angle = plot_course(x, y);
    drive(angle, 100);
    tgt = angle;
    while (distance(loc_x(), loc_y(), x, y) > 100 && speed() > 0) {
        dist = scan(tgt, 10);
        if (dist > 0 && dist <= 700) {
            if (dist > 40)
                cannon(tgt, dist);
            else
                cannon(tgt, 45);/* non spararsi addosso ! */
        }
        tgt += 18;
    }
    drive(angle, 0);
    d = damage();
    dd = 0;
    ciclo = 0;
}

distance(x1, y1, x2, y2)
    int x1;
    int y1;
    int x2;
    int y2;
{
    int x, y;

    x = x1 - x2;
    y = y1 - y2;
    d = sqrt((x * x) + (y * y));
    return (d);
}

plot_course(xx, yy)
    int xx, yy;
{
    int d;
    int x, y;
    int scale;
    int curx, cury;

    scale = 100000;
    curx = loc_x();
    cury = loc_y();
    x = curx - xx;
    y = cury - yy;

    if (x == 0) {
        if (yy > cury)
            d = 90;
        else
            d = 270;
    } else {
        if (yy < cury) {
            if (xx > curx)
                d = 360 + atan((scale * y) / x);
            else
                d = 180 + atan((scale * y) / x);
        } else {
            if (xx > curx)
                d = atan((scale * y) / x);
            else
                d = 180 + atan((scale * y) / x);
        }
    }
    return (d);
}
