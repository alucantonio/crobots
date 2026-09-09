/*

  Crobot:  CARLO.R

  Data  :  26.09.94

  Autore:  Luigi Cimini

  Scan() con 2 risoluzioni, se colpito fugge, se bersaglio fuori portata lo
  insegue, tre tipi di tiro, per robot fermo, in fuga ed in avvicinamento.

*/

int ang, ang1, old1, back;
int di, vd, pass0, pass1, pass2, ris;
register int danno;
long i;

main()
{
ris = 1;
pass0 = 20;
pass1 = 10;
pass2 = 3;
back = 3*pass1;
ang = 360;
ang1 = 360;
old1 = 360;
di = 0;
vd = 0;
danno = damage();

while(1)
   {
   if (scan(ang,pass1))  /* intercettato */
      {
      old1=ang;
      ang1=ang+pass1;
      while(ang < ang1)
         {
         if (vd=scan(ang,ris))
            {
            if (vd > 700)     /* insegue */
               {
               drive(ang,100);
               i = 1;
               while(++i < 55)
                 ;
               while(speed()>49) drive(ang,0);
               ang -= pass2;
               }
            else
               {
               while((di=scan(ang,ris)) && di<700)
                  {
                  if (di==vd) cannon(ang+1,di); else cannon(ang+1,di+di-vd);
                  if (danno != damage()) scappa();
                  vd = di;
                  }
               }
            }
         if (danno != damage()) scappa();
         ang += pass2;
         }
      ang=old1-back;
      }
   if (danno != damage()) scappa();
   ang += pass0;
   ang %= 720;
   }
}
/*  end  main  */

scappa()
{
  int x, y, dx, dy, scarto, i;

  while (speed() > 49) drive(ang,49);
  scarto = 44 + rand(44);
  x=loc_x(); y=loc_y();

  if (rand(32767) < 16384)
     {
     if (x < 500)
        {
        drive(0,100);
        i=1; while(++i < scarto)
          ;
        drive(0,0);
        }
     else
        {
        drive(180,100);
        i=1; while(++i < scarto)
          ;
        drive(180,0);
        }
     }
  else
     {
     if (y < 500)
        {
        drive(90,100);
        i=1; while(++i < scarto)
          ;
        drive(90,0);
        }
     else
        {
        drive(270,100);
        i=1; while(++i < scarto)
          ;
        drive(270,0);
        }
     }
  danno = damage();
}
/*  end  carlo.r  */
