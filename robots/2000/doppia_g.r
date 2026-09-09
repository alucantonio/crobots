/*

   Doppia_G.R
   Torneo 2000

   Autore:

     Fusco  Luigi

  Salve amici di "CRobots Land" Sono Fusco Luigi e questo è il mio primo Robottino.
  Vi chiedo scusa già da adesso perchè so che non è un granchè, siccome ho avuto
  meno di un mese per prepararlo, ma ci tenevo a farlo partecipare comunque.
  Vi chiederete dove sono andato a pescare il nome Doppia_G immagino, vero?
  In effetti non è altro che un modo un pò buffo con cui ho trasformato il mio
  nome(Doppia_G = GG = Gigi = Luigi).Spero che di riuscire in futuro a creare robot
  sempre + agguerriti e magari di vincere anche qualche torneo (BOOOOM !!!!).
  
  ------------------------------------Strategia------------------------------------

  Il mio robottino non fa altro che andare verso l'angolo più vicino e iniziare  ad
  oscillare descrivendo un quarto di circonferenza. Ad ogni oscillazione fa un con-
  trollo sui danni e se ne ha ricevuto + del 10% cambia angolo,controlla quello più
  vicino in diagonale, se è libero vi si reca,altrimenti va in quello adiacente nel
  senso orizzontale. Doppia_G ha a disposizione 2 funzioni di attacco,una veloce ma
  poco precisa che usa durante le oscillazioni, l'altra un pò più precisa che  uti-
  lizza tra un'oscillazione e l'altra, prima del controllo sui danni.

  ----------------------------------Ringraziamenti---------------------------------

  Ringrazio innanzi tutto La redazione della  rivista  "Io Programmo"  grazie  alla
  quale sono venuto a conoscenza dei CRobots; ringrazio Tom Poindexter  per  averli
  creati; ringrazio poi tutti i Crobotters dalle cui creazioni ho potuto  conoscere
  meglio i CRobots; ringrazio infine Pagnotta Graziano (Un  altro  partecipante  al
  torneo di quest'anno) che mi ha dato molti consigli utili al riguardo.

  Cos'altro posso dirvi? Spero di non arrivare ultimo. Arrivederci.

*/

int CurDir;         /*La mia direzione corrente*/
int CurAng;         /*Il mio angolo di scansione corrente*/
int Danni;          /*L'ammontare dei miei danni attuali*/
int Quad;           /*Quadrante in cui mi trovo attualmente*/
int Dist;           /*La distanza tra me e i nemico cheho individuato*/
int Vel;            /*La mia velocit… corrente*/
int Cx,Cy;          /*Coordinate del centro della circonferenza che percorro*/
int Raggio;         /*Raggio della circonferenza che percorro*/
int Segno,Increm;   /*Parametri che i servono per creare Il moto rotatorio*/
int CurX,CurY;      /*Coordinate della mia posizione corrente*/
int GoX,GoY;        /*Coordinate dalla mia attuale destinazione*/

/*Procedura che mi serve per calcolare la distanza
  tra me e il punto P=(X,Y)*/

Distanza(X,Y) { return(sqrt(((X-=loc_x())*X)+((Y-=loc_y())*Y))); }

/*Procedura che mi serve per calcolare la direzione che devo prendere
  per arrivare a P=(X,Y)*/

CercaDir(X,Y)
{
 int Xx,Yy,At;

 Xx = X - CurX;
 Yy = Y - CurY;
 if (!Xx)
  if (Yy < 0) At = 270; else At = 90;
 else At = atan((100000 * Yy)/Xx);
 if (At < 0) At += 180;
 if (Yy < 0) At += 180;
 return(At);
}

/*Procedura che mi serve per arrivare nel punto P=(X,Y)*/

GoNow(X,Y)
{
 int C;

 CurDir = CercaDir(X,Y);    /*Cerco la direzione*/
 drive(CurDir,Vel);         /*Parto*/
 while(Distanza(X,Y) > 40)  /*Continuo finchŠ arrivo*/
 {
  /*Mi guardo intorno*/
  CurAng = CurDir;
  C = 0;
  while (++C < 4)
  {
   CurAng += 90;
   Dist = scan(CurAng,5);
   if ((Dist > 40)&&(Dist <= 700)) while(cannon(CurAng,Dist));
  }
 }
 while(speed()) drive(CurDir,0);                           /*Freno*/
}

/*Procedura che mi serve per spostarmi in un deterinato angolo*/

SetCorner()
{
 int Ang,Vert;

 if (Quad == -1)              /*Imposto l'angolo in cui devo andare*/
 {
  CurX = loc_x();
  CurY = loc_y();
  if (CurY > 500)
    if (CurX > 500) Quad = 0;
    else Quad = 1;
  else
    if (CurX > 500) Quad = 3;
    else Quad = 2;
 }
 else
 {
  Vert = 0;
  if (Quad < 2)
  {
   if ((!scan(260,10))&&(!scan(280,10))) Vert = 1;
   if (Vert) { ++Quad; if (Quad == 1) Quad += 2; }
   else { ++Quad; if (Quad == 2) Quad -= 2; }
  }
  else
  {
   if ((!scan(80,10))&&(!scan(100,10))) Vert = 1;
   if (Vert) { --Quad; if (Quad == 2) Quad -= 2; }
   else { --Quad; if (Quad == 1) Quad += 2; }
  }
 }

 /*Setto i vari parametri in funzione dell'angolo in cui devo andare*/
 if      (Quad == 0)  { Cx = Cy = 900; Segno = -1; Increm = -50; }
 else if (Quad == 1)  { Cx = 100; Cy = 900; Segno = 1; Increm = -50; }
 else if (Quad == 2)  { Cx = Cy = 100; Segno = 1; Increm = 50; }
 else                 { Cx = 900; Cy = 100; Segno = -1; Increm = 50; }
 GoX = Cx + (Segno * Raggio);
 GoY = Cy;

 GoNow(GoX,GoY);       /*Vado nel suddetto angolo*/
}

/*Procedura che mi serve per la scansione di una determinata area*/

CercaRobots(An,Fine)
{
 int Ang;
 Ang = An - 8;
 Dist = 0;
 while((Dist <= 40)||(Dist > 700))
 {
  Ang += 16;
  if (Dist = scan(Ang,8))
  {
   if(Dist = scan(Ang -= 4,4))
   {
    if(Dist = scan(Ang -= 2,2)) while(cannon(Ang,Dist));
    else
    if(Dist = scan(Ang += 4,2)) while(cannon(Ang,Dist));
   }
   else
   if(Dist = scan(Ang += 8,4))
   {
    if(Dist = scan(Ang -= 2,2)) while(cannon(Ang,Dist));
    else
    if(Dist = scan(Ang += 4,2)) while(cannon(Ang,Dist));
   }
  }
 }
 return(Ang);
}

/*Procedura che mi serve per attaccare gli avversari individuati*/

Attacco()
{
  int MyAng;
  MyAng = 170 + (Quad * 90);
  CurAng = CercaRobots(MyAng,MyAng + 110);

}

main()
{
 int MustGo;

 Vel = 100;
 Raggio = 300;
 Quad = -1;
 SetCorner(); /*Vado verso l'angolo pi— vicino*/
 Danni =  damage();
 while(1) /*Oscillo nell'angolo descrivendo un quarto di circonferenza*/
 {
  MustGo = 0;
  CurX = loc_x();
  CurY = loc_y();
  GoY += Increm;
  GoX = Cx + (Segno * sqrt((Raggio*Raggio)-((GoY - Cy)*(GoY - Cy))));
  GoNow(GoX,GoY);
  /*Se sto andando a sbattere contro un muro vado nel verso opposto*/
  if ((GoX == Cx)||(GoY == Cy))
   { Attacco(); Increm *= -1; ++MustGo; }
  /*Se mi attaccano cambio angolo*/
  if ((MustGo)&&((Danni + 10) < (Danni = damage()))) SetCorner();
 }
}