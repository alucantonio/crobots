/*NOME DEL ROBOT:  TM.R                           
  NOME:            CARLO PERICH                   
              
  CARATTERISTICA:  Si muove lungo inizialmente sul lato inferiore dello campo
  poi,una volta superato il 45% di danneggiameto esegue una serie di movimen-
  ti lungo le diagonali dello schermo, infine arrivato al 65% di "damage" 
  inizia un movimento analogo a quello iniziale, con la sola differenza che
  pu• verificarsi lungo uno qualsiasi dei 4 lati dello schermo; la ruotine di 
  attacco Š un algorimo che gli permette di sparare in un angolo di 360ø.  
  L'angolo di tiro  si basa su  una routine di fuoco, che non fa altro che 
  aggiungere o diminuire circa 20ø al precedente rilevamento; le modifiche 
  di tiro, sono state aggiunte dopo numerosi tentativi.
  
  N.B.
  Nel caso si dovesse scegliere nel far combattere uno dei due crobots pre-
  ferisco che si faccia combattere TM.R, grazie.*/


/* distaza e angolo rilevati dallo scan del robot avversario*/
int  ang,newrange,oldrange;

main()
{
 spara();
 giu();
 destra();
 sinistra();
 while(1)
 {
   destra();
    if (damage()=damage()+15)  /* se i danneggiamenti sono troppi */
    {drive(0,0);}              /* si ferma e spara con maggior cura */
    if (damage()>=45)
    {
     controlla4();
     diag4();
     giu();
     while(1)
       {movimento();}
     }
   sinistra();
    if (damage()=damage()+15)
    {drive(0,0);}
    if (damage()>=45)
    {
     while(1)
    {movimento();}
    }
 }
} 
 
 /*procedura del movimento*/ 
 movimento()
  {
   spara();
   controlla1();
   diag1();
   sinistra();
   controlla2();
   diag3();
   su();
   controlla3();
   diag2();
   destra();
   controlla4();
   diag4();
   giu();
  
  }
		 
/*se i danni superano il 65% non esporti pi—*/
controlla1()
{
 if (damage()>=65)
 {while(1)
     {spara();
      destra();
      sinistra();
      }
 }
}

controlla2()
{
 if (damage()>=65)
 {destra();
  while(1)
    {spara();
     giu();
     su();
     }
 }
}

controlla3()
{    
 if (damage()>=65)   
   {while(1)    
      {spara(); 
       sinistra();
       destra();
       }
    }
}

controlla4()       
{
 if (damage()>=65)
   {spara();
    sinistra();
    while(1)
      {su();
       giu();
       }
    }
}
/* a destra */
destra()                
{
  while (loc_x() < 910)  
  {drive(0,100);
   spara();}
}                  

/* in basso */
giu()                
{                
  while (loc_y() > 90)  
  {drive(270, 100);
   spara();}
}              

		
/* a sinistra */
sinistra()
{                
  while (loc_x() >  90)  
  {drive(180, 100);
   spara();}
}               
		
/* diagonale a 45ø*/
diag1()
{                
 while (loc_x() < 910 && loc_y() < 910)  
 {drive(45, 100);
  spara();}
}             

/*diagonale a 225ø*/
diag2()
{                
  while (loc_x() > 90 && loc_y() > 90) 
  {drive(225, 100);
   spara();}
}                 

/*in alto*/
su()                
{
  while (loc_y() < 910 ) 
  {drive(90, 100);
   spara();}
}             
		 
/*diagonale 315ø*/
diag3()
{
  while (loc_x() < 910 && loc_y() > 90) 
  {drive(315, 100);
   spara();}
}
		  
/*diagonale a 135ø*/
diag4()               
{   
   while (loc_x() > 90 && loc_y() < 910) 
   {drive(135, 100); 
     spara();}
}

spara()
{ if (newrange=scan(ang,10))
     {
      if(oldrange<newrange) 
      {cannon(ang,15*newrange/13+3);     /*se Š pi— lontano */ 
      oldrange=newrange;}         
      else
      {cannon(ang,15*newrange/17+3);     /*se Š pi— vicino */
      oldrange=newrange;}        
     }
  else
  ang+=20-(scan(ang-17,8)!=0)*40;   /* algoritmo di fuoco */
}
