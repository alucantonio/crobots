/*
   NOME CROBOT:   instict.r        CATEGORIA : 1000 istruzioni
 
   AUTORE :   Bellerino Salvo
     
  
         Il robot attacca gli spazi che analizza.
         Risulta essere una facile preda per gli avversari. 

*/

int range;
int grado;

main()
{
  int init;
  init = rand(360);
  grado=init;
  while (1)
  {
     drive(grado,100);          /* Corre sullo spazio */
     range=scan(grado,5); 
     if (range!=0)
     { 
        attacco();              /* Attacca il crobots */
     }   
     else
        grado=(grado+10) % 360;
     
  } 
}


attacco()
{
   int d1;
   d1=damage();
   cannon(grado,range);
   range=scan(grado,5);
   d1=damage();
   while ( (range!=0) && (d1==damage()) ) 
   { 
      cannon(grado,range);
      range=scan(grado,5);
   } 
   if (range==0)
   {
      range = scan(grado+15,5);
      if (range!=0)
      {
         grado = grado + 15;
	 attacco();
      }
      else
      {
         range = scan(grado-15,5);
	 if (range!=0)
	 {
	    grado = grado - 15;
	    attacco();
	 }
      
      }
   }
}

