/*  YAL.R  by John Smolin  (JS090186 at AFEHQVM2)  */
/*  Yet Another Leader  */
/*  Leads the target so can kill things that move fast	*/
/*  Lead routine works in any direction (sort of)  */
main() {
 int x,orange,ox,dir,range;
if (loc_x()<500 && loc_y()<500) drive(45,100);
 else if (loc_x()<500 && loc_y()>500) drive(-45,100);
 else if (loc_y()<500) drive(135,100);
 else drive(225,100);
 while(1)
 {
  x+=328;
  while(!(range=scan(x+=16,10)));
    cannon(x,range);
    while (range)
    {
     orange=range;
     ox=x;
     x+=4-(scan(x-4,4) != 0)*8;
     x+=2-(scan(x-2,2) != 0)*4;
     x+=1-(scan(x-1,1) != 0)*2;
     if ((range=scan(x,10))>150)
     cannon(x+((x-ox)-sin(x-dir)/1/range)*range/205,
       range+(range-orange+cos(x-dir)/2000)*range/300);
     else cannon(x,(range-50)*(range>41)+50);
    if (loc_x()<100 || loc_x()>900 || loc_y()<100 || loc_y()>900)
      {  drive(0,0);
 while(speed()>50);
if (loc_x()<500 && loc_y()<500) drive(dir=45,100);
 else if (loc_x()<500 && loc_y()>500) drive(dir=315,100);
 else if (loc_y()<500) drive(dir=135,100);
 else drive(dir=225,100);
/*  if(range) range+=50; */
  }
    }
if (orange<300) x=dir+155;
 }
}


