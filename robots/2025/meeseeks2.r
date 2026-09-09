/**
 * meeseeks2 by Emanuele Marsigliani
 * 
 * Il mio interesse per l'archeologia informatica mi ha fatto riscoprire questa "perla":
 * Mr. Meeseeks v2 non e' altro che la versione de-offuscata e ripulita di cooper2
 */
main()
{
    int flag, oflag, ang, oang, dir, posx, posy, offset, deg, odeg, odeg2, range, orange;
    odeg = 20;
    flag = 0;
    ang = dir = rand(360);
    posx=1-((dir < 270 & dir > 90)<<1);
    posy=1-((dir>180)<<1);
    drive(dir, 100);
    while (1)
    {
        drive(dir, 100);
        if (loc_x() < 150)
            if (posx == -1)
            {
                drive(dir, 50);
                dir = rand(100) + 40;
                if (dir > 89)
                    dir += 180;
                while (speed() > 50)
                    drive(dir, 50);
                drive(dir, 100);
                oflag = 0;
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        if (loc_x() > 850)
            if (posx == 1)
            {
                drive(dir, 50);
                dir = rand(100) + 130;
                while (speed() > 50)
                    drive(dir, 50);
                drive(dir, 100);
                oflag = 0;
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        if (loc_y() < 150)
            if (posy == -1)
            {
                drive(dir, 50);
                dir = rand(100) + 40;
                while (speed() > 50)
                    drive(dir, 50);
                drive(dir, 100);
                oflag = 0;
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        if (loc_y() > 850)
            if (posy == 1)
            {
                drive(dir, 50);
                dir = rand(100) + 220;
                while (speed() > 50)
                    drive(dir, 50);
                drive(dir, 100);
                oflag = 0;
                posx=1-((dir < 270 & dir > 90)<<1);
                posy=1-((dir>180)<<1);
            }
        drive(dir, 100);
        if (flag)
        {
            offset = 10;
            while (offset > 3)
            {
                deg = offset / 2;
                if (range = scan(ang, deg))
                {
                    if (range < 120)
                    {
                        if (range > 20)
                        {
                            cannon(ang, range);
                            orange = range;
                        }
                    }
                    else
                        odeg2 = 0;
                }
                else if (range = scan(ang + offset, deg))
                {
                    if (range < 120)
                    {
                        if (range > 20)
                        {
                            cannon(ang + offset, range);
                            oang = ang = (ang + offset) % 360;
                            orange = range;
                        }
                    }
                    else
                        odeg2 = offset;
                }
                else if (range = scan(ang - offset, deg))
                {
                    if (range < 120)
                    {
                        if (range > 20)
                        {
                            cannon(ang - offset, range);
                            oang = ang = (ang + 360 - offset) % 360;
                            orange = range;
                        }
                    }
                    else
                        odeg2 = -offset;
                }
                else
                {
                    if (offset == 10)
                    {
                        oflag = flag = 0;
                        if (orange < 75)
                        {
                            ang = (oang + 180) % 360;
                            if (ang >=
                                    oang ||
                                ang < oang - 180)
                                odeg = 340;
                            else
                                odeg = 20;
                        }
                        else if (ang >=
                                     oang ||
                                 ang < oang - 180)
                            odeg = 20;
                        else
                            odeg = 340;
                    }
                    range = offset = 0;
                }
                if (range > 119)
                {
                    ang += odeg2;
                    if (range < 700)
                    {
                        cannon(ang - (oang - ang), range -
                                                          (orange - range) / 3);
                        oang = ang = (ang + 360) % 360;
                        orange = range;
                        oflag = 0;
                    }
                    else
                    {
                        if (!oflag)
                        {
                            drive(dir, 50);
                            while (speed() > 50)
                                drive(dir, 50);
                            drive(ang, 100);
                            oflag = 1;
                            offset = 0;
                            ang = (ang + 360) % 360;
                            dir = ang;
                            posx=1-((dir < 270 & dir > 90)<<1);
                            posy=1-((dir>180)<<1);
                        }
                    }
                }
                offset = (offset + 2) / 3;
            }
        }
        else
        {
            range = scan(ang, 10);
            if (range == 0 || range > 700)
                ang = (ang + odeg) % 360;
            else
            {
                oang = ang;
                orange = range;
                flag = 1;
                if (range > 400)
                {
                    drive(dir, 50);
                    while (speed() > 50)
                        drive(dir, 50);
                    drive(ang, 100);
                    dir = ang;
                    posx=1-((dir < 270 & dir > 90)<<1);
                    posy=1-((dir>180)<<1);
                }
            }
        }
    }
}