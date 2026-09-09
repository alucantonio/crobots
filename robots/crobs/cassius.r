/****************CASSIUS CLAY by Stefano Calabro'*****************/
/*Cassius moves back and forth and changes his direction when hit*/


/*external variables*/
int course;
int dir, dist;

border()
  {
  if (loc_x()<100)
    {
    if ((course>90)&&(course<270))
      return(1);
    }
  else
    if (loc_x()>900)
      if ((course<90)||(course>270))
        return(1);
  if (loc_y()<100)
    {
    if (course>180)
      return(1);
    }
  else
    if (loc_y()>900)
      if (course<180)
        return(1);
  return(0);
  } /*end of border*/

fire()
  {
  if ( (dist=scan(dir,10)) )
    {
    cannon(dir,dist);
    dir-=10;
    }
  else
    dir+=10;
  }  /*end of fire*/

main()  
  {
  int d;
  
  d=0;
  course=0;
  
  while(1)
    {
    course=( course+178+5*(damage()-d) )%360;
    d=damage();
    while(!border())
      {
      drive(course,100);
      fire();
      }
    drive(0,0);
    while(speed()>49)
      fire();
    }
  }  /* end of main */ 
