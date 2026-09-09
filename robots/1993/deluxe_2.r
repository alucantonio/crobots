/*********************************************************************/
/*                                                                   */
/*      Nome robot:     DELUXE_2                                     */
/*      Autore:         GIANNI PERUGINI                              */
/*                                                                   */
/*********************************************************************/

int count, ang, dam, dir, oldrange1, oldrange2, oldrange3, beta, betam;
main()
{
    beta=5;
    betam=5;
    drive(0,100);               /*  Va verso il muro EST sparando   */
    while(loc_x()<900)
        spara();
    while(1)
    {   
        count=0;
        dam=damage();
        while( ( ++count < 6 ) && ( (damage()-dam) < 25 ) )
        {
            drive(90, 0);       /*  Va verso il muro NORD sparando  */
            betam=atan(100000*(979-loc_x())/500);
            dir=90;
            while(speed()>49)
                spara();
            drive(90, 100);
            while(loc_y()<900)
                spara();
            drive(270, 0);      /*  Va verso il muro SUD sparando   */
            dir=270;
            while(speed()>49)
                spara();
            drive(270, 100);
            while(loc_y()>100)
                spara();
        }
        count=0;
        dam=damage();
        while( ( ++count < 6 ) && ( (damage()-dam) < 25 ) )
        {
            drive(180, 0);      /*  Va verso il muro OVEST sparando */
            betam=atan(100000*(loc_y()-20)/500);
            dir=180;
            while(speed()>49)
                spara();
            drive(180, 100);
            while(loc_x()>100)
                spara();
            drive(0,0);         /*  Va verso il muro EST sparando   */
            dir=0;
            while(speed()>49)
                spara();
            drive(0,100);
            while(loc_x()<900)
                spara();
        }
    }
}

spara()
{
    int range1,range2,alfa;
    if(dir==90||dir==0)
        alfa=360-beta;
    else
        alfa=beta;
    if(range1=scan(dir+alfa,10))        /*  Se c'Š un robot di fronte..     */
    {
        if(range1<oldrange1)            /*  ..spara..                       */
            cannon(dir+alfa,7*range1/8);
        else
            cannon(dir+alfa,7*range1/6);
        oldrange1=range1;
        beta=betam-range1*betam/1000;
    }
    if(range2=scan(540+dir-alfa,10))    /*  Se c'Š un robot alle spalle..   */
    {
        if(range2>oldrange2)            /*  ..spara..                       */
            cannon(540+dir-alfa,7*range2/6);
        else
            cannon(540+dir-alfa,7*range2/8);
        oldrange2=range2;
        beta=betam-range2*betam/1000;
    }
    if( !range1 && !range2 )            /*  ..altrimenti spara agli         */
    {                                   /*  eventuali robot che non si      */
        ang-=15;                        /*  trovano lungo i bordi.          */
        while(!(range1=scan(ang,10)) )
            ang+=20;
        if(range1>oldrange3)
            cannon(ang,7*range1/6);
        else
            cannon(ang,7*range1/8);
        oldrange3=range1;
    } 
}
