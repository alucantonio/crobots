/* DUMBNAME.R  */
/* D W Cooper - 3/19/86    Updated 3/20/86 */
main(){
  locked_on=0;
  x=dir=rand(360);
          d=1-2*(dir<270 && dir>90);
          e=1-2*(dir>180);
  while(1){
    drive(dir,100);
    if(loc_x()<100)if(d==-1)
    {
      drive(dir,50);
      dir=rand(178)+1;
      if(dir>89)dir+=180;
      while(speed()>50);
      drive(dir,100);
          d=1-2*(dir<270 && dir>90);
          e=1-2*(dir>180);
    }
    if(loc_x()>900)if(d==1){
      drive(dir,50);
      dir=rand(178)+91;
      while(speed()>50);
      drive(dir,100);
          d=1-2*(dir<270 && dir>90);
          e=1-2*(dir>180);
    }
    if(loc_y()<100)if(e==-1){
      drive(dir,50);
      dir=rand(178)+1;
      while(speed()>50);
      drive(dir,100);
          d=1-2*(dir<270 && dir>90);
          e=1-2*(dir>180);
    }
    if(loc_y()>900)if(e==1){
      drive(dir,50);
      dir=rand(178)+181;
      while(speed()>50);
      drive(dir,100);
          d=1-2*(dir<270 && dir>90);
          e=1-2*(dir>180);
    }
    if(locked_on)
    {
      f=18;
      while(range)
      {
        
        if (range=scan(x,g=f/2)) i=0;
        else if (range=scan(x+f,g)) i=f;
        else if (range=scan(x-f,g)) i=360-f;
        else
          {
            if(f==18)
               { x+=180;
                 locked_on=0; }
            range=f=0;
          }
        if(range>40)
        {
          cannon(x+i,range-(orange-range)/3);
          orange=range;
          x+=i;
          f/=3;
        }
      }
    }
    else
    {
      range=scan(x,10);
      if (range==0 || range>700) x+=20;
      else
       {
        locked_on=1;
        if((orange=range)>200)
        {
          drive(dir,50);
          while(speed()>50);
          drive(dir=x,100);
          d=1-2*(dir<270 && dir>90);
          e=1-2*(dir>180);
        }
      } 
    } 
  } 
}

