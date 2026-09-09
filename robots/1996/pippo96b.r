/*
  ********    ** ********    ********    ********  ********** **
  **********  ** **********  ********** ********** ********** **
  **      **  ** **      **  **      ** **      ** **      ** **
  **      **  ** **      **  **      ** **      ** ********** **********
  **********  ** **********  ********** **      ** ********** **********
  ********    ** ********    ********   **      **         ** **      **
  **          ** **          **         **********         ** **********
  **          ** **          **          ********          ** **********

  Pippo96b
  Creola Andrea

  Tattica: All'inizio oscilla orizzontalmente su luogo,
	   successivamente dopo essere stato colpito ed aver raggiunto
	   un dannegiamento superiore al 10% va nell'angolo sinistro
	   da dove inizia il pellegrinaggio andando su e gi—
	   per lo schermo, se nel tragitto viene colpito ripetutamente,
	   allora come consiglia il buon senso, cambia direzione e fugge
	   continuando a sparare.
	   Ogni robots che tenter… di fermare od ostacolare questo verr…
	   inesorabilmente annientato, polverizzato, disintegrato e gli
	   verranno spezzate le istruzioni senza nessun altro preavviso :-),
	   l'unico modo di evitare ci• Š quello di far partecipare solo
	   il capo squadra PIPPO96A.R, 3mate robots avversari.
*/

int ang;           /* angolo di sparo */
int dir;           /* direzione di movimento */
int rangepr;       /* range precedente */
int range2;        /* range per ricferca secondaria */
int dam;           /* controlla danni */
int wait;          /* limita le attese */
int ang2;          /* angolo secondo scan */
int range;         /* range principale */
int delta;         /* sfasamento dell'angolo */
main()
{
 inizio();
 drive(180,100);
 while(loc_x()>100) spara();

 drive(180,40);
 while(loc_x()>20) ;
 drive(270,0);
 while(speed()>50);

 while(1)
 {
  drive(270,100);
  dam=damage();
  while((loc_y()>200)&&(damage()-10<dam))
   {
    drive(270,100);
    spara();
   }
  drive(90,0);
  while(speed()>50);

  drive(90,100);
  dam=damage();
  while((loc_y()<800)&&(damage()-10<dam))
   {
    drive(90,100);
    spara();
   }
  drive(270,0);
  while(speed()>50);

 }
}
/********** Spara *********/
spara()
{
 if (!rangepr)
  {
   while (!(range = scan(ang += 20, 10)) );
   if (scan(ang-7,4)) ang-=7;
   else if(scan(ang+7,4)) ang+=7;
   if (rangepr=scan(ang,10))
    {
     if (rangepr<700)
      {
       cannon(ang, rangepr*rangepr/range);
       if (cerca2())rangepr=range;

      }
     else rangepr=0;
    }
   return;
  }

 if (!(range = scan (ang, 3)))
  {
   if (range=scan(ang,1)) delta=0;
   else if(range=scan(ang+=4,2)) delta=7;
   else if(range=scan(ang+=352,2)) delta=353;
   else if(range=scan(ang+=12,2)) delta=8;
   else if(range=scan(ang+=344,2)) delta=352;
   else if(range=scan(ang+=20,2)) delta=10;
   else if(range=scan(ang+=336,2)) delta=350;
   else
    {
     rangepr=0;
     return;
    }
  }
 else delta=0;
 if (range<700)
  {
   cannon(ang + delta, range + (range - rangepr) / 3);
   cerca2();
  }
 else range=0;
 rangepr=range;
}
/********** CERCA 2 **********/
cerca2()
{
 wait=5;
 while(--wait)
 {
  ang2=90;
  if (range2 = scan(ang2 += 18, 10))
   {
    if (range2 < range - 50)
    {
     range=range2;
     ang=ang2;
     return(1);
    }
   }
 }
 return (0);
}
/********** Fermo **********/
inizio()
{
 int x,y;
 x=loc_x();
 if(x<100)x=100;
 if(x>900)x=900;
 while(damage()<10)
   {
    drive(0,100);
    while(loc_x()<x+10)sp_i();
    drive(180,0);
    while(speed()>50);

    drive(180,100);
    while(loc_x()>x-10)sp_i();
    drive(0,0);
    while(speed()>50);
   }
}
/********** sp i **********/
sp_i()
{
 if (!(range = scan (ang, 5)))
  {
   if (range = scan(ang -= 10, 5))delta= -6;
   else if (range = scan(ang -= 15, 10))delta= -10;
   else if (range = scan(ang += 35, 5))delta= 6;
   else if (range = scan(ang += 15, 10))delta= 10;
   else
    {
     wait = 10;
     while (!(range = scan(ang += 20, 10)) && (--wait));
     delta = 0;
     rangepr = range;
     return;
    }
  }
 if (range<700)
  {
   if (range-50>rangepr)  cannon(ang+ delta, (range * 15) / 13);
   else if (range+50<rangepr) cannon(ang + delta , (range * 15) / 17);
   else cannon(ang + delta , range );
  }
 range2 = scan (ang2 -= 20, 10);
 if ((range2> 0) && (range2 < (range- 50)))
  {
   range = range2;
   ang = ang2;
  }
 else rangepr = range;
}


