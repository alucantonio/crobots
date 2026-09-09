/*
  ========  VII  Torneo Crobots MCmicrocomputer 1997   =========
        
Robot : CARLO97.R
  
Autore:

  Luigi Cimini
  
SCHEDA TECNICA:

  Questo robot si muove velocemente lungo i lati di un piccolo quadrato
  sito nell`angolo S-E del campo di battaglia. La strategia difensiva si
  basa sul movimento e sul continuo cambiamento di direzione.

  L`attacco, che viene attivato solo nella fase finale del combattimento,
  e` basato su rapide oscillazioni casuali verticali e su una routine di
  fuoco, solo leggermente differente da quella usata nella prima fase.
  
SCELTA:

  Nel caso si rendesse necessario limitare i combattimenti ad un solo
  robot preferisco veder combattere ANDREA97.R

*/
  
int a,dd,dir,f,o,r,t,x,y,y1,y2;

main()
{
    a=100; r=60; o=60; t=240;                     /* ~450000 cicli */

    while(loc_x()>910) {drive(180,49); cerca();}
    while(loc_x()<930) {drive(0, 100); cerca();}  /* ---> */
    while(speed() >49) {drive(180, 0); cerca();}
    while(loc_y() <70) {drive(90, 49); cerca();}  /*     */ 

  while(--t)                                      /* quadrilatero */   
   {
    drive(270,100); while(loc_y() > 90) cerca();  /*     */
    drive(90,0);    while(speed() > 49) cerca();
    drive(180,100); while(loc_x() >815) cerca();  /* ó--- */
    drive(0,0);     while(speed() > 49) cerca();
    drive(90,100);  while(loc_y() <185) cerca();  /*     */
    drive(270,0);   while(speed() > 49) cerca();
    drive(0,100);   while(loc_x() <910) cerca();  /* ---> */
    drive(180,0);   while(speed() > 49) cerca();
   }
    dir=135; f=0;                                 /* attacco */
  while (1)
   {
    while(speed()<67) {drive(dir,100); cerca1();}
    dd=dir+180;
    while(speed()> 0) {drive(dd,   0); cerca1();}
    if(f=!f) dir=a+375; else dir=a+135;
    x=loc_x(); y=loc_y();                         /* evita muro */
    if ((x<167)||(x>833)||(y<167)||(y>833))
     {
      while (loc_x()<400) {drive(0,  100); cerca();} 
      while (loc_x()>600) {drive(180,100); cerca();} 
      while (speed()> 49) {drive(0,    0); cerca();}
      while (loc_y()<400) {drive(90, 100); cerca();} 
      while (loc_y()>600) {drive(270,100); cerca();} 
      while (speed()> 49) {drive(90,   0); cerca();}
     }
    y2=loc_y()+50; y1=y2-100;                     /* osc. rnd vert. */
    while(loc_y()<y2) {drive(90, 100); cerca1();}
    while(speed()>49) {drive(270,  0); cerca1();}
    while(loc_y()>y1) {drive(270,100); cerca1();}
    while(speed()>49) {drive(90,   0); cerca1();}
   }
}
spara()
{   
    if (scan(a+6,6)) a+=6; else a-=6;
    if (scan(a+3,3)) a+=3; else a-=3;
    r=scan(a,10); cannon(a,r+(r-o)*2);
}
cerca()
{
    if (o=scan(a,10)) spara();
    else if (o=scan(a-=20,10)) spara();
    else if (o=scan(a+=40,10)) spara();
    else a+=30;
    if (o>766) a+=30;
}
spara1()
{
    if (scan(a+6,6)) a+=6; else a-=6;
    if (scan(a+3,3)) a+=3; else a-=3;
    r=scan(a,10); cannon(a,r+r-o);
}
cerca1()
{
    if (o=scan(a,10)) spara();
    else if (o=scan(a-=20,10)) spara1();
    else if (o=scan(a+=40,10)) spara1();
    else a+=30;
    if (o>766) a+=30;
}
