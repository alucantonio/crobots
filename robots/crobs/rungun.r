/* C-bots Tournament 5th place: Rungun.r */

/*                               RUNGUN.R                             */

/* Stategy:  Go corner to corner at high speed while continually
*            scanning and shooting.  Simple but effective
*/

/*  Set Vars */

int angle, speed, degree;       /* drive & scan vars    */
int min, max;                   /* Hi & low Scan Values */
int corner;                     /* Current corner       */
int dis1, dis2;                 /* Distance from wall   */


/*                       M A I N   R O U T I N E                      */
main()
{

        go_corner();            /* Goto bottom left corner */
        corner=0;               /* initilize corner var    */

        while (1)               /* Begin infinite loop     */
        {
                next_corner();
                read_corner();
                        dis1=100;
                        dis2=900;
                        speed=100;
                          run_n_gun();
                        dis1=20;
                        dis2=979;
                        speed=10;
                          run_n_gun();
        }                       /* End Loop, Re-do          */

}                               /* End Main                 */

/*              S U B - R O U T I N E S                     */

go_corner()
{
        min=90;max=180;
        while (loc_y()>50)
        {
                drive (270,100);
                scan_shoot();
        }
        while (loc_y()>3)
        {
                drive (270,10);
                scan_shoot();
        }
        min=0;max=90;
        while (loc_x()>50)
        {
                drive (180,100);
                scan_shoot();
        }
        while (loc_x()>5)
        {
                drive (180,10);
                scan_shoot();
        }
        drive(90,100);
}

next_corner()
{
        if (corner == 4)
                corner =1;
        else
                corner +=1;
}

read_corner()
{
        if (corner == 1)
        {
                angle=90;
                  max=359;
                  min=270;
        }
        if (corner == 2)
        {
                angle=0;
                  max=359;
                  min=180;
        }
        if (corner == 3)
        {
                angle=270;
                  max=315;
                  min=45;
        }
        if (corner == 4)
        {
                angle=180;
                  max=315;
                  min=225;
        }
}

run_n_gun()
{
        while ((corner == 1) && (loc_y()<dis2))
        {
                drive (angle,speed);
                scan_shoot();
        }
        while ((corner == 2) && (loc_x()<dis2))
        {
                drive (angle,speed);
                scan_shoot();
        }
        while ((corner == 3) && (loc_y()>dis1))
        {
                drive (angle,speed);
                scan_shoot();
        }
        while ((corner == 4) && (loc_x()>dis1))
        {
                drive (angle,speed);
                scan_shoot();
        }
}

scan_shoot()
{
        while ((range=scan(degree,5))>0)
        {
                cannon(degree,range-20);
                cannon(degree,range-20);
                degree -= 2;
        }
        degree += 2;
        if (degree >= max)
                degree=min;


}


