/*
   NOME CROBOT:   FourSquare.r     CATEGORIA : 500 istruzioni
 
   AUTORE :   Bellerino Salvo
     
  
        Il robot rimane fermo nella sua posizione analizzando in senso antiorario 
        il campo di battaglia e sparando ad eventuali crobots avvistati.
        Qualora venisse riscontrato un aumento dei danni, il robot si sposta dalla
        sua posizione passando casualmente in uno degli altri tre quadranti.

*/


int grado;            /* Variabile per la scansione dei gradi */


main()
{
  int init;
  init = rand(360); 
  grado=init;         /* Parto la scansione da un'angolazione casuale */  
  while(1)
  {
    check();          /* Analizza campo di battaglia */
    move();           /* Cambia quadrante */
  }
}


/* Analizzo ed eventualmente sparo (parametro g e' il grado) */ 
int sorb(g)
int g;
{
  r = scan (g,10);
  if ((r!=0) && (r<701))
  {
     cannon(g,r);
     grado=g;           /* Memorizzo grado dove e' presente un bersaglio */
  }
}

/* Analizza una serie di angolazioni notevoli soggette ad una oscillazione casuale */
stella()
{
  int c;
  c=rand(30);
  sorb(225 + c);
  sorb(160 + c); 
  sorb(80 + c);
  sorb(20 + c);
  sorb(120 + c);
  sorb(grado);  /* Grado dove e' stato riscontrato l'ultimo bersaglio */
}

/* Restituisce il numero del quadrante dove si trova il crobots */
int quadrante()
{
   int x;
   int y;
   x=loc_x();
   y=loc_y();
   if (x<500)
        if (y<500)
           return 3;
        else
           return 2;
   else
      if (y<500)
         return 4;
      else
         return 1;   
}

/*Calcola la distanza tra il punto dove si trova il crobots e il punto (x1,y1) */
distance(x1,y1)
int x1;
int y1;
int x2;
int y2;
{
  int x2;
  int y2;
  int xd;
  int yd;
  int d;
  x2 = loc_x();
  y2 = loc_y();
  xd = x1 - x2;
  yd = y1 - y2;
  d = sqrt((xd*xd) + (yd*yd));
  return(d);
}

/* Analizza il campo di battaglia in senso antiorario */
check()
{ 
   int range; 
   int conta;
   int d;
   d=damage();
   conta = 0;
   while ( (d == damage()) && (conta < 100) )  
   { 
      range=scan(grado,7); 
      if  ((range!=0) && (range < 710) )
      {           
         cannon(grado,range);
         conta = 0;
      }  
      else
      { 
         grado=(grado+15) % 360;
         conta = conta + 1;
      }
   }
}

/* Cambio quadrante */
move()
{
   int dir;
   int q;
   int ang_cas;
   int x;
   int y; 
   ang_cas = rand(90); 
   x=loc_x();
   y=loc_y();
   q=quadrante();
   if (q==1)
   { 
      dir = 180 + ang_cas;
      drive(dir,100);
      while( distance(x,y) < 400 )
         stella();
      drive(dir,0);
      while( speed() > 49 ) 
         stella();
   }
   else
   if (q==2)
   { 
      dir = 270 + ang_cas;
      drive(dir,100);
      while( distance(x,y) < 400 )
         stella();
      drive(dir,0);
      while( speed() > 49 ) 
         stella();
         
     }
     else
     if (q==3)
     { 
        dir = 0 + ang_cas;
        drive(dir,100);
        while( distance(x,y) < 400 )
           stella();
        drive(dir,0);
        while( speed() > 49 ) 
           stella();
     }
     else
     if (q==4)
     {
        dir = 90 + ang_cas;
        drive(dir,100);
        while( distance(x,y) < 400 )
           stella();
        drive(dir,0);
        while( speed() > 49 ) 
           stella();
     }
  }

 

