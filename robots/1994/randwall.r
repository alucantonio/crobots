/*           DATI ANAGRAFICI DELL' AUTORE

    Nome e cognome: Giovanni Cuciniello

Randwall combatte con due tattiche diverse: la prima viene  eseguita
fino a quando il robot rimane solo con un altro,  dopodichŠ subentra
la seconda tattica. La prima tattica (main()) fa  si che Randwall si
muova (la prima volta)  verso  l'angolo  pi— vicino; da qui il robot
parte  random  verso una delle direzioni, parallele ai muri, che pu•
seguire.Arrivato nell'angolo successivo sempre in modo random decide
se continuare nel senso in cui stava camminando,andando quindi verso
l'altro angolo, oppure tornare indietro all' angolo precedente. Ogni
5 random, c' Š il  controllo  della  quantit…  di robot nemici sullo
schermo. Se  conta un solo  robot allora  esegue  la seconda tattica
(hard()) e cioŠ quella del  corpo a corpo.    In caso di  esclusione
di uno dei due robot (RANDWALL.r e MAVERICK.r)la preferenza verte su
MAVERICK.r.

*/



int grs,dirx,i,diry,dirmax,dirmin,gradi,range,cont,x,y,x1,r,g,or,orange,c,gr;


     /*            PRIMA TATTICA             */
main()
{
 c=0;
 r=0;

 /*Primo controllo della quantit… di robot ( per tutti i 360ø )
 con();
 if ((cont<2) || (damage()>60)) hard();                        */


 /* Ricerca dell'angolo pi— vicino*/
 if (loc_x()>500) dirx = 0; else dirx=180;
 while ((loc_x()<900) && (loc_x()>100))
 {
  drive(dirx,100);
  spara();
 }
 while (speed()>50)
 {
  drive(0,0);
  spara();
 }
 if (loc_y()>500) diry = 90; else diry=270;
 while ((loc_y()<900) && (loc_y()>100))
 {
  drive(diry,100);
  spara();
 }
 while(speed()>50)
 {
  drive(0,0);
  spara();
 }
 dirx+=180;
 diry+=180;
 ass_dir();
 or=range;
 g=1;

 while (1)
 {
  /* Scelta random della direzione da seguire*/
  g=rand(2)+1;
  if (g==1)     /* Se g=1 vai alla direzione di dirx */
  {
   g=dirx;
   dirx+=180;
  }
  if (g==2)    /* altrimenti alla direzione diry */
  {
   g=diry;
   diry+=180;
  }
  /* Trovata la direzione random Randwall vi si sposta */
  grs=dirmin;
  if ((g%360)==0) while (loc_x()<900) sposta();
  if ((g%360)==180) while (loc_x()>100) sposta();
  if ((g%360)==270) while (loc_y()>100) sposta();
  if ((g%360)==90) while (loc_y()<900) sposta();
  while (speed()>50)
  {
   drive(g-180,0);
   spara();
  }
  ass_dir(); /* Assegna le nuove direzione possibili */
  c+=1;
  if (c==4)  /* Se ha cambiato 5 angoli */
  {
   c=0;
   con90(); /*Fai il controllo della quantit… di robot nei 90ø dell' angolo*/
   if ((cont<2) || (damage()>60)) hard();  /*Se i robot presenti sono meno*/
  }                                        /*di 2, oppure se              */
 }                                         /*il danneggiamento Š superiore*/
}                                          /*al 60% esegui la seconda     */
                                           /*tattica (hard()) */


spara()
{
 if ((range=(scan(grs,5))) && (range>40))
 {
  if ((grs>g+170) && (grs<g+190)) i=50; else i=0;
  /*cannon(grs,range+(range-or+cos(grs-g)/2000)*range/325);*/
  cannon(grs,range+range-or-i);
  cannon(grs,range+range-or-i);
  or=range;
 }
 else
 {
  grs-=10;
  if (grs<=dirmin-10) grs=dirmax+10;
 }
}




sposta()
{
 drive(g,100);
 spara();
}




ass_dir()
{
 if (dirx > diry)
 {
  dirmax=dirx;
  dirmin=diry;
 }
 else
 {
  dirmax=diry;
  dirmin=dirx;
 }
 if ((dirmin==0) && (dirmax==270))
 {
  dirmin=270;
  dirmax=0;
 }
}




                 /* SECONDA TATTICA */

hard()
{
 while(1)
 {
  while (!(range=scan(gradi,10)))     /* Fino a quando no vedi nessuno*/
   (gradi+=20);                       /* guarda ai gradi vecchi + 20ø */
  drive(gradi,100);                   /* Vai verso l'obiettivo */
  while (!(range==0))                 /* Fino a quando lo vedi*/
  {
   or=range;                          /* Il vecchio range Š uguale al nuovo*/
   drive(gradi,100);                  /* Vai verso l'obiettivo*/
   range=scan(gradi,5);               /*Se lo continui a vedere in un range*/
   if (range>41)                      /* di vista minore allora sparalo */
   {
    cannon(gradi,range+(range-or));
    cannon(gradi,range+(range-or));
   }
  }
  if (range=(scan(gradi-180,10)))     /*Se invece l'hai perso allora guarda*/
  {                                   /*dietro se l' hai passato*/
   gradi+=180;
   if (range>41)                      /* Se c'Š allora sparalo */
   {
    cannon(gradi,range); /*cambiamento*/
    cannon(gradi,range);
   }
  }
  else                                /* Altrimenti cercalo a 20ø pi— */
  {                                   /* a sinistra */
   if (range=(scan(gradi+20,10)!=0))
   {
    gradi+=20;
    if (range>41)                     /* Se l'hai trovato allora sparalo */
    {
     cannon(gradi,range);
     cannon(gradi,range);
    }
   }
   else                              /* Altrimenti cercalo a 20ø pi— */
   if (range=(scan(gradi-20,10)!=0)) /* a destra */
   {
    gradi-=20;
    if (range>41)                    /* Se c' Š allora sparalo */
    {
     cannon(gradi,range);
     cannon(gradi,range);
    }
   }
  }
 }
}



/* Procedura di controllo della quantit… di robot da un angolo */
con90()
{
 x1=dirmin-20;
 cont=0;
 while (x1<=(dirmax+20)) cont+=(scan(x1+=20,10)!=0);
}


