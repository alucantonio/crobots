/*
   NOME CROBOT:   frame.r          CATEGORIA : 500 istruzioni
 
   AUTORE :   Bellerino Salvo
     
  
       Il robot corre continuamente lungo il perimetro del campo di battaglia.
       Controlla continuamente un elenco di angolazioni notevoli e spara se 
       eventuali robot vengono avvistati.  

*/


main()
{
  piazzamento();      /* il robot si porta nell'angolo in alto a sinistra */
  while (1)
  {
     movimento();     /* il robot corre lungo il perimetro del campo di battaglia */
  }    
}

/* analizza l'angolazione g (parametro) ed eventualmente spara */
sorb(g)
int g;
{
  int r;
  r = scan (g,10);
  if ((r!=0) && (r<701))
     cannon(g,r);
}


/* controllo di un elenco di angolazioni notevoli */
stella()
{
   int cas;
   cas = rand(20);
   sorb(355 + cas);
   sorb(40 + cas);
   sorb(85 + cas);
   sorb(130 + cas);
   sorb(175 + cas);
   sorb(220 + cas);
   sorb(265 + cas);
   sorb(310 + cas);
}


/* il robot si porta nell'angolo in alto a sinistra */
piazzamento()
{   
     drive(90,100);
     while( loc_y() < 800 ) 
         stella();
     drive(90,0);
     while(speed()>49) 
         stella();
     drive(180,100);
     while( loc_x() > 200 ) 
        stella();
     drive(0,0);
     while(speed()>49) 
         stella();
    
}

scendi()
{
    drive(270,100);
    while( loc_y() > 200 ) 
        stella();
    drive(270,0);
    while (speed() > 49)
       stella();
}


sali()
{
    drive(90,100);
    while( loc_y() < 800 )   
       stella(); 
    drive(90,0);
    while(  speed() >49 )
       stella(); 
}


destra()
{
   drive(0,100);
    while( loc_x() < 800 ) 
       stella();
    drive(0,0);
    while (speed() > 49)
       stella();    
}


sinistra()
{
    drive(180,100);
    while( loc_x() > 200 )   
       stella(); 
    drive(180,0);
    while(  speed() >49 )
       stella();
}

/* il robot corre lungo il perimetro del campo di battaglia */
movimento()
{   
   scendi();
   destra();
   sali();
   sinistra();
} 

 


