/*  LEADER.R  by John Smolin  (JS090186 at AFEHQVM2)  */
/*  Leads the target so can kill things that move fast	*/
main() {
 int x,orange,ox,dir,range;
  x=8;
 while(1)
 {
x+=328;
while(!(range=scan(x+=16,8)));
if (range<200) cannon(x,range);
else {
     drive(x,100);
     ox=x;
     orange=range;
     x+=(scan(x+4,4) != 0)*8-4;
     x+=2-(scan(x-2,2) != 0)*4;
     x+=1-(scan(x-1,1) != 0)*2;
     if (range=scan(x,10))
 cannon(x+(x-ox)*range/200,range+(range-orange+50)*range/275);
}
if (speed()<51) drive(x,100);
} }

