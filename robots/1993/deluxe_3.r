/*********************************************************************/
/*                                                                   */
/*      Nome robot:     DELUXE_3                                     */
/*      Autore:         GIANNI PERUGINI                              */
/*                                                                   */
/*********************************************************************/

int dir,ang,oldrange;
main()
{
    dir=atan(100000*loc_y()/loc_x())+180;
    while(speed()<50)               /*  Va verso il punto di coordinate */
        drive(dir,100);             /*  (0,0) sparando.                 */
    while((loc_x()>100)&&(loc_y()>100))
        spara();
    while(1)
    {
        dir=atan(100000*(500-loc_y())/(900-loc_x()));
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (900,500) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_x()<900)
            spara();
        dir=atan(100000*(900-loc_y())/(100-loc_x()))+180;
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (100,900) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_x()>100)
            spara();
        dir=atan(100000*(100-loc_y())/(500-loc_x()))+360;
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (500,100) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_y()>100) 
            spara();
        dir=atan(100000*(900-loc_y())/(900-loc_x()));
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (900,900) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_y()<900)
            spara();
        dir=atan(100000*(500-loc_y())/(100-loc_x()))+180;
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (100,500) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_x()>100)
            spara();
        dir=atan(100000*(100-loc_y())/(900-loc_x()))+360;
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (900,100) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_x()<900)
            spara();
        dir=atan(100000*(900-loc_y())/(500-loc_x()))+180;
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (500,900) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_y()<900)
            spara();
        dir=atan(100000*(100-loc_y())/(100-loc_x()))+180;
        drive(dir,0);               /*  Va verso il punto di coordinate */
        while(speed()>49)           /*  (100,100) sparando.             */
            spara();
        while(speed()<50)
            drive(dir,100);
        while(loc_y()>100)
            spara();
    }
}

spara()
{
    int range;
    ang-=15;
    while(!(range=scan(ang,10)))    /*  Fino a che non trova un robot.. */
        ang+=20;                    /*  .. incrementa l'angolo di scan. */ 
    if(range<oldrange)              /*  Se il robot si Š avvicinato..   */
        cannon(ang,7*range/8);      /*  .. spara con range minore..     */ 
    else                            /*  .. altrimenti..                 */
        cannon(ang,7*range/6);      /*  .. spara con range maggiore.    */
    oldrange=range;                 /*  Memorizza l'attuale range.      */
}
