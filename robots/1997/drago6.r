/* drago6 di

Luca Trentinaglia

descrizione: si muove in diagonale sparando molto velocemente, anche se con
scarsa percisione

preferisco che partecipi questo robot se doveste scartarne uno
*/

int orange,range,angle,direz;
main()
{
   go_corner();
   while(1) {
     drive(direz=135,100);angle=direz;
     while(!((loc_x()<55)||(loc_y()>945))) {spara();}
     drive(direz=315,100);angle=direz;
     while(!((loc_x()>945)||(loc_y()<55))) {spara();}
}}

spara()
{
  if((range=scan(angle,8))&&range<700)          
  {
        if(scan(angle-6,4))
         angle-=6;
        else
         if(scan(angle+6,4))
          angle+=6;
        cannon(angle,range*300/(300+orange-range));
        }
  else
    if((range=scan(angle-18,10))&&range<800)                
      cannon(angle-=18,range);
    else
      if((range=scan(angle+18,10))&&range<800)
        cannon(angle+=18,range);
      else
        if((range=scan(angle-35,10))&&range<900)
          cannon(angle-=35,range);
        else
          if((range=scan(angle+35,10))&&range<900)
            cannon(angle+=35,range);
              else
                angle+=90;
  orange=range;
  drive (direz,100);
  }

go_corner()
{int angle;
  angle = plot_course(990,10);
  drive(angle,100);
  while (loc_x() < 965)   {spara();drive(angle,50);}
  }

plot_course(xx,yy)
int xx, yy;
{int dir,x,y,curx,cury;
  curx = loc_x();
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;
  if (x == 0) {
    if (yy > cury)
      dir = 90;
    else
      dir = 270;
  } else {
    if (yy < cury) {
      if (xx > curx)
        dir = 360 + atan((100000 * y) / x);
      else
        dir = 180 + atan((100000 * y) / x);
    } else {
      if (xx > curx)
        dir = atan((100000 * y) / x);
      else
        dir = 180 + atan((100000 * y) / x);
    }
  }
return(dir); }
