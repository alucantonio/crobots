/*-------------------------------------------------------------------------*/
/*  Blade8.r                    Programmato da:  Ugolini Davide            */
/*                                                                         */
/*  Il robot si muove rimbalzando a 90 gradi                               */
/*  contro i lati in senso antiorario.                                     */
/*  Tra un rimbalzo e l'altro viene fatto uno                              */
/*  scan del bersaglio a 360 gradi utilizzando                             */
/*  una routine di fuoco chiamata fire().                                  */
/*  Durante lo spostamento se non subisce danni                            */
/*  si ferma facendo uno scan su 180 gradi e                               */
/*  utilizzando una routine di fuoco specifica                             */
/*  per ogni lato. Riparte dopo un damage().                               */
/*-------------------------------------------------------------------------*/

int rng,drv,dir,i,odm,o;

main() {
  
  if (loc_y()>500) {
     drive(90,100); while(loc_y()<900) fire();
     drive(90,0); while(speed()>45) fire();
     if (loc_x()>500) { drive(180,100); 
        while(loc_x()>500) fire();
        drive(180,0);}
     else { 
        drive(0,100); while(loc_x()<500) fire();
        drive(0,0);} drv=135; i=2; }
  else { 
     drive(270,100);while(loc_y()>100) fire();
     drive(270,0); while(speed()>45)  fire();
     if (loc_x()>500) { drive(180,100);
        while(loc_x()>500) fire();
        drive(180,0);}
     else { 
        drive(0,100); while(loc_x()<500) fire();
        drive(0,0);} drv=315; i=0; }

  while(1) { 

    drv+=90; i+=1; 
    while(speed()>45) fire();
    drive(drv,100); 
    odm=damage();

    if (i==1) {
       while(loc_x()<900) fire();    /*45*/
       drive(drv,0);if (damage()==odm) stop4();}
    else
    if (i==2) {
       while(loc_y()<900) fire();    /*135*/
       drive(drv,0);if (damage()==odm) stop1();} 
    else
    if (i==3) {
       while(loc_x()>100) fire();    /*225*/
       drive(drv,0);if (damage()==odm) stop2();} 
    else
    if (i==4) {
       while(loc_y()>100) fire();    /*315*/
       drive(drv,0);if (damage()==odm) stop3(); 
       i=0; }} 
}

stop1() {dir=180; odm=damage();
         while(damage()==odm){
         if (rng=scan(dir,8)) {
            if (rng>300) {
               if (rng>o) cannon(dir,rng+(rng-o)); 
               if (rng<o) cannon(dir,rng-(o-rng));
            } else cannon(dir,rng);
            o = rng;
            dir-= 60;}
         dir+=15; if (dir>359) dir=180;}}

stop2() {dir=270; odm=damage();
         while(damage()==odm){
         if (rng=scan(dir,8)) {
            if (rng>300) {
               if (rng>o) cannon(dir,rng+(rng-o)); 
               if (rng<o) cannon(dir,rng-(o-rng));
            } else cannon(dir,rng);
            o = rng;
            dir-= 60;}
         dir+=15; if (dir>450) dir=270;}}

stop3() {dir=0; odm=damage(); 
         while(damage()==odm){
         if (rng=scan(dir,8)) {
            if (rng>300) {
               if (rng>o) cannon(dir,rng+(rng-o)); 
               if (rng<o) cannon(dir,rng-(o-rng));
            } else cannon(dir,rng);
            o = rng;
            dir-= 60;}
         dir+=15; if (dir>180) dir=0;}}

stop4() {dir=90; odm=damage(); 
         while(damage()==odm){
         if (rng=scan(dir,8)) {
            if (rng>300) {
               if (rng>o) cannon(dir,rng+(rng-o)); 
               if (rng<o) cannon(dir,rng-(o-rng));
            } else cannon(dir,rng);
            o = rng;
            dir-= 60;}
         dir+=15; if (dir>270) dir=90;}}

fire() { dir+=20;
         if (rng=scan(dir,10)) {
            if (rng>300) {
               if (rng>o) cannon(dir,rng+(rng-o)); 
               if (rng<o) cannon(dir,rng-(o-rng));
            } else cannon(dir,rng);
            o = rng;
            dir+= 290;
         }
       }
