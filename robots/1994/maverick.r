/*        DATI ANAGRAFICI DELL' AUTORE




Maverick  è  composto  principalmente  da 2  parti, ovvero  durante la
battaglia usa 2 tattiche diverse: la prima ( main() ) si svolge fino a
quando in  battaglia ci sono 2 robot ( compreso Maverick ): in pratica
il robot arriva alla parete est  dove  parte per la parete nord con un
angolo di 115ø, arrivato  alla  parete nord, parte per la parete ovest
con un angolo di 195ø, quindi parte per la parete sud con un angolo di
285ø, infine  ritorna  alla  parete  est con un angolo di 15ø e quindi
ripete il ciclo. Ogni volta  che  arriva  ad  una  parete controlla il
numero di robot con  cui  sta combattendo, se questo numero è uguale a
1 allora viene eseguita la seconda parte ( hard() ) in cui il robot fa
uno scontro corpo a corpo con l'ultimo rimasto. In caso di  esclusione
di uno dei due robot (RANDWALL.r e MAVERICK.r) la preferenza verte  su
MAVERICK.r. */



int gradi,range,d,cont,t,to,tg,x,y,x1,r,g,or;



main()
{
           /*       PRIMA TATTICA        */

 range=0;

 /* Primo controllo per la quantità di robot avversari */
 g-=6;
 con();
 if (cont<2) hard();
 /* Se i robot che vedi sono meno di due, allora esegui hard() */


 /* Vai verso la parete Est */
 while (loc_x()<900)
 {
  or=range;
  range=scan(g+=12,6);
  drive(0,100);
  if ((range+range-or)>41) cannon(g,range+(range-or));
 }
 drive(0,0);



 while (1)
 {
  /* Secondo controllo della quantit… di robot */
  g=73;
  cont=0;
  while (g<=270) cont+=(scan(g+=17,10)!=0);
  if (cont<2) hard();


  /* Vai verso la parete Nord */
  while (loc_y()<900)
  {
   drive(115,100);
   r=scan(115,3);                 /* Guarda avanti */
   if ((r>40) && (r<700))         /* Se ci sono robot spara */
   {
    cannon(115,r);
    cannon(115,r);
   }
   r=scan(205,3);                 /* Guarda verso il centro dello schermo*/
   if ((r>40) && (r<700))         /* Se ci sono robot spara */
   {
    cannon(205,r);
    cannon(205,r);
   }
   r=scan(295,3);                 /* Guarda indietro */
   if ((r>40) && (r<700))         /* Se ci sono robot spara */
   {
    cannon(295,r);
    cannon(295,r);
   }
  }
  drive(115,0);

  /* Terzo controllo per la quantit… di robot */
  g=173;
  cont=0;
  while (g<=360) cont+=(scan(g+=17,10)!=0);
  if (cont<2) hard();


  /* Vai verso la parete Ovest */
  while (loc_x()>100)
  {
   drive(195,100);
   r=scan(195,3);                   /* Guarda avanti */
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(195,r);
    cannon(195,r);
   }
   r=scan(285,3);                   /* Guarda verso il centro dello schermo*/
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(285,r);
    cannon(285,r);
   }
   r=scan(15,3);                    /* Guarda indietro */
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(15,r);
    cannon(15,r);
   }
  }
  drive(195,0);

  /* Quarto controllo per la quantit… di robot */
  g=163;
  cont=0;
  while (g<=360) cont+=(scan(g+=17,10)!=0);
  if (cont<2) hard();


  /* Vai verso la parete Sud */
  while (loc_y()>100)
  {
   drive(285,100);
   r=scan(285,3);
   if ((r>40) && (r<700))           /* Guarda avanti */
   {                                /* Se ci sono robot spara */
    cannon(285,r);
    cannon(285,r);
   }
   r=scan(15,3);                    /* Guarda verso il centro dello schermo*/
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(15,r);
    cannon(15,r);
   }
   r=scan(105,3);                   /* Guarda indietro */
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(105,r);
    cannon(105,r);
   }
  }
  drive(285,0);


  /* Quinto controllo della quantit… di robot */
  g=-17;
  cont=0;
  while (g<=180) cont+=(scan(g+=17,10)!=0);
  if (cont<2) hard();

  /* Ritorna alla parete Est */
  while (loc_x()<900)
  {
   drive(15,100);
   r=scan(15,3);                    /* Guarda avanti */
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(15,r);
    cannon(15,r);
   }
   r=scan(105,3);                   /* Guarda verso il centro dello schermo*/
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(105,r);
    cannon(105,r);
   }
   r=scan(195,3);                   /* Guarda indietro */
   if ((r>40) && (r<700))           /* Se ci sono robot spara */
   {
    cannon(195,r);
    cannon(195,r);
   }
  }
  drive(15,0);
 }
}

                 /* SECONDA TATTICA */

hard()
{
 while(1)
 {
  while (!(range=scan(gradi+=20,10))); /* Fino a quando no vedi nessuno*/
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
    cannon(gradi,range);
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

con()
{
 x1=-18;
 cont=0;
 while (x1<=360) cont+=(scan(x1+=18,10)!=0);  /* Fino a quando x1 Š minore*/
}                                             /* di 360ø incrementa la */
                                              /* variabile cont ogni volta */
                                              /* che vedi un robot */
