/* 
Crobot : 8BISMARK.R     
Autore : Ugo Pattacini 
*/
/* Per la strategia di 8BISMARK.R vedere il file 8BISMARK.TXT */

int ang,          /* Angolo di scansione */
    newrange,     /* Nuova gittata del proiettile */
    oldrange,     /* Vecchia gittata del proiettile */
    dir;          /* Aggiorna la direzione di spostamento per il calcolo dell'angolo */

main()
{
int dam,          /* Danneggiamento */
    count,        /* Contatore generico */
    lap=0,        /* Contatore di giri */
    flag;         /* Spia di controllo */

   dir=270;           /* Raggiunge la posizione di partenza : Lato Sud */ 
   ang=rand(360);
   drive(270,100);     
   while(loc_y()>50)
    shoot();
   drive(0,0);
   while (speed() > 49)
    shoot();

while(1)              /* Inizia il ciclo infinito */
{
  flag = 0;
  dam = damage();

   ang=0;             /* Raggiunge il Lato Est */
   dir=0;
   drive(0,100);
   while(loc_x()<950)     
    shoot();
   drive(90,0);
   while (speed() > 49)
    shoot();

   if (damage() > dam+20)  /* Se il danneggiamneto Š eccessivo... */
   {
    ang = 330;
    dir=180;
    drive(180,100);
    while (loc_x() > 50)
     shoot();              
    drive(0,0);
    while (speed() > 49)
     shoot();              /* ...raggiunge il Lato Ovest e... */
    wedge1();              /* ...inzia il ciclo wedge1 */
    dam=damage();
   }

   ang=90;                 /* Raggiunge il Lato Nord */
   dir=90;
   drive(90,100);
   while (loc_y()<950)
    shoot();
   drive(180,0);
   while (speed()> 49)
    shoot();

   ang=180;                /* Raggiunge il Lato Ovest */
   dir=180;
   drive(180,100);
   while (loc_x()>60)
    shoot();
   drive(270,0);
   while (speed()>49)
    shoot();

   if (damage()> dam+30 && flag==0)   /* Se il danneggiamento Š eccessivo... */
   {
    flag=1;                /* ...accende la spia e... */
    wedge2();              /* ...inizia il ciclo wedge2 */
   }

   ang=270;                /* Raggiunge il Lato Sud */
   dir=270;
   drive(270,100);
   while (loc_y()>50)
    shoot();
   drive(0,0);
   while (speed()>49)
    shoot();


 if (damage() > dam+20 && flag==0)  wedge1();  /* Se il danneggiamento Š eccessivo ma... */
                               /* ...la spia Š spenta, inizia il ciclo wedge1 */
 if (damage() == dam && scan(ang,10) > 700) lap+=1;  /* Aggiorna il contatore di giri */

 if (lap == 3)  /* Se giri=3 e nemico troppo lontano... */
 { 
  count=0; 
  lap=0;                                    
  drive(0,0);                             /* ...fermati e aspetta... */
  while (count<=25 && scan(ang,10)>650)   /* ...per 25 iterazioni */
   {
    shoot();
    count+=1;
   }
 }
}
}

shoot()                             /* Algoritmo di sparo */
{
 if ( newrange = scan(ang,10) )           /* Se il nemico Š a portata...*/
 {
  if (oldrange < newrange)                /* ...se si allontana...*/
  {
   cannon(set_ang(),8 * newrange /7);  /* ...spara un p• pi— lontano,... */
   oldrange = newrange;
  } 
  else                                    /* ...se si avvicina... */
  {
   cannon(set_ang(),7 * newrange /8);  /* ...spara un p• pi— vicino */
   oldrange = newrange;
  }
 } 
 else ang += 20;                          /* Se no c'Š il nemico aumenta l'angolo */
}

set_ang()           /* Algoritmo di aggiustamento dell'angolo di sparo */
{
 int d;
  d=ang-newrange/200;                    /* Aumenta o diminuisce l'angolo... */
  if (scan(d,3)==0) d=ang+newrange/195;  /* ...in proporzione alla distanza */
  else d=ang-newrange/195;
 return(d);
}

wedge1()   /* Algoritmo per la guida nell'angolo inferiore sinistro del campo */
{                          /* Percorso a cuneo */
 int dam2,                            /* Danneggiamento */
     lap2;                            /* Contatore di giri */
  dam2=damage();
  lap2=0;
  while (damage()<dam2+6 && lap2<=7)   /* Se danneggiamneto < 6 a giro e... */
  {                                    /* ...ciclo di 7 iter. non finito... */
   dam2=damage();
   if (lap2>7) lap2=0;                 /* ...procedi */

   ang = 0;
   dir=0;
   drive(0,100);
   while (loc_x()<280)
    shoot();
   drive(0,0);
   while (speed()>49)
    shoot();

   ang = 150;
   dir=130;
   drive(130,100);
   while (loc_y()<330)
    shoot();
   drive(135,0);
   while (speed()>49)
    shoot();

   ang = 270;
   dir=270;
   drive(270,100);
   while (loc_y()>50)
    shoot();
   drive(0,0);
   while (speed()>49)
    shoot();

   lap2+=1;
  }
}

wedge2()   /* Algoritmo per la guida nell'angolo superiore sinistro del campo */
{                          /* Percorso a cuneo */
int dam3,                             /* Danneggiamento */
    lap3;                             /* Contatore di giri */
    dam3=damage();
    lap3=0;
   while (damage()<dam3+6 && lap3<=7)  /* Se danneggiamento < 6 a giro e... */
   {                                   /* ...ciclo di 7 iter. non finito... */
    dam3=damage();
    if (lap3>7) lap3=0;                /* ...procedi */

    ang = 270;
    dir=270;
    drive(270,100);
    while (loc_y()>750)
     shoot();
    drive(0,0);
    while (speed()>49)
     shoot();

    ang = 45;
    dir=46;
    drive(46,100);
    while (loc_y()<950)
     shoot();
    drive(0,0);
    while (speed()>49)
     shoot();

    ang = 180;
    dir=180;
    drive(180,100);
    while (loc_x()>50)
     shoot();
    drive(0,0);
    while (speed()>49)
     shoot();

    lap3+=1;
   }
}
