/*					N3g4tivo (midi)

Programmato da:    Antonino Chiaia
                   
Premesse:          Questo è il mio primo robot
                   La routine di fuoco l'ho presa da qualche robot di cui non ricordo il nome

Strategia:         N3g4tivo come al solito si piazza nell'angolo più vicino
                   -se si trova in un f2f compie un movimento su un lato sparando
                   -se ci sono più di un avversario si ferma in un angolo sparando
                     e si muove solo in caso subisce dei danni


*/

int avv,ang;				/* funzione contaAvversari */
int controllo,dam,range,dir,cont;	/* funzione main           */

main()
{
  while(1)
   {
    controllo=50;     /* stabilisce ogni quanto verifico il numero dei nemici */
    if (loc_x()<500) sx(); else dx();  /* vado nell'angolo più vicino */
    if (loc_y()<500) dw(); else up();  /*                             */
    if(contaAvversari()==1)
      {
       while(controllo>0)
         {
          /* Mi trovo qui quando c'è solo un avversario nell'arena */
          if(range>750 || (!range)) { if((cont+=1)>10) {reazione(2); cont=0;} }
          else cont=0;
          reazione();
          fire();
          --controllo;
         }
      }
    else
      {
       while(controllo>0)
         {
          /* Mi trovo qui quando c'è più di un avversario nell'arena */
          dam = damage();
          fire();
          --controllo;
          if (damage()>dam+4) { dam=damage(); reazione(); }
          if(range>750 || (!range)) { if((cont+=1)>50) {reazione(1); cont=0;} }
          else cont=0;
         }
      }
   }
}

/************************************************************************/
/*   Restituisce 1 se siamo in un f2f;                                  */
/*               2 se siamo in più di due robot                         */
/************************************************************************/
contaAvversari()
{
 ang=-10; avv=0;
 while((ang+=20)!=730) if (scan(ang,10)) ++avv;
 if(avv<3) return 1;	/* avv=2 se c'è solo un avversario perchè il radar fa due giri */
 return 2;
}

/************************************************************************/
/*   se !opz    ---------> cambia angolo se puo                         */
/*   se  opz=1  ---------> compie mezzo giro forzato                    */
/*   se  opz=2  ---------> compie un giro forzato                       */
/************************************************************************/
reazione(opz)
{
 if (loc_y()>500 && (!opz)) {if (!scan(260,10) && !scan(280,10)) return dw();} /* vado sotto */
 else if(!opz)              {if (!scan(80,10) && !scan(100,10))  return up();} /* vado sopra */
 
 if(loc_x()<500)
   {
    if(opz)      { dx(up()); if(opz==2) sx(dw()); return; }
    else         { if (!scan(350,10) && !scan(10,10)) dx();}   /* vado a destra   */
   }
 else if(loc_x()>500)
   {
    if(opz)      { sx(up()); if(opz==2) dx(dw()); return; }
    else         { if (!scan(170,10) && !scan(190,10)) sx();}  /* vado a sinistra */
   }
 return 3;       /* se arrivo qui significa che il tentativo di spostarsi non è riuscito */
}

/************************************************************************/
/*   sx(), dx(), dw(), up() servono a spostarsi  rispettivamente        */
/*   verso sinistra, destra, in basso ed in alto                        */
/*   finchè non si raggiunge il perimetro del campo.                    */
/************************************************************************/
up() { while(loc_y()<930) { fire(drive(90,100));  } drive(270,0); }
dw() { while(loc_y()>70)  { fire(drive(270,100)); } drive(90,0);  }
dx() { while(loc_x()<930) { fire(drive(0,100));   } drive(180,0); }
sx() { while(loc_x()>70)  { fire(drive(180,100)); } drive(0,0);   }

/************************************************************************/
fire()
{
if ((range=scan(ang,7))&&range<1050)
  {
   if (range<100) return cannon(ang,range);
   else
     cannon(ang+=4*(!(scan(ang+355,6)))+356*(!(scan(ang+5,6))), 3*scan(ang,10)-2*range);
  }
else if (range=scan (ang-=16,10));
else if (range=scan (ang+=32,10));
else if (range=scan (dir,10)) ang=dir;
else if (!(range=scan (ang+=32,10))) ang+=30;
}


/*








  ########################################################################
  ##   __   _   _____   ______   _    _       ____   _   _____   _____  ##
  ##  |||  ||  ||||||  |||||||  ||   ||      |||||  ||  ||||||  ||||||  ##
  ##  |||| ||    __||  ||  ___  ||___||  ___ ||     ||  ||__||  ||  ||  ##
  ##  || ||||   |||||  || ||||  ||||||| |||| ||     ||  ||||||  ||  ||  ##
  ##  ||  |||   ___||  ||___||       ||      ||___  ||  ||  ||  ||__||  ##
  ##  ||   ||  ||||||  |||||||       ||      |||||  ||  ||  ||  ||||||  ##
  ##                                                                    ##
  ########################################################################
*/



