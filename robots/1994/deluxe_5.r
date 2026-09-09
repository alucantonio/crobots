/*********************************************************************/
/*                                                                   */
/*      Nome robot:     DELUXE_5                                     */
/*      Autore:         GIANNI PERUGINI                              */
/*                                                                   */
/*********************************************************************/

int ang,range,x,y,oldr,olda,oldx,oldy,newx,newy;
int destx,desty,pos,c1,c2,c3,c4;
main()
{
    int pos;
    ang=1000000;
    pos=0;
    goto(pos);
    while(1)
    {
        stop(); 
        if(c3>2)
            c4=2;
        else if(c3==2)
            c4=3;
        else if(damage()<80)
            c4=4;
        else
            c4=0;
        while(--c4)
            goto(++pos);
    }
}

goto(p)
int p;
{
    int dir;
    getdest(p);
    dir=arctan(destx-loc_x(),desty-loc_y());
    drive(dir,0);
    drive(dir,100);
    while( ((destx-loc_x())*(destx-loc_x())+(desty-loc_y())*(desty-loc_y()))>20000 )
        spara1();
    drive(dir,0);
    while(speed()>49)
        spara1();
}

stop()    
{
    int dam;
    dam=damage();
    c2=4;
    while( (damage()-dam)<10 && c2>2 )
    {
        c1=15;
        c2=0;
        dam=damage();
        while( --c1 )
            spara2();
    }
    c3=(damage()-dam)/5;
}

getdest(p)
int p;
{
    p%=8;
    if(p==0)
    {
        destx=300;
        desty=0;
    }
    else if(p==1)
    {
        destx=300;
        desty=1000;
    }
    else if(p==2)
    {
        destx=1000;
        desty=300;
    }
    else if(p==3)
    {
        destx=0;
        desty=300;
    }
    else if(p==4)
    {
        destx=700;
        desty=1000;
    }
    else if(p==5)
    {
        destx=700;
        desty=0;
    }
    else if(p==6)
    {
        destx=0;
        desty=700;
    }
    else if(p==7)
    {
        destx=1000;
        desty=700;
    }
}

spara1()
{
    ang-=34;
    while(!(range=scan(ang,8)))   
        ang+=15;
    ang+=4-8*(scan(ang-4,4)!=0);
    ang+=2-4*(scan(ang-2,2)!=0);  
    cannon(ang+8*(ang-olda)/10,2*range-oldr);      
    olda=ang;
    oldr=range;
}

spara2()
{
    ang+=326;
    while(!(range=scan(ang,8)))
        ang+=15;
    ang+=4-8*(scan(ang-4,4)!=0);
    ang+=2-4*(scan(ang-2,2)!=0);
    oldx=x;
    oldy=y;
    x=range*cos(ang)/100000;
    y=range*sin(ang)/100000;
    newx=(range+1250)*(x-oldx)/1200+x;
    newy=(range+1250)*(y-oldy)/1200+y;
    cannon(arctan(newx,newy),sqrt(newx*newx+newy*newy));  
    if(range<700)
        ++c2;
}

arctan(x,y)
int x, y;
{
    int d;
    if(x==0) 
        if(y>0)
            d=90;
        else
            d=270;
    else
        if (y < 0) 
            if (x>0)
                d=360+atan(100000*y/x);
            else
                d=180+atan(100000*y/x);
        else 
            if(x>0)
                d=atan(100000*y/x);
            else
                d=180+atan(100000*y/x);
    return(d);
}
