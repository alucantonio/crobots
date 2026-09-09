/*----------------------------------------------------------------------------

  Nome         :  Gundam (29-09-1997)              \         /
                                                    \ __^__ /
  Autori       :  Luca Pranzo                       / \   / \
                  Marco Pranzo                     ³    V    ³
                                                  ³±³ßßß ßßß³±³
                                                  ³±³  ÍÍÍ  ³±³
                                                   ÀÄ\ ßÛß /ÄÙ
                                                      \ _ /


------------------------------------------------------------------------------
 Costruito in analogia ad Arale, Gundam Š stato creato per difendere la Terra
 dagli altri  Robot  cattivi!!!  Si piazza nell'angolo pi— vicino e l inizia 
 ad  oscillare.  Rimane in tale posizione  fino a 100000 cicli  dopo i  quali 
 utilizza il suo attacco segreto percorrendo una traiettoria a rombo sparando 
 a destra  e manca.  Le routine di sparo  e la struttura  del programma  sono 
 simili  ad  Arale  da  cui  differisce  per  l'angolo  di  oscillazione e la
 strategia finale.
----------------------------------------------------------------------------*/

int
 posy,
 timer,
 d,ang;

main()
{ 
 timer=100;
 posy=loc_y();
 if (loc_x() > 500) if (posy > 500)
  { 
   /* Posizionamento angolo Nord-Est */
   drive(90,100); while (loc_y()<930) attack();
   drive(90,0); quick_fire();
   drive(0,100); while (loc_x()<930) attack();
   drive(0,0); quick_fire();
   /* Pendolo Nord-Est */
   while (timer-=1) {
                        drive(225,100);
                        while((loc_y() > 850)&&(loc_x() > 850)) attack();
                        drive(225,0);
                        quick_fire();
                        drive(45,100);
                        while((loc_y() < 930)&&(loc_x() < 930)) attack();
                        drive(45,0);
                        quick_fire(); 
                      }
   /* Posizionamento finale */
   drive(180,100);
   while (loc_x() > 520) attack();
   drive(180,0);
   quick_fire();
  }
  else 
  { 
   /* Posizionamento angolo Sud-Est */
   drive(0,100); while (loc_x()<930) attack();
   drive(0,0); quick_fire();
   drive(270,100); while (loc_y()>70) attack();
   drive(0,0); quick_fire();
   /* Pendolo Sud-Est */
   while (timer-=1) { 
                     drive(135,100);
                     while((loc_y() < 150)&&(loc_x() > 850)) attack();
                     drive(135,0);
                     quick_fire();
                     drive(315,100);
                     while((loc_y() > 70)&&(loc_x() < 930)) attack();
                     drive(315,0);
                     quick_fire(); 
                    }
   /* Posizionamento finale */
   drive(90,100);
   while (loc_y() < 480) attack();
   drive(90,0);
   quick_fire();
   drive(135,100);
   while (loc_y() < 950) attack();
   drive(135,0);
   quick_fire();
  }
  else if (posy > 500)
  {
   /* Posizionamento angolo Nord-Ovest */
   drive(180,100); while (loc_x()>70) attack();
   drive(180,0); quick_fire();
   drive(90,100); while (loc_y()<930) attack();
   drive(0,0); quick_fire();
   /* Pendolo Nord-Ovest */
   while (timer-=1) {
                     drive(315,100);
                     while((loc_y() > 850)&&(loc_x() < 150)) attack();
                     drive(315,0);
                     quick_fire();
                     drive(135,100);
                     while((loc_y() < 930)&&(loc_x() > 70)) attack();
                     drive(135,0);
                     quick_fire(); 
                    }
   /* Posizionamento finale */
   drive(0,100);
   while (loc_x() < 480) attack();
   drive(0,0);
   quick_fire();
  }
  else
  {
   /* Posizionamento angolo Sud-Ovest */
   drive(270,100); while (loc_y()>70) attack();
   drive(270,0); quick_fire();
   drive(180,100); while (loc_x()>70) attack();
   drive(0,0); quick_fire();
   /* Pendolo Sud-Ovest */
   while (timer-=1) {
                     drive(45,100);
                     while((loc_y() < 150)&&(loc_x() < 150)) attack();
                     drive(45,0);
                     quick_fire();
                     drive(225,100);
                     while((loc_y() >  70)&&(loc_x() > 70)) attack();
                     drive(225,0);
                     quick_fire(); 
                    }
   /* Posizionamento finale */
   drive(90,100);
   while (loc_y() < 480) attack();
   drive(90,0);
   quick_fire();
   drive(45,100);
   while (loc_y() < 950) attack();
   drive(45,0);
   quick_fire();
  }
/* Traiettoria a rombo (senso orario) */
 while(1)   
  {
   drive(315,100); while(loc_x()<900) attack();   
   drive(315,0);   quick_fire();
   drive(225,100); while(loc_y()>100) attack();
   drive(225,0);   quick_fire();
   drive(135,100); while(loc_x()>100) attack();
   drive(135,0);   quick_fire();
   drive(45,100);  while(loc_y()<900) attack();
   drive(45,0);    quick_fire();
  } 
}

/* Routine di attacco standard */
attack() 
{  
 if ( (d=scan(ang,10)) && (d<750) ) 
  { 
   if (d=scan(ang+353,3)) cannon(ang+=353,d);
   else if (d=scan(ang,3)) cannon(ang,d);
   else if (d=scan(ang+7,3)) cannon(ang+=7,d); 
  }
 else
  {
   if ((d=scan(ang+21,10))&&(d<700)) {ang+=21;cannon(ang,d);}
   else if ((d=scan(ang+42,10))&&(d<700)) ang+=42;
        else ang+=63;
  }  
}                         

/* Routine di attacco veloce */
quick_fire()
{     
 while (speed() > 49) if ((d=scan(ang,10))) cannon(ang,d); 
                      else ang+=21;
}
