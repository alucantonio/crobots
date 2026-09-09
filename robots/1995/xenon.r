/* Xenon.r */
/* Nome : Michele */
/* Cognome : Mascolo */


int range;   /* Variabile di distanza del bersaglio */
int bear;   /* variabile dell'angolo in cui si deve muovere il Crobot */

main()
{
int ax,ay;     /* Variabili per le locazioni degli angoli */
int bx,by;     /* Variabili per le locazioni degli angoli */
int cx,cy;     /* Variabili per le locazioni degli angoli */
int dx,dy;     /* Variabili per le locazioni degli angoli */
int angolo;   /* Variabile di selezione dell'angolo in cui muove */

ax=20;bx=970;cx=970;dx=20;  /* Assegnazione dei valori degli angoli */
ay=20;by=20;cy=970;dy=970;  /* Assegnazione dei valori degli angoli */
range=0;
angolo=1; /* Assegnazione dell'angolo di partenza */

while(1)
{ if (angolo==1)  /* Controlla quale Š l'angolo attuale */
    {vai(ax,ay);   /* Si dirige verso le coordinate ax,ay  */
     angolo=2;     /* Assegna l'angolo successivo */
  range=scan(45,10);  /* Controlla e spara tre colpi */
  if (range>0) {
  cannon(45,range);
  cannon(50,range+10);
  cannon(70,range+20);
  }
   }
  if (angolo==2)   /* Controlla quale Š l'angolo attuale */
    {vai(bx,by);   /* Si dirige verso le coordinate bx,by  */
     angolo=4;     /* Assegna l'angolo successivo */
     range=scan(135,10);   /* Controlla e spara tre colpi */
  if (range>0) {
  cannon(135,range);
  cannon(140,range+10);
  cannon(145,range+20);
  }
   }
  if (angolo==3)   /* Controlla quale Š l'angolo attuale */
    {vai(cx,cy);   /* Si dirige verso le coordinate cx,cy  */
     angolo=1;     /* Assegna l'angolo successivo */

     range=scan(215,10);   /* Controlla e spara tre colpi */
     if (range>1) {
     cannon(215,range);
     cannon(210,range+10);
	  }

     }
  if (angolo==4)         /* Controlla quale Š l'angolo attuale */
    {vai(dx,dy);         /* Si dirige verso le coordinate dx,dy  */
     angolo=3;           /* Assegna l'angolo successivo */
       range=scan(315,10); /* Controlla e spara tre colpi */
  if (range>0) {
  cannon(315,range);
  cannon(320,range+10);
  cannon(330,range+20);
  }
   }
  }
   }

vai(xxx,yyy)      /* Funzione che sfrutta la go e distanza per calcolare */
int xxx,yyy;      /* un avvicinamento preciso */
{
/* int bear   /* variabile dell'angolo in cui si deve muovere il Crobot */
  bear = go(xxx,yyy);
  drive(bear,100);
  while (distanza(loc_x(),loc_y(),xxx,yyy) > 100 && speed() > 0)
  {  /* Fa un avvicinamento veloce fino a 100 dalle coordinate */
  range=scan(0,1);
  if (range>0) {cannon(0,range);   /* Controlla e spara 3 colpi */
  cannon(0,range+5);
  cannon(0-10,range+5);

  }
  drive(bear,95);
  range=scan(180,1);            /* Controlla e spara 3 colpi */
  if (range>0) {cannon(180,range);
  cannon(180,range+5);
  cannon(180-10,range+5);
  }
  }
  while (distanza(loc_x(),loc_y(),xxx,yyy) > 10 && speed() > 0)
  {  /* Controlla se si Š arrivati a destinazione... */

  drive(bear,0); /* ... e lo ferma */
  }
}

distanza(x1,y1,x2,y2)    /* Funzione della distanza (pitagora) */
int x1;
int y1;
int x2;
int y2;
{ int x, y,d;
  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));
  return(d);
}

go(xx,yy)      /* Funzione tratta dalla Plot_course */
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;
  
  scale = 100000;
  curx = loc_x();
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  if (x == 0) {
    if (yy > cury)
      d = 90;
	  else
      d = 270;
  } else {
    if (yy < cury) {
      if (xx > curx)
	d = 360 + atan((scale * y) / x);
      else
	d = 180 + atan((scale * y) / x);
    } else {
      if (xx > curx)
	d = atan((scale * y) / x);
      else
	d = 180 + atan((scale * y) / x);
    } }
  return (d);   }
			     /* End */
