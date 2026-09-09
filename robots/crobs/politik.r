/* This robot by Clay Risenhoover, Michael Hogan, and Tareq Hasan*/
/* Any resemblance to any politicians, living or dead, is strictly */
/* coincidental. */

/* This robot is named after a politician and follows the first
   rule of politics: If something doesn't work, change your mind
   at your earliest possible convenience.  The robot follws a
   kinder, gentler algorithm at first, driving along and scanning for
   other robots while firing wildly, then, later in the match, it
   becomes more agressive, choosing to track and kill individual
   robots.

   All code is obfuscated to protect the national security
   interests of the team members.
*/

int a,r;
int bubba, angle;
int x,ox, orange,husker,falcon,pinto,castle;
int d;
int x,hoosier,ox,husker,angle,pinto;

main() {

   wildman();
   d = damage();
   drive(husker=90+180*(loc_y()>500),100);
   wildman();
   x=-10;
   wildman();
   while(1) {
     if(d < 70)
     {
       castle=0;
       falcon=4;
       while(angle<300)
       {
         x+=320;
         while(0==(angle=scan(x+=20,10)));
         cannon(x+castle,angle);
         if(speed()<51)
           drive(husker=x+290+angle/(castle=5),100);
         if(++falcon>6)
           drive(husker,falcon=0); }

         if(speed()<51)
           drive(husker=x,100);

         while(angle>200)
         {
           hoosier=angle;
           ox=x;

           if(scan(x-4,4))
             x-=4;
           else
             x+=4;

           if(scan(x-2,2))
             x-=2;
           else
             x+=2;
           if(scan(x-1,1))
             x-=1;
           else
             x+=1;
           if(angle=scan(x,10))
             cannon(x+(x-ox)*angle/200,angle+(angle-hoosier+pinto)*angle/275);
           if(speed()<51 || (x-husker)*(x-husker)>400) {
             drive(husker=x,100);
           pinto=25;
           wildman();
         }
         else pinto=50;
       }
     }
   }

   if(d > 85)
   bobdole();


   if(d > 69)
   johnmadden();
}



johnmadden()
{
  int x, y;
  y= damage();
  
  bubba = 90;
  drive(bubba,100);
  while(1) {
  x = damage();
  while ((scan(bubba,10)) > 0)
  {
    angle=scan(bubba,10);
               
    if (angle>10)
    {
      wildman();
    }
           

    if(speed()<51)
      drive(husker=x+290+angle/(castle=5),100);
    if(speed()<51)
      drive(husker=x,100);

  }
  if(scan(bubba, 10) > 0 )
     napalm();
  if(x > y)
  {
    napalm();
    y = x;
  }

  bubba += 20;
  bubba %= 360;
  }

}

wildman()
{
    if (r = scan(a,2)) cannon(a, r); else {a -= 4; if (a < 4) a = 180;}
}

napalm()
{
int zorak;

     while(1){
     zorak = rand(100);
                angle=scan(bubba,10);
                drive(bubba-=180,zorak);
                if (angle>10)
                {
                 angle = 999;
    
                 cannon(bubba-250,angle);
                 cannon(bubba-215,angle);
                 cannon(bubba-180,angle);
                 cannon(bubba-145,angle);
                 cannon(bubba-115,angle);
                 cannon(bubba-90,angle);
                 cannon(bubba-75,angle);
                 cannon(bubba-60,angle);
                 cannon(bubba-30,angle);
                 cannon(bubba-15,angle);
                 cannon(bubba, angle);
                 cannon(bubba+15, angle);
                 cannon(bubba+30,angle);
                 cannon(bubba+60,angle);
                 cannon(bubba+75,angle);
                 cannon(bubba+90,angle);
                 cannon(bubba+115, angle);
                 cannon(bubba+145, angle);
                 cannon(bubba+180,angle);
                 cannon(bubba+215,angle);
                 cannon(bubba+250,angle);
                
    }
    bubba += 20;
    bubba %= 360;
    wildman();
    }
  }

bobdole() {
  
  drive(180*(loc_x()>500),100);
  x=336;
  pinto=50;
  while(1)
  {
    x+=328;
    while(!(angle=scan(x+=16,8)));
    cannon(x,angle);
    if(angle>200) drive(husker=x,100);
    while (angle)  /* && angle<700 */
    {
      if (angle>200)
      {
        ox=x;
        hoosier=angle;
        x+=4-(scan(x-4,4) != 0)*8;
        x+=2-(scan(x-2,2) != 0)*4;
        x+=1-(scan(x-1,1) != 0)*2;
        if (angle=scan(x,10))
          cannon(x+(x-ox)*angle/200,angle+(angle-hoosier+pinto)*angle/275);
        if (speed()<51 || ((x-husker)*(x-husker)>400))
        {
          drive(husker=x,100);
          pinto=25;
        }
        else pinto=50;
      }
      else
{      x+=20;
while(angle<300)
      {
        x+=320;
        while(!(angle=scan(x+=20,10)));
        cannon(x,angle);
        if(speed()<50 || angle>200) drive(husker=x,100);
      } }
    }
  }
}