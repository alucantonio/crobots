/* C-bots Tournament 4th place: Cruiser.r */


/* cruiser.r by Steve Patrick
 * Cruise around the world shooting at all */

int course;
int direction;
int range;
int ix;

main()
{
    course = 90 * rand(3);
    direction = course;
    ix = 10;
    while (1)
    {
        /* move */
        drive(course, 100);
        if ((course == 0) && (loc_x() > 800))
        {
            drive(0,0);
            cannon(315, 200);
            course = 90;
        }
        if ((course == 90) && (loc_y() > 800))
        {
            drive(90,0);
            cannon(45,200);
            course = 180;
        }
        if ((course == 180) && (loc_x() < 200))
        {
            drive(180,0);
            cannon(135,200);
            course = 270;
        }
        if ((course == 270) && (loc_y() < 200))
        {
            drive(270, 0);
            cannon(225,200);
            course = 0;
        }
        /* shoot*/
        if (range = scan(direction, ix))
        {
            cannon(direction + ix * (rand(3) - 1), range);
            if (ix > 1) ix /= 2;
            if ((course - direction) % 360 < 180) direction += ix;
            else direction -= ix;
        }
        else
        {
            direction += ix;
            ix *= 2;
            if (ix > 10)
            {
                ix = 10;
            }
        }
    }
}




