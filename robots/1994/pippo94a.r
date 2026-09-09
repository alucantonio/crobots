/*
 Pippo94a.r

 Andrea Creola

 Tattica :
  Fino a quando il danneggiamento(damage) risulta minore di 8% il robot
  non si muove, poi genera un numero casuale, se questo è uno zero
  esegue la prima tattica, latrimenti la seconda.
  La prima (caso_b) : Il robot si muove in prossimità del perimentro del
                      campo di gioco. Ad ogni angolo calcola il danneggiamento
                      (damage) e fino a quando questo non incrementa di 5
                      unità sta li fermo.
  La seconda (caso_a) : Il robot controlla se si trova alla  destra del centro
                        del campo o alla sinistra. Nel primo caso si porta
                        sul lato destro, altrimenti sul lato sinistro.
                        quando arriva alla destinazione si muove in su e in
                        già. La prima volta che raggiunge la sommità
                        dell'arena, li vi rimane fino a quando i danni subiti
                        sono inferiori del 15%
  Funzione di sparo : Questa funzione, controlla se trova un avversario
                      nella direzione corrente, in caso positivo, controlla
                      se è a una distanza accettabile, se la risposta è
                      affermativa, esegue un controllo con un 'range' di
                      errore inferiore e se l'avversario non lo trova
                      prova a cercarlo aggiungendo una deviazione all'angolo
                      in base al presunto spostamento dell'avversario.
*/
int sp;           /* 1 -> colpo sparato , 0 -> colpo non sparato */
int rangef;       /* forza con cui sparare */
int ang;          /* Angolo primario per lo sparo */
int range;        /* Disatanza dl nemico corrente */
int sfas;         /* Sfasamento dell'angolo */
int rangepr;      /* Disatanza del nomico precedente */
int app;          /* Serve per fare molte cose  */
int old_dam;      /* serve per ricordare il damage a ogni 'fermata' */
int dir;          /* direzione da seguire  */

/********** MAIN **********/
main()
{
 int caso;

 while(damage()<8) spara();

 caso=rand(2);
 if(!caso) caso_b();
 caso_a();
 }
/********** CASO B **********/
caso_b()
{
 old_dam=damage();
 while(1)
  {
   old_dam=damage();
   while(damage()<old_dam+5) spara();
   drive(000,100);
   while(loc_x()<900) spara();
   drive(090,000);
   while(speed()>50);

   old_dam=damage();
   while(damage()<old_dam+5) spara();
   drive(090,100);
   while(loc_y()<900) spara();
   drive(180,000);
   while(speed()>50);

   old_dam=damage();
   while(damage()<old_dam+5) spara();
   drive(180,100);
   while(loc_x()>100) spara();
   drive(270,000);
   while(speed()>50);

   old_dam=damage();
   while(damage()<old_dam+5) spara();
   drive(270,100);
   while(loc_y()>100) spara();
   drive(000,000);
   while(speed()>50);
  }
}
/********** CASO A **********/
caso_a()
{
 if (loc_x()>500)
  {
   drive(000,100);
   while(loc_x()<950) spara();
   drive(090,000);
   while(speed()>50) spara();
  }
 else
  {
   drive(180,100);
   while(loc_x()>050) spara();
   drive(090,000);
   while(speed()>50) spara();
  }

 while(damage()<16) spara();
 while(1)
 {
  app=scan(180,180);
  if ((app<700) || (damage()>50))
   {
    drive(090,085);
    while(loc_y()<900) spara();
    drive(270,000);
    while(speed()>50) spara();
    while(damage()<15) spara();
   }
  else spara();

  app=scan(180,180);
  if ((app<700) || (damage()>50))
   {
    drive(270,085);
    while(loc_y()>050) spara();
    drive(090,000);
    while(speed()>50) spara();
   }
  else spara();
 }
}
/********** SPARA **********/
spara()
{
 if(rangepr=scan(ang,10))
  {
   if (rangepr>700)
    {
     ang+=19;
     sp=1;
     return;
    }


   if (!sp)
    {
     app=5;
     while(--app);
    }

   if (range=scan(ang,1)) sfas=0;
   else if(range=scan(ang+=4,2)) sfas=7;
   else if(range=scan(ang+=355,2)) sfas=350;
   else if(range=scan(ang+=12,2)) sfas=10;
   else if(range=scan(ang+=340,2))sfas=350;
   else if(range=scan(ang+=20,2)) sfas=15;
   else if(range=scan(ang+=335,2)) sfas=350;

   else
        {
         app=5;
         while ((!(scan(ang+=32,9)))&&(--app));
         return;
        }

   rangef=range*(233+range-rangepr)/228;
   if (rangef<700)
    {
     sp=cannon(ang+sfas,rangef);
     if (!sp)sp=cannon(ang+sfas,rangef);
    }
   else sp=0;
   rangepr=range;
  }
 else
  {
    app=15;
    while ((!(scan(ang+=16,8)))&&(--app));
  }
}
 

