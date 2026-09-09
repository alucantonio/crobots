/**
 * meeseeks1 by Emanuele Marsigliani
 * 
 * Il mio interesse per l'archeologia informatica mi ha fatto riscoprire questa "perla":
 * Mr. Meeseeks v1 non e' altro che la versione de-offuscata e ripulita di cooper1
 */
main()
{
    int flag, ang, oang, dir, posx, posy, offset, deg, range, orange;
    flag = 0;
    ang = dir = rand(360);
    posx=1-((dir < 270 & dir > 90)<<1);
    posy=1-((dir>180)<<1);
    while (1)
    {
        drive(dir, 100);
        if (loc_x() < 100)
            if (posx == -1)
            {
                drive(dir, 50);
                dir = rand(178) + 1;
                if (dir > 89)
                    dir += 180;
                while (speed() > 50)
                    ;
                drive(dir, 100);
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        if (loc_x() > 900)
            if (posx == 1)
            {
                drive(dir, 50);
                dir = rand(178) + 91;
                while (speed() > 50)
                    ;
                drive(dir, 100);
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        if (loc_y() < 100)
            if (posy == -1)
            {
                drive(dir, 50);
                dir = rand(178) + 1;
                while (speed() > 50)
                    ;
                drive(dir, 100);
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        if (loc_y() > 900)
            if (posy == 1)
            {
                drive(dir, 50);
                dir = rand(178) + 181;
                while (speed() > 50)
                    ;
                drive(dir, 100);
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        if (flag)
        {
            offset = 18;
            while (offset > 1)
            {
                deg = offset / 2;
                if (range = scan(ang, deg))
                    oang = 0;
                else if (range = scan(ang + offset, deg))
                    oang = offset;
                else if (range = scan(ang - offset, deg))
                    oang = 360 - offset;
                else
                {
                    if (offset == 18)
                    {
                        ang = (ang + 180) % 360;
                        flag = 0;
                    }
                    range = offset = 0;
                }
                if (range > 40)
                {
                    cannon(ang + oang, range - (orange - range) / 3);
                    orange = range;
                    ang = (ang + oang) % 360;
                    offset /= 3;
                }
            }
        }
        else
        {
            range = scan(ang, 10);
            if (range == 0 || range > 700)
                ang = (ang + 20) % 360;
            else
            {
                flag = 1;
                orange = range;
                if (range > 200)
                {
                    drive(dir, 50);
                    while (speed() > 50)
                        ;
                    drive(ang, 100);
                    dir = ang;
                    posx=1-((dir < 270 & dir > 90)<<1);
                    posy=1-((dir>180)<<1);
                }
            }
        }
    }
}