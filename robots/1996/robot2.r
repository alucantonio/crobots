/* ------------------ R O B O T 2 . R ----------------------------*/
/* Autore:      Turino Andrea

   Robot1 e Robot2 derivano dallo stesso scheletro. L'unica differenza
   tra i due Š che robot1 si muove sempre, robot2 no.
   Nel caso si rendesse necessario limitare la partecipazione a un robot
   vorrei veder combattare ROBOT1.R


   SCHEDA TECNICA DEL ROBOT(ROBOT2):

   Il robot si porta sul lato alto dello schermo e si ferma su uno
   dei due angoli dove resta fermo finch‚ non Š colpito.
   Vi sono due routine di fuoco, una per quando il robot Š fermo (spf)
   e l'altra in per quando il robot si muove (spm). La prima cerca di
   predire la posizione successiva del robot trovato attraverso tre
   scansioni, la seconda spara appena Š stato individuato un robot e
   quindi Š meno efficiente.
   Se il robot non Š stato colpito per un certo periodo si sposta
   (sempre che i danni siano inferiori a 90) nell'altro angolo, mentre
   se i danni sono superiori a 90 il robot resta fermo sperando di non
   essere colpito.
   Come ultima caratteristica il robot se capisce che c'Š un solo altro
   sopravvissuto (attraverso la routine nrobot) si sposta al centro
   e continua a muoversi compiendo una traiettoria circolare. In questa
   fase il robot Š abbastanza efficiente in quando Š molto difficile da
   individuare .
*/
                    


int dir, ango;

main()
{
    int dam, olddam, nr, lm, y, time, limtime;

    /* inizializzazione  variabili */
    nr=0;
    time=0;
    limtime=300;
    lm=250;
    dir=180;
    /* si muove in basso */
    while ((y=loc_y())<950)
    {   drive(90,100);
        if (y>200)
          spm();
    }
    drive(0,0);
    olddam=damage();
    while (1)              /* inizia ciclo */
    {
          nr=0;
          /* se il time Š maggiore del limite guarda quanti robot */
          if (time>limtime)
             if(nrobot()<=1)
                circle();
          /* il robot Š fermo e spara */
          while (((damage()-olddam)==0 && nr<lm) || olddam>=90)
          {
                 spf();
                 nr+=1;
          }
          limtime-=nr/25;
          lm+=olddam/4;
          time+=nr;
          /* cambia angolo */
          move();
          dir=(dir+180)%360;
          olddam=damage();
    }
}

spf() /* spara da fermo */
{
   int x, x1, x2, an;

   an=ango;
   /* cerca tre volte il robot e cerca di 'indovinare' la nuova posizione */
   if (x=trova())
   {
      if (x1=trova())
         if (x2=trova())
         {
            x=x2+2*(x2-x);
            ango+=(300+x)*(ango-an)/900;
            cannon(ango, x);
            cannon(ango,x);
         }
         else
         {
            cannon(ango, x1);
            cannon(ango, x1);
         }
      else
         {
           cannon(ango, x);
           cannon(ango, x);
         }
   }         
   else
          ango-=20;
}                             

move() /* muove da un angolo all'altro il robot */ 
{
    int x;

    if (dir==0)
        while ((x=loc_x())<900)
        {   drive(dir,100);
            spm();
        }
    else
        while ((x=loc_x())>100)
        {   drive(dir,100);
            spm();
        }
       while (speed())  /* lo ferma */
       {
          drive(0,0);
          spm();
       }
}

trova()  /* routine base per la spf, cerca il robot */
{
  int x, x1;

  if ((x=scan(ango, 10))>0 && x<900)
    if ((x1=scan(ango+4, 2))>0)
        ango+=4;
    else
       if ((x1=scan(ango-4, 2))>0)
          ango-=4;
       else
         if ((x1=scan(ango+8, 5))>0)
            ango+=8;
         else
            if ((x1=scan(ango-8, 5))>0)
               ango-=8; 
            else
               return(x);
  else
    return(0); 
  return(x1);
}

spm() /* sparo in movimento, guarda con precisione 10 se trova spara e
         quindi guarda con precisione inferiore */
{
        int x, x1;
        
        if ((x=scan(ango, 10))>0 && x<900)
        {       
                cannon(ango, x);
                if ((x1=scan(ango+4, 2))>0)
                {
                   ango+=6;
                   cannon(ango, x1);
                }
                else
                    if ((x1=scan(ango-4, 2))>0)
                    {
                        ango-=6;
                        cannon(ango, x1);
                    }
                    else
                       if ((x1=scan(ango+10, 6))>0)
                       {
                           ango+=15;
                           cannon(ango, x1);
                        }
                        else   
                           if ((x1=scan(ango-10, 6))>0)
                           {
                                ango-=15;
                                cannon(ango, x1);
                            }
        }
        else
          ango-=20;
}


circle()  /* il robot si muove in cerchio, dovrebbe restare un unico altro
             robot */   
{
    if (loc_x()<500)
       while(loc_x()>100)
       { 
          spm();
          drive(180,100);
       }
    else
       while(loc_x()<900)
       { 
          spm();
          drive(0,100);
       }
    iniz1();
    dir=180;
    while (1)
    {
       spm();
       dir=(dir+35)%360;
       drive(dir, 100);
       spm();
    }
}    

iniz1() /* dalla posizione iniziale mi porta al centro */
{
    int x, y;

    y=loc_y();
    x=loc_x();
    if (x>500 && y>500)
       dir=atan(100000*(y-500)/(x-500))+180;
    else
       if (x<500 && y>500)
          dir=atan(100000*(y-500)/(500-x))+270;
       else
          if (x>500 && y<500)
             dir=atan(100000*(500-y)/(x-500))+90;
          else
                dir=atan(100000*(500-y)/(500-x));
    while ((x>550 || x<450) && (y>550 || y<450))
    {   drive(dir,100);
        spm();
        x=loc_x();
        y=loc_y();
    }
    drive(0,0);
}

int nrobot() /* conta il numero di robot; non Š sicurissima perchŠ un robot
                pu• essere 'nascosto' dietro un altro (cioŠ nello stesso
                range di scansione */
{
   int an, a, nr, x;

   nr=0;
   an=0;
   a=180;
   while (an<=a)
   {
      if ((x=scan(an, 5))>0)
      {
          nr+=1;
          if (x<750)
             ango=an;
          if (nr>1)
             return(nr);
      }
      an+=10;
   }
   return(1);
}
