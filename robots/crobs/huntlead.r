/* HUNTLEAD.R  by Terry Donahue (TERENCE at YKTVMH)		 */
/* leads target when far away, spirals around target when close  */
main() {
   int x,ox,range,orange,dir,count,rlead,cor;
   drive(dir=90+180*(loc_y()>500),100);
   x=-10;
   while(1) {
      cor=0;
      count=4;
      while(range<300) {
	 x+=320;
	 while(0==(range=scan(x+=20,10)));
	 cannon(x+cor,range);
	 if(speed()<51) drive(dir=x+290+range/(cor=5),100);
	 if(++count>6) drive(dir,count=0); }
      if(speed()<51) drive(dir=x,100);
      while(range>200) {
	 orange=range;
	 ox=x;
	 if(scan(x-4,4)) x-=4; else x+=4;
	 if(scan(x-2,2)) x-=2; else x+=2;
	 if(scan(x-1,1)) x-=1; else x+=1;
	 if(range=scan(x,10))
	    cannon(x+(x-ox)*range/200,range+(range-orange+rlead)*range/275);
	 if(speed()<51 || (x-dir)*(x-dir)>400) {
	    drive(dir=x,100);
	    rlead=25; }
	 else rlead=50; } } }
