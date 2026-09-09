int x,y,dam,current,cruise;

main()
{
        dam=0;
        x=loc_x();
        y=loc_y();
  while(1)
  {
        if (ouch())
                move();
        else
                rapidfire();
  }
}

int ouch()
{
        current=damage();
        if (current==dam)
                return(0);
        if (current==dam+2)
                { dam=current;
                return(1);}
        else {
                dam=current;
                return(1);
        }
}
move()
{
        x=loc_x;
        y=loc_y;
        if((x<=499) &&( y<=499)) {
                drive(rand(90),100);
                cruise=length();
                while((x+cruise>=loc_x()) && (y+cruise>=loc_y()))
                        drive(rand(90),50);
                drive(0,0);}
        if((x>499)&&(y<=499)){
                drive(rand(90)+270,100);
                cruise=length();
                while((x-cruise<=loc_x)&&(y+cruise>=loc_y))
                        drive(rand(90)+270,50);
                drive(0,0);}
        if((x>499)&&(y>499)){
                drive(rand(90)+180,100);
                cruise=length();
                while((x-cruise<=loc_x)&&(y-cruise<=loc_y))
                        drive(rand(90)+180,50);
                drive(0,0);}
        if((x<=499)&&(y>499)){
                drive(rand(90)+90,100);
                cruise=length();
                while((x+cruise>=loc_x)&&(y-cruise<=loc_y))
                        drive(rand(90)+90,50);
                drive(0,0);}
}

int length()
{
        return (cruise=rand(400));
}

rapidfire()
{   
     int   range=0;
        while(1){
        if (range<40)
                heading=rand(360);
        else
                cannon(heading,range);
        while((range=(scan(heading,5)))&&(range==0))
        {
        heading=heading+5;
        if (heading>360)
                heading=heading-360;
        if (ouch)
                return(0);
        }
        }
}

