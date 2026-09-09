/*
  CRI95
  Creola Andrea

  Strategia: Inizialmente il robot sta fermo nella posizione iniziale finche
             la percentuale di danneggiamento non incrementa del 6%, dopo
             controlla nella 4 direzioni principali l'eventuale presenza di
             altri robot, per poi spostarsi in una posizione nella quale non
             dovrebbero essercene (si spera).
             A questo si trover… in uno dei quattro angoli, dove rimane fino
             a quando non viene disturbato, oppure fino a quando Š passato un
             determinato quantitativo di tempo senza sparare, questo se e
             solo se il danneggiamento Š inferiore al 60%.

  P.S. Nel caso in cui si debba limitare il numero dei robot, questo Š il
       prescelto.
*/

/**********/
int range;       /* Distanza dell'avversario */
int ang;         /* Direzione in cui cercare gli avversari */
int delta;       /* Differenza tra l'angolo in cui trova il robot
                    e il suo movimento */
int rangepr;     /* Distanza precedente */
int posizione;   /* Posizione del robot, indica in quale angolo */
int dam;         /* Usata per calcolare il danneggiamento */
int conta;       /* Usata per dei conteggi */
int range2;      /* Range supplementare */
int ang2;        /* Angolo supplementare */
int dir;         /* Direzione di navigazione */
int libero;      /* Serve per sapere se il robot Š stato impegnato o no
                    in scontri */
int flag;        /* Serve per sapere se le diagonali sono libere */
int mio_dam;     /* Viene usato per sapere l'incremento del danneggiamento
                    Nel movimento nelle diagonali */
/********** MAIN **********/
main()
{
/***** Attende nella posizione iniziale *****/
 att(0);
 if (!scan(000,10)) destra(2);
 else sinistra(0);
/***** Attende al bordo del campo *****/
 att(0);
 if (scan(090,010)) giu(posizione+1);
 else su(posizione);

/***** For ever *****/
 while(1)
  {
/********** POS 0 **********/
   if (posizione==0)
    {
     if (!scan(270,010))
      {
       giu(1);
       att(1);
      }
     else 
      {
       destra(2);
       att(1);
      }
    }
/********** POS 1 **********/
   if (posizione==1)
    {
     if (!scan(090,010))
      {
       su(0);
       att(1);
      }
     else 
      {
       destra(3);
       att(1);
      }
    }
/********** POS 2 **********/
   if (posizione==2)
    {
     if (!scan(180,010))
      {
       sinistra(0);
       att(1);
      }
     else 
      {
       giu(3);
       att(1);
      }

    }
/********** POS 3 **********/
   if (posizione==3)
    {
     if (!scan(180,010))
      {
       sinistra(1);
       att(1);
      }
     else 
      {
       su(2);
       att(1);
      }
    }

  }
}

/********** DESTRA **********/
destra(p)
int p;
{
 while(loc_x()<900) goo(000);
 ferma(p);
}
/********** SINISTRA **********/
sinistra(p)
int p;
{
 while(loc_x()>100)goo(180);
 ferma(p);
}
/********** SU **********/
su(p)
int p;
{
 while(loc_y()<900) goo(090);
 ferma(p);
}
/********** GIU **********/
giu(p)
int p;
{
 while(loc_y()>100)goo(270);
 ferma(p);
}

/********** STOP **********/
stop()
{
 drive(dir,000);
 while(speed()>50);
}
/********** ATT **********/
att(ok)
int ok;
{
 libero=100;
 dam=damage();
 while((damage()-6<dam)&&(libero)) sp2();
 if ((!libero)&&(ok)) diagonale();
}
/********** GOO **********/
goo(d)
int d;
{
 dir=d;
 drive(dir,80);
 sp1();
}
/********** SP 2 **********/
sp2 ()
{
 if(rangepr=scan(ang,10))
  {
   if (rangepr>700)
    {
     if (damage()<60)--libero;
     look(0);
     return;
    }
   libero=100;
   if (scan(ang,2))
    {
     if(scan(ang+=1,1));
     else ang+=359;
    }
   else if(scan(ang+6,4)) ang+=6; else ang+=354;


   if (range=scan(ang,1)) delta=0;
   else if(range=scan(ang+=4,2)) delta=7;
   else if(range=scan(ang+=352,2)) delta=353;
   else if(range=scan(ang+=12,2)) delta=8;
   else if(range=scan(ang+=344,2)) delta=352;
   else if(range=scan(ang+=20,2)) delta=10;
   else if(range=scan(ang+=336,2)) delta=350;
   if ((!range)||(range>700))
    {
     look(0);
     return;
    }
   fire();


   if (cerca2())ang = ang2;
  }
 else
  {
   look(0);
  }
}

/********** SP 1 **********/
sp1 ()  
{
 if (!(range = scan (ang, 5)))
  {
   if (range = scan(ang += 350, 5)) delta = 354;
   else if (range = scan(ang += 345, 10)) delta = 350;
   else if (range = scan(ang += 35, 5)) delta = 6;
   else if (range = scan(ang += 15, 10)) delta = 10;
   else
    {
     look(1);
     return;
    }
  }

 if (range>700)
  {
   look(1);
   return;
  }

 rangepr-=30*cos(dir-ang)/100000;
 fire();

 if (cerca2())
  {
   ang = ang2;
   rangepr = range2;
  }
 else rangepr = range;

}
/********** DIAG SU **********/
diag_su(new_pos,new_dir)
int new_pos,new_dir;
{
 if (!scan(new_dir,10))
  {
   posizione=new_pos;
   while(loc_y()<500) goo(new_dir);
   sosta();
   while(loc_y()<900) goo(new_dir);
   stop();
  }
 else flag=0;
}
/********** DIAG GIU **********/
diag_giu(new_pos,new_dir)
int new_pos,new_dir;
{
 if (!scan(new_dir,10))
  {
   posizione=new_pos;
   while(loc_y()>500) goo(new_dir);
   sosta();
   while(loc_y()>100) goo(new_dir);
   stop();
  }
 else flag=0;
}
/********** FIRE **********/
fire()
{
 cannon ( ang + delta, range + range*(range-rangepr)/250 );
}
/********* DIAGONALE *********/
diagonale()
{
 flag=mio_dam=damage();
 while(flag)
  {
   if (posizione&1)
    {
     if (posizione==1)diag_su(2,045);
     else diag_su(0,135);
    }
   else
    {
     if (posizione==0)diag_giu(3,315);
     else diag_giu(1,225);
    }
   if (damage()-6>mio_dam)flag=0;
  }
}
/********** LOOK **********/
look(d)
int d;
{
 conta = 10;
 while (!(range = scan(ang += 20, 10)) && (conta-=d));
 delta = 0;
 if (range)rangepr = range;
}
/********** SOSTA **********/
sosta()
{
 stop();
 att(0);
}
/********** CERCA 2 **********/
cerca2()
{
 range2 = scan(ang2 += 15, 10);
 return ((range2 > 0) && (range2 < (range - 50))) ;
}
/********** FERMA **********/
ferma(p)
int p;
{
 stop();
 posizione=p;
}