/* C-bots Tournament 3rd place: Hitnrun.r */


/*
 *      hitnrun.r
 *
 * Use atan() to calculate scan resolution and increments so ranges scale.
 * Stay near center to avoid damage from hitting walls.  Unfortunately,
 * this means we get shot at more.  It would be nice to stay outside and avoid
 * walls, too.  If target's range changes, attempt to lead it.  This is easy.
 * I haven't figured out an easy way to lead targets angle-wise yet.
 * Attempt to compensate for our movement when firing.  This is because the
 * missles don't get our velocity added in with theirs, i.e. they go to the
 * same place whether or not we are moving.  However, if another robot
 * continues to get scanned, it's probably moving at a similar speed and
 * heading.  So if we compensate for our motion, it gets hit more often.  This
 * is the weird trig in hit(), which breaks up our movement into radial and
 * angular adjustments for the args to cannon().  Stupid drive() bug doesn't
 * allow change in direction after you've collided.  First, drive(course, 0),
 * wait some (any conditional is long enough), then drive course(100).
 *
 */

/*
 *      hitnrun.r
 *
 * Weird trig splits our motion into radial and angular adjustments to
 * cannon().  Stupid drive() bug requires drive(course, 0) followed by
 * any conditional before calling drive(course, 100) after hitting a wall.
 * A few ideas were stolen from hitMan; the strange ones are probably mine.
 *      [12/18/89 efh]
 */

int     x, y;           /* current location */
int     angle, range;   /* target coordinates */
int     steps;          /* steps to travel */
int     course;         /* direction of travel */

main()
{
        int     i, wid;                 /* scan parameters */
        int     limit;                  /* scan limit */
        int     ndir;                   /* new course */

        ndir = -1;
        steps = 2;
        angle = 50;
        while (1) {
                if (steps != -1) {
                        if (range > 400)
                                ndir = angle;
                        else if ((x = loc_x()) < 200)
                                ndir = 0;
                        else if (x > 800)
                                ndir = 180;
                        else if ((y = loc_y()) < 200)
                                ndir = 90;
                        else if (y > 800)
                                ndir = 270;
                        else if (--steps <= 0 || speed() == 0)
                                ndir = rand(360);
                        if (ndir != -1) {
                                drive((course = ndir), 0);
                                while (speed() > 49)
                                        if (range >= 40)
                                                cannon(angle, range);
                                drive(course, 100);
                                steps = 2;
                                ndir = -1;
                        }
                } else
                        steps = 2;

                /* find target */
                limit = (angle -= 60) + 420;
                while (((range = scan((angle += 23), 10)) < 40 || range > 700)
&& angle <=
 limit);
                if (angle <= limit) {
                        if (range < 200) {      /* hit now */
                                cannon(angle, range);
                                track(200);
                        } else {                /* zero in and hit */
                                limit = (angle -= 15) + 40;
                                i = (wid = atan(3200000 / range)) * 2;
                                while (((range = scan((angle += i), wid)) < 40
|| range > 700) && angle <=
 limit);
                                if (angle <= limit) {
                                        cannon(angle, range);
                                        if (range <= 400)
                                                track(400);
                                        else
                                                track(700);
                                }
                        }
                }
        }
}

track(d)                        /* track target */
int     d;
{
        int     w, inc;

        hit(d, (w = atan(3200000 / range)));
        if ((range = scan((angle += (inc = w * 2)), w)) > d || range < 40) {
                if ((range = scan((angle += ((inc = -inc) * 2)), w)) > d ||
range < 40)
                        return;
        }
        cannon(angle, range);
        hit(d, w);
        while ((range = scan((angle += inc), w)) <= d && range >= 40) {
                cannon(angle, range);
                hit(d, w);
        }
}

hit(maxr, res)                  /* bash target */
int     maxr, res;
{
        int     dif, last;
        int     cangle;                 /* cannon angle */
        int     aa, ra;                 /* angle and range adjustment */

        ra = cos(dif = (course - angle)) / 2381;
        cangle = (aa = atan((sin(dif) * 42) / (last = range))) + angle;
        while ((range = scan(angle, res)) <= maxr && range >= 40) {
                cannon(cangle, (last = (range += (range - last))) + ra);
                if (speed() == 0) {             /* keep moving */
                        drive((course += 180), 0);
                        cangle = angle + (aa *= -1);
                        drive(course, 100);
                        ra *= (steps = -1);
                }
        }
        if (speed() == 0) {
                drive((course += 180), 0);
                if (steps = -1);        /* damn bug in drive() */
                drive(course, 100);
        }
}


