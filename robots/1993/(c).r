/*NOME DEL CROBOT:         (C).R                                             
  IDEATORE:                CARLO PERICH                                       

  CARATTERISTICA:Si muove alternatamente sia sulle diagonali e sia sul        
  perimetro, ma se i danni superano il 35% allora non si espone pi—           
  direttamente alla battaglia, ma costeggia solo un lato del perimetro; 
  la rutine di fuoco si basa su di un algoritmo che aumenta o decresce 
  all'occorrenza l'angolo di tiro di 18ø  */

/* distaza rilevata dalla scan del robot avversario */
int  ang,newrange,oldrange;
main()

{ripeti1();
 sinistra();
 su();
 giu();
 diag1();
 ripeti2();
 diag2();
 ripeti3();
 su();
 diag3();
 ripeti4();
 diag4();
}                
		
/*se i danni superano il 35% non esporti pi—*/
ripeti1()
{
 if (damage()>=35)
  {while(1)
     {giu();
      su();
      }
  }
}
ripeti2()
{
 if (damage()>=35)
  {while(1)
     {sinistra();
      destra();
      }
  }
}
ripeti3()
{
 if(damage()>=35)
   {while(1)
      {destra();
       sinistra();
       }
   }
}

ripeti4()      
{
 if(damage()>=35)
 {while(1)    
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
{ if (newrange=scan(ang,8))
  {if (oldrange<newrange)
       {cannon(ang,8*newrange/7);
	oldrange=newrange;}
   else
   {cannon(ang,7*newrange/8);
    oldrange=newrange;}}
   else
 { ang+=16-(scan(ang+3,8)!=0)*16;}
}
