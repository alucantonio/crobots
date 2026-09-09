/* funky.r

   Paolo Paganucci

   Funky si muove lungo i bordi del campo ad una velocit variabile
   con il damage(). In particolare, se si accorge che in un certo
   punto non subisce danni rallenta fino a fermarsi e riparte non
   appena subisce nuovi danni. Non  proprio uno spavaldo, comunque ...

   L'algoritmo di tiro esegue una specie di ricerca dicotomica dell'
   avversario per determinare le correzioni angolare e di gittata da
   apportare al tiro. I parametri scelti derivano da una 'nottata' di
   prove, ma probabilmente sono migliorabili.

                                                Paolo Paganucci
*/

int range1, range2, angle;
int vel, danno, dir, ral;

main()
{
   int x1,x2,x3,x4;
   int y1,y2,y3,y4;
   int d;

   x1 = 70;  y1 = 70;      /* i quattro angoli del campo */
   x2 = 930; y2 = 70;
   x3 = 930; y3 = 930;
   x4 = 70;  y4 = 930;

   angle = 0;
   vel = 100;          /* velocit di crociera */
   ral = 40;           /* velocit di rallentamento per il cambio direzione */
   danno = damage();
   d = 0;

   drive(90,vel);            /* si prepara a dirigersi verso il punto x1,y1 */
   while(loc_y() < 500)
       shoot(1000);

   drive(90,ral);
   while(speed() > 49)
       shoot(1000);

   dir = direction(x1,y1);
   drive(dir,vel);

   /* ciclo generale di controllo della posizione */

   while (1)
   {
       while (loc_y() > y1)
       {
           shoot(460);            /* spara */
           drive(dir,velox());    /* controlla la velocit */
           if( ++d == 50 )        /* ed eventualmente aggiorna il danno */
               {d=0;danno=damage();}
       }
       drive(dir,ral);            /* si prepara a cambiare diezione */
       while(speed()>49)
           shoot(460);

       dir = 0;                   /* resetta i parametri in base al lato */
       angle = 0;                 /* che sta per percorrere */
       d = 0;
       drive(dir,velox());
       while (loc_x() < x2)
       {
           shoot(190);
           drive(dir,velox());
           if( ++d == 50 )
               {d=0;danno=damage();}
       }
       danno=damage();
       drive(dir,ral);
       while(speed()>49)
           shoot(190);

       dir = 90;
       angle = 80;
       d = 0;
       drive(dir,velox());
       while (loc_y() < y3)
       {
           shoot(280);
           drive(dir,velox());
           if( ++d == 50 )
               {d=0;danno=damage();}
       }
       danno=damage();
       drive(dir,ral);
       while(speed()>49)
           shoot(280);

       dir = 180;
       angle = 170;
       d = 0;
       drive(dir,velox());
       while (loc_x() > x4)
       {
           shoot(370);
           drive(dir,velox());
           if( ++d == 50 )
               {d=0;danno=damage();}
       }
       danno=damage();
       drive(dir,ral);
       while(speed()>49)
           shoot(370);

       dir = 270;
       angle = 260;
       d = 0;
       drive(dir,velox());
   }
}

/* funzione di controllo della velocit */

velox()
{
   vel = speed();
   if( danno < damage() )
      vel+=20;                /* se il danno  cambiato accellera */
   else
      vel-=20;                /* altrimenti rallenta */
   return(vel);
}

/* funzione di calcolo della gittata */

fire(scarto)
int scarto;
{
   return ( (scarto*range2)/100-range1 );  /* assolutamente empirica !! */
}

/* funzione di fuoco che ricerca l'avversario in modo dicitomico */

shoot(max)
int max;
{
int i;

   if( (range1=scan(angle,8)) && (range1<750) )
   {
       if( range2=scan(angle,2) )
       {
           cannon(angle,fire(200));
           return;
       }
       else
       {
           if( scan(angle+6,4) )
           {
               if( range2=scan(angle+8,2) )
               {
                   cannon(angle+=10,fire(220));
                   return;
               }
               else
               {
                   cannon(angle+=6,fire(210));
                   return;
               }
           }
           else
           {
               if( scan(angle-6,4) )
               {
                   if( range2=scan(angle-8,2) )
                   {
                       cannon(angle-=10,fire(220));
                       return;
                   }
                   else
                   {
                       cannon(angle-=6,fire(210));
                       return;
                   }
               }
               else
               {
                   i=6;
                   while( !scan((angle+=20),10) && (--i) )
                       ;
                   return;
               }
           }
       }
   }
   if ( (angle+=20) > max)
       angle-= 200;
}

/* Classica funzione che restituisce l'angolo
   per raggiungere il punto x1,y1 */

direction(x1,y1)
int x1,y1;
{
   int dd,x,y;
   int scale, curx, cury;

   scale = 100000;
   curx = loc_x();
   cury = loc_y();
   x = curx-x1;
   y = cury-y1;

   if (x==0)
   {
       if (y1>cury)
           dd = 90;
       else
           dd = 270;
   }
   else
   {
       if (y1<cury)
       {
           if (x1>curx)
               dd = 360 + atan((scale * y)/x);
           else
               dd = 180 + atan((scale * y)/x);
       }
       else
       {
           if (x1>curx)
               dd = atan((scale * y) /x);
           else
               dd = 180 + atan((scale * y)/x);
       }
   }
   return (dd);
}

/* fine di funky.r */
