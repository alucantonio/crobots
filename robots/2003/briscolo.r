/*
Nome            :Briscolo.r
Autore          :Ale De Leonardi
Categoria       :Microrobot           

Questo robot, versione minimalista di Sirio.r, concorre per la categoria delle
500 istruzioni. E' liberamente ispirato a Raistlin.r, robot del 2001.
Il corpo principale del programma Š rimasto pi— o meno invariato, fatte salve
alcune modifiche necessarie per ridurre l'occupazione di codice, quali
l'eliminazione della Stop().

Il calcolo dell'angolo verso cui accasarsi viene fatto a ogni oscillazione,
perdendo preziosi cicli di CPU che, comunque, sono pi— o meno recuperati eliminando
una chiamata alle routine di sparo durante il rallentamento.

La scelta dell'oscillazione dipende dalla presenza o meno del nemico nell'angolo
prescelto e dalla sua distanza. L'attacco avviene con un angolo di 30 gradi
rispetto ai lati dell'arena. Ogni oscillazione Š comunque intervallata da
un brevissimo run lungo la diagonale.

Il conteggio dei superstiti Š effettuato ad ogni ciclo.
Durante l'attaco finale Briscolo cambia angolo costantemente, disegnando una specie
di triangolo.

A differenza di Sirio, Briscolo NON usa le Toxiche, ma una routine molto pi—
grezza.
*/

int ang, dx, dy;
int park, a, oang, r, or;
int h, nx, ny, flag1, dan;
int ang1, max, clock,rg;

main()                             
{

  while (Raggi(ang=(loc_x()>(dx=(loc_x(rg=850)>500)*960+20))*180+atan((((dy=(loc_y()>500)*960+20)-loc_y())*100000)/(dx-loc_x())),0))
      {
         while (Dista(dx,dy)>4500)
              if (h>6500) Raggi(1,100);

         if ((flag1<387)&&(dan=(damage(Raggi(Raggi(ang=45+180*(dy>500)+90*(dx!=dy),0),0))<80)))
           {
             flag1=8;
             while ((flag1+=20)<383) flag1-=(scan(flag1,10)>0);

             if (clock=86000-clock);
             else
             {
               r=(scan(ang-45,10));
               or=(scan(ang+45,10));
               if ((r)&&(or)) ang-=15-30*(r>or);
               else if (r) ang-=15;
               else if (or) ang+=15;
             }
           }
         else {if (dan) clock=-(rg=350000);ang-=15;}

         ang1=ang;

         while ((Dista(dx,dy)<97000-clock))
               Raggi(0,100);

      } 
}

Dista(nx,ny)
int nx, ny;
  {
    return (h=((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }
 
Raggi(meglio,vel)
int meglio,vel;
{
  drive(ang,vel);
  if ((or=scan(oang=a,10))&&(or<rg))
        {
          if (scan(a-5,5)) a-=5; else a+=10;
          if (scan(a-3,3)) a-=3; else a+=6;
          return cannon(2*a-oang,2*scan(a,10)-or);
        }
  if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang1,10))) a=ang1;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}

