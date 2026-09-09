/*
Nome            : Pisolo - midi
Versione        : 1.0
Autore		: Simone Ascheri

Preludio
========
Biancaneve si Š smarrita nel bosco.
trova la casetta dei sette nani e ci si stabilisce.
Pisolo non Š molto contento e parte in cerca di avventura.

Commento
========

Trattasi di Raislin... aggiornato????
Ho cambiato qualche costante ma non ho nemmeno testato
*/

int timmax, ang, dx, dy;
int dan, park, a, oang, r, or;
int h, mi, mx, my, nx, ny, ampiezza, flag, flag1;
int max, clock;

main()                             
{

  dy=980-(loc_x(dx=(loc_y()>500)*960+20)>500)*960;

  while (Stop())
      {

         if (dan<=damage())
           while ((scan(10+(ang=(loc_x(park=dx)>(dx=1000-dy))*180+atan((((dy=park)-loc_y())*100000)/(dx-loc_x()))),10)+scan(350+ang,10))>400);

         drive (ang,100);
         while ((Dista(dx,dy)>4500)&&(speed()))
              if (h>6500) PallaDiFuoco(h<25000);

         if (dan=(flag1<387))
           {
             if ((timmax+=Stop(dan=damage()+(flag1=8)))%6);
             else
               {
                 while ((flag1+=20)<383) flag1-=(scan(flag1,10)>0);
               }

             ang=180*(dy>500)+90*(dx!=dy);
             if (clock=40000-clock)
               ang+=45;
             else
               if (scan(ang,10));else ang+=90;
      
             while ((Dista(dx,dy)<57000-clock))
                  PallaDiFuoco();
           }

      } 
}

Dista(nx,ny)
int nx, ny;
  {
    return (h=((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }
 
Stop()
{
         PallaDiFuoco(PallaDiFuoco(drive(ang+=180,0)));
}

PallaDiFuoco(meglio)
int meglio;
{
  if (meglio);
  else if (scan(a,10))
    {
      if ((or=Rivela(drive(ang,100)))<800)
        {
          if (r=Rivela())                
             return cannon((oang+(a-oang)*3-(sin(a-ang)/19500)),(r*200/(200+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10))&&(r<800));
  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang,10))) a=ang;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}

Rivela()   
{
  if(scan((oang=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}
