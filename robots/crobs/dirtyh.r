

int dam;
int current;

main()
{

        dam=0;
  while(1)
  {
        current=damage();
        if (current>dam) {
                move();
           
                dam = current; }
        else
                rapid();
  }
}

move()
{       int think;
        int x;
        int y;

        x = loc_x();
        y = loc_y();
        
        think = 0;
        if (( x<500 ) && (y < 500)) {
                drive(rand(90),100);
                while(think<50)
                        think++;   }
        else if (( x < 500 ) && (y>499)) {
                drive((rand(90)+270),100);
                while(think<50)
                        think++; }
        else if ((x>499) && (y<500)) {
                drive((rand(90)+90),100);
                while(think<50)
                        think++; }
        else if ((x>499) && (y>499)) {
                drive((rand(90)+180),100);
                while(think<50)
                        think++; }
drive(0,0);
}

rapid()
{
     int   range;
     int   bordum;
     int   dam2;
     int   heading;
     int   current2;

        range=0;
        bordum=0;
        dam2=damage();
        while(1){
           if (bordum>10){
                bordum=0;
                move();
    
           }
           if (range<40)
                heading=rand(360);
           else  {
                bordum++;
                cannon(heading,range); }
           while((range=(scan(heading,5)))&&(range==0))
           {
           heading=heading+5;
           if (heading>360)
                heading=heading-360;
           current2=damage();
           if (dam2!=current2)  {
                move();

                return; }
           bordum++;
        }
        current2=damage();
        if (dam2!=current2){
                move();
                return;    }
}
}
