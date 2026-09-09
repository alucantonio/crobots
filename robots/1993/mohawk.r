/* - MOHAWK.R

   - Programmato da     Diego Gallizioli */


  int degree; /* le variabili sono tutte dichiarate esterne; cos sia   */
  int range;  /* la procedura SHOT() che MAIN() possono utilizzarle.    */
  int repeat;


main()
{
  drive(269,100);
  while (loc_y()>60);
  drive(270,0);       /* si avvicina alla parete inferiore del quadrato */
  while (speed()>50);
  degree=0;  /* direzione : 0 gradi */
  while (1)           /* ciclo continuo; il programma non si fermer… pi— */
   {
    drive(degree,95); /* inizia a muoversi */
    if (degree==0)      /* tutti gli IF con degree servono per la distanza */
     {                  /* dalla parete; avvicinatosi a sufficenza il robot */
      while (loc_x()<930)  /* (virtuale) rallenta e gira .                  */
      {  shot();   }
      }
     if (degree==90)
     {
      while (loc_y()<930)
       {  shot();  }
      }
     if (degree==180)
     {
      while (loc_x()>70)
      {   shot();  }
      }
     if (degree==270)
     {
      while (loc_y()>70)
      {   shot();  }
      }
      drive(degree,0);  /* il muro Š vicino : FRENA !! */
      while (speed()>48);  /* rallenta a mezza velocit… ...  */
      degree=degree+90;    /* cambia direzione di 90 gradi (segue le pareti)*/
      if (degree==360) degree=0;
   }
 }

 /*    Fine procedura principale.  */
 /*    Inizio funzione per colpire l'avversario. */

 shot()
 {
   range=scan(degree,5);
   if (range>0 && range<=710) cannon(degree,range);
   range=scan(degree+45,5);
   if (range>0 && range<=710) cannon(degree+45,range);
   range=scan(degree+90,5);
   if (range>0 && range<=710) cannon(degree+90,range);
   range=scan(degree+135,5);
   if (range>0 && range<=710) cannon(degree+135,range);
   range=scan(degree+180,5);
   if (range>0 && range<=710) cannon(degree+180,range);
  }
