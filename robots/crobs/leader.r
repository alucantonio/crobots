/*  LEADER.R  by John Smolin  (JS090186 at AFEHQVM2)  */
/*  Leads the target so can kill things that move fast	*/
main() {
  int x,orange,ox,dir,range,rlead;
  drive(180*(loc_x()>500),100);
  x=336;
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

