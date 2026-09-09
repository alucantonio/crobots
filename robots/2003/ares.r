/*
Nome            :Ares.r
Autore          :Ale De Leonardi
Categoria       :Microrobot           

Questo robot, che concorre per la categoria delle 1000 istruzioni, Š liberamente
ispirato a Raistlin.r, robot del 2001.
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
L'attacco finale Š la parte che differenzia notevolmente Ares da Sirio.
Infatti NON ricicla le routine del movimento principale ma utilizza una
procedura a se stante, dotata, inoltre di un Fuoco diverso.
Il combattente si porta al centro dell'arena, e da qui compie delle brevi
oscillazioni in direzione del nemico, sfasato di + o -30 gradi rispetto alla
linea effettiva. Ogni 10 cicli ricalibra l'angolo.
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
              if (h>6500) Raggi(h<25000,100);

         if ((flag1<387)&&(dan=(damage(Raggi(ang=45+180*(dy>500)+90*(dx!=dy),0),0))<80))
           {
             flag1=8;
             while ((flag1+=20)<383) flag1-=(scan(flag1,10)>0);

             if (clock=66000-clock);
             else
             {
               r=(scan(ang-45,10));
               or=(scan(ang+45,10));
               if ((r)&&(or)) ang-=15-30*(r>or);
               else if (r) ang-=15;
               else if (or) ang+=15;
             }
           }
         else {if (dan) Marte();ang-=15;}

         ang1=ang;

         while ((Dista(dx,dy)<77000-clock))
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
  if (meglio);
  else if (scan(a,10))
    {
      if ((or=raffina())<rg)
        {
          if (r=raffina())                
             return cannon((oang+(a-oang)*3-(sin(a-ang)/19500)),(r*200/(200+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10))&&(r<rg));
  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang1,10))) a=ang1;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}

raffina()   
{
  if(scan((oang=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

Marte()
int t,osc2,oscill;
{
    oscill=30;
    while(1)
    { if (((++t)%10)==1) osc2=a;
      while(((loc_x()%580)<420)) Raggi2(100);
      Raggi2(0);
      ang=90+180*(loc_y()>500);
      while(((loc_y()%580)<420)) {Raggi2(100);}
      Raggi2(0);
      ang=osc2+(oscill=-oscill);
      while (speed()<100) Raggi2(100);
      Raggi2(100);
      Raggi2(100);
      Raggi2(100);
      Raggi2(100);
      Raggi2(100);
      Raggi2(100);
      Raggi2(100);
      ang+=180;
      Raggi2(0);
    }
}
Raggi2(vel)
int vel;
{
drive (ang,vel);
  if (scan(a,10)) {
         if (r=scan(a,2)) return cannon(a,2*scan(a,10)-r);
    else if (r=scan(a-=7,5))    return cannon(a-7,2*scan(a,10)-r);
    else if (r=scan(a+=14,5))    return cannon(a+7,2*scan(a,10)-r);
  }
  if (r=scan(a-=20,10))        return cannon(a,r);
  else if (r=scan(a+=40,10)) return cannon(a,r);
  else return a+=40;
}
