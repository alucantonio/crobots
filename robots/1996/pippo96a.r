/*
  ********    ** ********    ********    ********  ********** **
  **********  ** **********  ********** ********** ********** **
  **      **  ** **      **  **      ** **      ** **      ** **
  **      **  ** **      **  **      ** **      ** ********** **********
  **********  ** **********  ********** **      ** ********** **********
  ********    ** ********    ********   **      **         ** **      **
  **          ** **          **         **********         ** **********
  **          ** **          **          ********          ** **********

  Pippo96a
  Creola Andrea

  Tattica: Il robot si mouve lungo i lati in senso antioriario, ad ogni
	   angolo si ferma e attende che passi un determinato tempo, oppure
	   che venga colpito, durante la sua sosta oscilla a destra e sinistra
	   (tattica simile al B52.R, per sparare usa una routine sia se si
	   sta mouvendo lungo i lati che quando oscilla.
	   La routine di sparo deriva da quella di godel, ho usato quella dato
	   che mi risulta una delle pi— precise mai realizzate.

	   Nel caso che il torneo richieda la pertecipazione di un solo robot,
	   questo Š il caposquadra.

*/

int __x,          /*  Coordinata x                    */
    dam,          /*  Danno subito                    */
    dir,          /*  Direzione di movimento          */
    ang,          /*  Angolo di scansione attuale     */
    rangepr,      /*  Range di scansione              */
    range,        /*  Ultimo range di scansione       */
    sfas,         /*  Sfasamento dell'angolo di sparo */
    tempo,        /*  Tempo da quando Š nell'angolo */
    ti;           /*  Tempo di ricerca */

main()
{
 while(1)
 {
  go(150,150);

  go(850,150);

  go(850,850);

  go(150,850);


 }
}
/********** OSC O **********/
osc_o()
{
  while(loc_x()<__x+10)
   {
    drive(0,100);
    sp1();
   }
  drive(180,0);
  while(speed()>50);

  while(loc_x()>__x-10)
   {
    drive(180,100);
    sp1();
   }
  drive(0,0);
  while(speed()>50);

}

/********** GO **********/
go (x,y)
int x,y;
{

 dir = direzione(x,y);
 drive(dir,100);
 dam=damage();
 while(dist(x,y)>100)
  {
   if (dam>damage())
    {
     drive(dir,0);
     while(speed()>50);
     return;
    }
   sp1();
  }
 dir = direzione(x,y);
 drive(dir,0);
 while(speed()>50);

 dam=damage();
 __x=loc_x();
 tempo=60;
 while((damage()-10<dam)&&(--tempo))osc_o();

}
/********** DIST **********/
dist (x,y)
int x,y;
{
 int x1,y1,dis;
 x1 = loc_x() - x;
 y1 = loc_y() - y;
 dis = sqrt((x1 * x1)+(y1 * y1));
 return (dis);
}
/********** DIREZIONE **********/
direzione (x,y)
int x,y;
{
 int locx, locy, r;

 locx = loc_x();
 locy = loc_y();

 if (locx==x)
  {
   if (y>locy) return 90;
   else return 270;
  }
 else
  {
   r=atan(100000*(locy-y)/(locx-x));
   if( y < locy)
    {
     if (x > locx) return 360 + r;
     else return 180 + r;
    }
   else if (x > locx) return r;
   else return 180 + r;
  }

}
/********** SP1 **********/
sp1()
{
 if(rangepr=scan(ang,10))
  {
   if (rangepr>700)
    {
     ang+=19;
     return;
    }
   if (scan(ang,2))
    {
     if(scan(ang+=1,1));
     else ang+=359;
    }
   else if(scan(ang+6,4)) ang+=6; else ang+=354;



   if (range=scan(ang,1)) sfas=0;

   else if(range=scan(ang+=4,2))sfas=7;
   else if(range=scan(ang+=352,2))sfas=353;
   else if(range=scan(ang+=12,2))sfas=8;
   else if(range=scan(ang+=344,2))sfas=352;
   else if(range=scan(ang+=20,2))sfas=10;
   else {ang+=330;return;}

   cannon(ang+sfas,(815+(range-rangepr)*36/10)*range/800);

  }
 else
  {
   ti=10;
   while ((!(scan(ang+=19,10)))&&(--ti));
   ang%=360;
  }
}
