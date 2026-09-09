/*  Grunt, optimized by JS   */
/*  originally by R. Polo   */
main()
{
int range,x;
while(1)
   {
   if (scan(x,10)!=0)
      {
x+=5-(scan(x-5,5) != 0)*10;
x+=3-(scan(x-3,3) != 0)*6;
if ((range=scan(x,10))>20)
   {
   cannon(x,range);
   if (range>200)
      drive(x,50);
     else
      drive(180-x,0);
   }
      x-=20;
      }
    else
      x+=20;
   }
}
