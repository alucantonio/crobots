/*
 *********************   TOX 1.0  ********************  
 IDEATO DA:

               ALESSANDRO CAMELA

 ROBOT PER IL QUINTO TORNEO DI CROBOTS.

 DATA 28/9/95.

*/
int range,orange,ang,oang,dam,lr,dif,aa,rr;
int x,y,d,curx,an,pot,i;
main()
{
/* INIZIALIZZA VALORI */
ang=7;
dif=4;
lr=700;
   while (1)
           {
             /* VA NELLE COORDINATE INDICATE  */
                go(100,100);
		go(100,900);
		go(900,900);
		go(900,100);
	   }
}
go(ax, ay)
{
  drive(an,0);
  dam=damage();
  an = angolo_rotazione(ax,ay);
  while(speed()>48);
  drive(an,100);
  while (distanza(ax,ay) > 20000)
   {
    /* SCANNA CON RISOLUZIONE PARI A 5
       SE TROVA ROBOT SCANNA CON RISOLUZIONE PARI A 1*/
     if(scan(ang,5))
      {
       if(scan(ang-5,1)) ang-=5;
       if(scan(ang+5,1)) ang+=5;
       if(scan(ang-3,1)) ang-=3;
       if(scan(ang+3,1)) ang+=3;
       if(scan(ang-1,1)) ang-=1;
       if(scan(ang+1,1)) ang+=1;
       if (range=scan(ang,5))
         {
           orange=range;
           oang=ang;
           if(scan(ang-5,1)) ang-=5;
           if(scan(ang+5,1)) ang+=5;
           if(scan(ang-3,1)) ang-=3;
           if(scan(ang+3,1)) ang+=3;
           if(scan(ang-1,1)) ang-=1;
           if(scan(ang+1,1)) ang+=1;
             if (range=scan(ang,10))
               {
                 aa=(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-an)>>14));
                 rr=(range*160/(160+orange-range-(cos(ang-an)>>12)));
                 while(!cannon(aa,rr));
                 if (range>lr) ang+=30;
               }
      /* SE NON TROVATO SCANNA A SINISTRA E POI A DESTRA  */
             else if(scan(ang-=10,10));
                  else if(scan(ang+=20,10));
                       else while ((scan(ang+=11,10))== 0);
         }
       else if(scan(ang-=10,10));
            else if(scan(ang+=20,10));
                 else while ((scan(ang+=11,10))== 0);
      }
    else if(scan(ang-=10,10));
         else if(scan(ang+=20,10));
              else while ((scan(ang+=11,10))== 0);
 /* SE COLPITO  CAMBIA DIREZIONE  */
  if(damage()>(dam+dif)) {dif=14;return;}
  if (!speed()) return;
 }
/* ARRIVATO A DESTINAZIONE FERMATI */
drive(an,0);
i=150;
dif=2;
dam=damage();
/* ROUTINE DI SPARO DA FERMO  */
while((damage()<(dam+dif))&&(--i))
 {
     if(scan(ang,5))
      {
       if(scan(ang-5,1)) ang-=5;
       if(scan(ang+5,1)) ang+=5;
       if(scan(ang-3,1)) ang-=3;
       if(scan(ang+3,1)) ang+=3;
       if(scan(ang-1,1)) ang-=1;
       if(scan(ang+1,1)) ang+=1;
       if (range=scan(ang,5))
         {
           orange=range;
           oang=ang;
           if(scan(ang-5,1)) ang-=5;
           if(scan(ang+5,1)) ang+=5;
           if(scan(ang-3,1)) ang-=3;
           if(scan(ang+3,1)) ang+=3;
           if(scan(ang-1,1)) ang-=1;
           if(scan(ang+1,1)) ang+=1;
             if (range=scan(ang,10))
               {
                 aa=(ang+(ang-oang)*((1200+range)>>9));
                 rr=(range*165/(165+orange-range));
                 while(!cannon(aa,rr));
                 if (range>lr) ang+=30;
               }
             else if(scan(ang-=10,10));
                  else if(scan(ang+=20,10));
                       else while ((scan(ang+=15,10))== 0);
         }
       else if(scan(ang-=10,10));
            else if(scan(ang+=20,10));
                 else while ((scan(ang+=15,10))== 0);
      }
    else if(scan(ang-=10,10));
         else if(scan(ang+=20,10));
              else while ((scan(ang+=15,10))== 0);
 }
dif=4;
}
angolo_rotazione(xx, yy)
{
	curx = loc_x();
	x = curx - xx;
	y = (loc_y() - yy) * 100000;
	if (xx > curx)
		d = 360 + atan(y / x);
	else
		d = 180 + atan(y / x);
	return (d);
}

distanza(xx1, yy1)
{
	x = xx1 - loc_x();
	y = yy1 - loc_y();
	d = (x * x) + (y * y);
	return(d);
}
