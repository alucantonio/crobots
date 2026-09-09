/* C-bots Tournament 9th place: Trial4.r */
int dest_x,dest_y,dam,dir,range,course,x,y,x1,y1;
main(){
        dam=0;
        dir=45;
        course=0;
        while(1){
                while(dam==damage())
                        do_a_scan();
                x1=loc_x();
                y1=loc_y();
                go();}}

do_a_scan(){
        while(dam==damage()){
                while((range=scan(dir,4))&&(dam==damage())){
                        if(range<40){
                                course=dir+180;
                                drive(course,100);

while(((range=scan(dir,4))<40)&&(dam==damage())){
                                        cannon(dir+3,40);
                                        cannon(dir-3,40);}
                                drive(course,0);}
                        else if(range>690){
                                drive(dir,100);

while(((range=scan(dir,4))>690)&&(dam==damage())){
                                        cannon(dir+1,700);
                                        cannon(dir-1,700);}
                                drive(dir,0);
                                course=dir;}
                        else {
                                cannon(dir,range);
                                x=range/200;
                                range+=10;
                                cannon(dir-2+x,range);
                                cannon(dir+2-x,range);}}
                x=0;
                while((dam==damage())&&(!scan(dir,4))){
                        x+=8;
                        if(scan(dir+x,4))
                                dir+=x;
                        else if(scan(dir-x,4))
                                dir-=x;}}
        if((dam+2)==damage()) dam+=2;}

go(){
        drive(course+180,100);
        plot_c2();
        y=course+90+rand(180);
        x=50+(rand(25)+1)*(11+rand(5));
        dest_x=x*cos(y)/100000;
        dest_y=x*sin(y)/100000;
        plot_course();
        drive(course,100);
        dam=damage();
        y=0;
        while(y<5){
                ++y;
                do_a_scan();}
        while(distance_sqr()>22500){
                if(dam-damage()){
                        dam+=2;
                        if(dam-damage()){
                                x1=loc_x();
                                y1=loc_y();
                                go();}}
                else
                        do_a_scan();}
        drive(course,0);}

distance_sqr(){
        x=loc_x()-dest_x;
        y=loc_y()-dest_y;
        return((x*x)+(y*y));}

plot_course(){
        x=x1-dest_x;
        y=y1-dest_y;
        if(!x){
                if(y<0)
                        course=90;
                else
                        course=270;}
        else{
                if(x<0)
                        course=(atan((100000*y)/x));
                else{
                        if(y>0)
                                course=180+atan((100000*y)/x);
                        else
                                course=180+atan((100000*y)/x);}}}

plot_c2(){
        x=x1-500;
        y=y1-500;
        if(!x){
                if(y<0)
                        course=90;
                else
                        course=270;}
        else{
                if(x<0)
                        course=(atan((100000*y)/x));
                else{
                        if(y>0)
                                course=180+atan((100000*y)/x);
                        else
                                course=180+atan((100000*y)/x);}}}


