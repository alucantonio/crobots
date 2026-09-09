/*  B4	 by John Smolin  (JS090186 at AFEHQVM2)   */
/*  Drives around the outside of the screen, and shoots, leading for range  */
/*  Looks in front, behind, and once randomly  */
main()
int x,range,orange,dir,change,dam;
{
drive(270,100);
dir=270;
change=90;
while(1)
{
dir%=360;
if((dir==90 && loc_y()>890) || (dir==270 && loc_y()<110)
   || (dir==360 && loc_x()>890) || (dir==180 && loc_x()<110))
  { drive(dir+=change,0);
    while(speed()>49);
    drive(dir,100);
  }
if(speed()<50) drive(dir,100);
if(damage()>dam+7)
  { drive(dir+=180,0);
    while(speed()>49) dam=damage();
    drive(dir,100);
    change+=180;
   }
if(range && range<701)
  {
   x+=5-(scan(x-5,5) != 0)*10;
   x+=3-(scan(x-3,3) != 0)*6;
   orange=range;
   if ((range=scan(x,10))>40)
 cannon(x,range+(range-orange+cos(x-dir)/2000)*range/325);
		 else cannon(x,50);
    }
 else
if (!(range=scan(x=dir-10,10)))
     if(!(range=scan(x=dir+190,10)))
       range=scan(x=rand(180)+dir,10);
} }

