/**
* JARVIS
* v.2.0
* Olga S
*
* JARVIS v2 è JARVIS del 2013 ovvero Rambo3, con delle diverse
* routine di fuoco: questa volta cercando di non schiantarsi sui muri (imbarazzante, eh).
*/

int range, angle, oangle;
int x,y,z;  /* x is loc_x(), y is loc_y(), z is direction */

main()
{

  while(loc_x()<205)
  {
    firevs(0);
  }
  stop(180);
  while(loc_x()>795)
  {
    firevs(180);
  }
  stop(90);
  while(loc_y()<255)
  {
    firevs(90);
  }
  stop(270);
  while(loc_y()>745)
  {
    firevs(270);
  }

  stop(z = 60); /*  start moving */

  while(1)  /* Main loop */
  {
    if(200>(x=loc_x()) || x>800)  /* bounce away from EAST/WEST walls */
    {
      drive((z=(540-z)%360),100);
      while(205>(x=loc_x()) || x>795)
      {
        firevs(z);
      }
    }

    firevs(z);

    if(250>(y=loc_y()) || y>750)  /* bounce away from NORTH/SOUTH walls */
    {
      drive(z=(360-z)%360,100);
      while(255>(y=loc_y()) || y>745)
      {
        firevs(z);
      }
    }

    if(speed()==0) firevs(z);  /* robot-robot collision recovery */

  }
}

stop(d)
{
int d;
   drive(d,0);
   if((range=scan(oangle=angle,10))&&(range<808))
   {
      if (scan(angle+350,10)) angle+=355; else angle+=5;
      if (scan(angle+350,10)) angle+=357; else angle+=3;
      return cannon(angle+(angle-oangle),2*scan(angle,10)-range);
   }
   else if(range=scan(angle-21,10)) cannon(angle-=21,range);
   else if(range=scan(angle+=21,10)) cannon(angle,range);
   else {while(!(range=scan(angle+=21,10)));}
   return cannon(angle,2*scan(angle,10)-range);
}

firevs(d)
{
int d;
   drive(d,100);
   if (range=scan(oangle=angle,10))
   {
      if(scan(angle-8,5)) {if(scan(angle-=5,2)); else angle-=4; return(cannon( (angle<<1)-oangle,(scan(angle,10)<<1)-range) );}
      else
      {
         if(scan(angle+8,5)) {if(scan(angle+=5,2)); else angle+=4; return(cannon( (angle<<1)-oangle,(scan(angle,10)<<1)-range) );}
         else
         {
            if (scan(angle,2))
            {
               if (scan(angle-=2,2)) return(cannon( (angle<<1)-oangle,(scan(angle,10)<<1)-range) );
               else return(cannon((angle+=4)+(angle-oangle), (angle<<1)-oangle,(scan(angle,10)<<1)-range) );
            }
            else if(range=scan(angle-21,10)) cannon(angle-=21,range);
            else {while (!(range=scan(angle+=21,10))); cannon(angle,range);}
            return cannon(angle,(scan(angle,10)<<1)-range);
         }
      }
   }
   else if(range=scan(angle-21,10)) cannon(angle-=21,range);
   else if(range=scan(angle+=21,10)) cannon(angle,range);
   else {while (!(range=scan(angle+=21,10))); cannon(angle,range);}
   return cannon(angle,(scan(angle,10)<<1)-range);
}
