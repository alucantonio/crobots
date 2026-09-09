/* C-bots Tournament Winner: Seeker.r */

/*
  Seeker (Tournament Version)
  Chris Beauregard & Royce Vaughn Fay

  The tournament version of Seeker.  Most of the robots I've developed are
primarily designed with one-on-one battles in mind.  While they're still
very deadly in larger battles, this is where they excell.  Seeker has a
number of concepts built into it (like speed) which give it a lot more
oomph in larger fights (and smaller ones, incidently)

  What it does:  Basically, it runs back and forth across the field, and
slags anything else that moves. Non-mobile robots (those that slow down to
75% or less for any signifigant length of time, like say 100 cycles) have a
very limited lifespan against this thing, and faster robots just prolong the
experience.  The targetting routine has absolutely no trouble tracking a
robot moving a 100% (while we are too) and bombarding it with a phenomenal
rate of fire.  It's not all that accurate, but even with 1 in 10 shots even
causing damage, one-on-one battle rarely last to 50k cycles.  We're talking
about fast firing rate here.

  The speed part is accomplished by some really compact coding.  Everything
is in that one function (you might even rcognize chunks of T.P.'s course
plotting routine in there), and, well, look at the code, okay?  The
targetting routine might be barely recognizable as having been scrounged from
a certain P-Robot called Ninja2, and then hacked and twisted until it made
nice C code (or is 'nice' a bad word for that mess?)

  I have to put Royce Vaughn Fay down as a co-author of this program.  While
he's never seen the code or the program in action, most of the ideas we
developed jointly one late evening/early morning, and Shatter (Seeker's big
brother) was the top in a series of really kick-ass robots.  Generally
speaking, the theories behind the routines are his, and the coding is mine.
                                        Chris Beauregard
                                        Jan 23,1991
*/
/*-------------------------------------------------------------------------*/

main()
{
    int range,angle,tgx,tgy,sc,i,x,y,side;

    sc=rand(360);
    side=rand(2);
    while(1)
    {
        tgy=500+(((300+rand(100))*(((side==0)*(-1))+(side!=0))));
        tgx=50+rand(900);
        side=(side+1)%2;
        if(!(x=loc_x()-tgx))
        {
            if((y=loc_y()-tgy)<0)
                angle=90;
            else
                angle=270;
        }
        else if((y=loc_y()-tgy)>0)
        {
            if(x<0)
                 angle=360+atan((100000*y)/x);
            else
                 angle=180+atan((100000*y)/x);
        }
        else if(x<0)
            angle=atan((100000*y)/x);
        else
            angle=180+atan((100000*y)/x);
        sc%=360;
        i=10;
        while(speed()>=50);
        drive(angle,100);
        while((!speed())&&(--i));
        while((((x=loc_x()-tgx)*x)+((y=loc_y()-tgy)*y)>2500)&&(speed()))
        {
            if((range=scan(sc,10))>40)
                cannon(sc,range);
            else if((range=scan((sc+=20),10))>40)
                cannon(sc,range);
            else if((range=scan((sc+=320),10))>40)
                cannon(sc,range);
            else if((range=scan((sc+=200),10))>40)
                cannon(sc,range);
            else if((range=scan((sc+=20),10))>40)
                cannon(sc,range);
            else if((range=scan((sc+=320),10))>40)
                cannon(sc,range);
            else
                sc+=250;
        }
        drive(angle,40);
    }
}



