/*  WIZARD.R  by John Smolin (JS090186 at AFEHQVM2)   */
/*  Counts the enemies to decide what to do   */
int x,count,change,dam;
int orange,ox,dir,range,rlead,laps;
main()
{
 drive(0+180*(loc_x()>500),100);  /*  Get Moving  */
 change=90;
 x=-19;  /* Start scan at -19 instead of 0 to help avoid due-East error */
 while(x<360) count+=(scan(x+=19,10)!=0);  /* Scan all the way around, counting */
 if(count<2) leader(); /* Be leader if only one enemy */
 else { /* B4 Mode if more than one enemy */
  drive(270,100);  /* Head for south wall */
  dir=270;
  count=0;
  while(1)
  {

   /* Check for coming to corner */
   dir%=360;
   if((dir==90 && loc_y()>890) || (dir==270 && loc_y()<110)
       || (dir==360 && loc_x()>890) || (dir==180 && loc_x()<110))
   {   /* Change course at corner */
    drive(dir+=change,0);
    while(speed()>49);
    drive(dir,100);
   if(dir==90)
   {
     laps=0;
     while(laps<280) count+=(scan(laps+=19,10)!=0);
     if(count<2) leader();
     count=0;
   }
   }
   if(speed()<50) drive(dir,100); /* Stopped?  Well get moving! */
if(damage()>dam+7)
  { drive(dir+=180,0);
    while(speed()>49) dam=damage();
    drive(dir,100);
    change+=180;
   }
   if(range && range<701)  /* found a target? */
   {
    x+=5-(scan(x-5,5) != 0)*10;  /* Narrow down scan */
    x+=3-(scan(x-3,3) != 0)*6;
    orange=range;  /* Store old range */
    if ((range=scan(x,10))>40)	/* don't shoot yourself */
     /* Shoot the enemy, leading for range */
     cannon(x,range+(range-orange+cos(x-dir)/2000)*range/325);
    else cannon(x,50); /* Just shoot.  We lost him or he's too close */
   }
   else
    if (!(range=scan(x=dir-10,10)))    /* Scan in front */
     if(!(range=scan(x=dir+190,10)))  /* Behind */
      range=scan(x=rand(180)+dir,10); /* And randomly */
  }
 }
}

leader() /* Leader Mode */
{
 range=0;
 rlead=50;
  while(1)
  {
    x+=328;
    while(!(range=scan(x+=16,8)));
    cannon(x,range);
    if(range>200) drive(dir=x,100);
    while (range)  /* && range<700 */
    {
      if (range>200)
      {
	ox=x;
	orange=range;
	x+=4-(scan(x-4,4) != 0)*8;
	x+=2-(scan(x-2,2) != 0)*4;
	x+=1-(scan(x-1,1) != 0)*2;
	if (range=scan(x,10))
	  cannon(x+(x-ox)*range/200,range+(range-orange+rlead)*range/275);
	if (speed()<51 || ((x-dir)*(x-dir)>400))
	{
	  drive(dir=x,100);
	  rlead=25;
	}
	else rlead=50;
      }
      else
{      x+=20;
while(range<300)
      {
	x+=320;
	while(!(range=scan(x+=20,10)));
	cannon(x,range);
	if(speed()<50 || range>200) drive(dir=x,100);
      } }
    }
  }
}


