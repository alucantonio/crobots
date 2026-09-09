/*  SPOT.R  Based on most highly optimized GRUNT code */
/*  by John Smolin (JS090186 at AFEHQVM2)  */
/*  GRUNT by R. Polo  */
main()
{
int range,x;
x=350;
while(1)
{
while(!(range=scan(x+=20,10)));
cannon(x,range);
if (speed()<50 || range>200) drive(x,100);
x+=320;
} }

