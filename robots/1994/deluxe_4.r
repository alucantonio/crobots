/*********************************************************************/
/*                                                                   */
/*      Nome robot:     DELUXE_4                                     */
/*      Autore:         GIANNI PERUGINI                              */
/*                                                                   */
/*********************************************************************/

int ang,range,x,y,oldx,oldy,newx,newy,locx,locy,olx,oly,alg,oldr;
main()
{
    int dam1,dam2;
    ang=1000000;
    alg=0;
    goto(0,0);
    goto(500,1000);
    goto(1000,0);
    goto(0,500);
    goto(1000,1000);
    dam1=test1();
    dam2=test2();
    if(dam1<=dam2)
        alg=0;
    while(1)
    {
        goto(0,0);
        goto(500,1000);
        goto(1000,0);
        goto(0,500);
        goto(1000,1000);
        goto(500,0);
        goto(0,1000);
        goto(1000,500);
    }
}

test1()
{
    int d;
    alg=0;
    d=damage();
    goto(500,0);
    goto(0,1000);
    goto(1000,500);
    return(damage()-d);
}

test2()
{
    int d;
    alg=1;
    d=damage();
    goto(500,250);
    return(damage()-d);
}

goto(x,y)
int x,y;
{
    int dir,vel;
    vel=100-80*alg;
    dir=arctan(x-loc_x(),y-loc_y());
    drive(dir,0);
    drive(dir,vel);  
    if(alg)
    {
        while( ((x-loc_x())*(x-loc_x())+(y-loc_y())*(y-loc_y()))>20000 )
            spara2();
        drive(dir,0);       
    }
    else
    {
        while( ((x-loc_x())*(x-loc_x())+(y-loc_y())*(y-loc_y()))>20000 )
            spara1();
        drive(dir,0);       
        while(speed()>49)   
            spara1();    
    }
}

spara1()
{
    ang+=324;
    while(!(range=scan(ang,10)))   
        ang+=18;
    cannon(ang,7*range/(8-2*(oldr<range)));      
    oldr=range;
}


spara2()
{
    ang+=328;
    olx=locx;
    oly=locy;
    while(!(range=scan(ang,8)))
        ang+=15;
    ang+=4-8*(scan(ang-4,4)!=0);    
    ang+=2-4*(scan(ang-2,2)!=0);    
    locx=loc_x();
    locy=loc_y();
    oldx=x;
    oldy=y;
    x=range*cos(ang)/100000;
    y=range*sin(ang)/100000;
    newx=range*(x+locx-oldx-olx)/1200+1250*(x-oldx)/1200+x;
    newy=range*(y+locy-oldy-oly)/1200+1250*(y-oldy)/1200+y;
    cannon(arctan(newx,newy),sqrt(newx*newx+newy*newy));
}

arctan(x,y)
int x, y;
{
    int d;
    if(x==0) 
    {
        if(y>0)
            d=90;
        else
            d=270;
    } 
    else
    {
        if (y < 0) 
        {
            if (x>0)
                d=360+atan(100000*y/x);
            else
                d=180+atan(100000*y/x);
        } 
        else 
        {
            if(x>0)
                d=atan(100000*y/x);
            else
                d=180+atan(100000*y/x);
        }
    }
    return(d);
}
