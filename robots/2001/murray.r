/*
MURRAY.r

Scritto da:
Angelo Ciufo



Derivato dal micro md9.r,
con l'aggiunta di una migliore toxica e qualche ottimizzazione.

Grazie a Davide Lorenzi per l'ottima base su cui lavorare.

 Inizialmente il microbo si reca nell'angolo piu' vicino e comincia ad oscillare
 parallelamente al muro laterale con un'ampiezza di circa 100 metri.
 Oscilla per 25 volte o finche' un avversario si avvicina piu' di 300 metri.
 A questo punto si sposta su un angolo adiacente preferendo quello in verticale.
 Arrivato a circa meta' dell'incontro comincia la modalita' "offensiva" (umhhhh)
 nella quale cambia angolo molto piu' frequentemente.
 Se invece i danni superano il 55% riduce l'ampiezza dell'oscillazione per difendersi meglio.
(tratto dalla scheda tecnica di md9.r)


*/


int eDist, eGradi;     /* Distanza e Gradi          */
int oeDist, oeGradi;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int i;
int danni;
int lim_o, lim_v;
int segno_o;
int inc;
int rip,d;
/* -------------------------------------------------------------- */


main()
{
    /* va sull'angolo piu' vicino */
    segno_o=1;
    o (1-2*(loc_x()>500));
    lim_v=(160+680*(loc_y(inc=50,rip=6)>500));


    while (1) {
        danni=damage(i=25)+8;
        

        while ((damage()<danni)&&(--i)) {
            d=0;
            while (loc_y()<lim_v+inc) f(90);
            d=0;
            while (loc_y()>=lim_v-inc) f(270);
             /*esce dal ciclo*/
            if (oeDist && (oeDist<300)) i=1;

            if (damage()>55)
                inc=0; /* modalita' difensiva */ 
        }

        if (!scan (90+180*(loc_y()>500),10)&&(--rip))
            lim_v=(160+680*(loc_y()<500));
        else {
            o(segno_o*=-1); rip=4;
        }
    }
}


/* si sposta in orizzontale */
o (segno)
{
    lim_o=500*segno-380;
    while ((segno*loc_x())>lim_o) f (90*(segno+1));
}



f (mdir)
{
 drive(mdir,100);
 if ((++d)<3)
 if (oeDist=scan(eGradi,10)) {
    convergi();
    if (oeDist=scan(oeGradi=eGradi,10)) {
     convergi();
     if (eDist=scan(eGradi,10)) {
             cannon((oeGradi+(eGradi-oeGradi)*3-(sin(eGradi-mdir)/19500)),(eDist*165/(165+oeDist-eDist-(cos(eGradi-mdir)/4167))));
     }
  }
  return eGradi+=40*(oeDist>900);
 }
         if ((eDist=scan(eGradi,10))&&(eDist<850)) {
            if (scan(eGradi+353,4))
            eGradi+=350;
            else if (scan(eGradi,4)) ;
            else if (scan(eGradi+7,4))
            eGradi+=10;
            cannon(eGradi,2*scan(eGradi,10)-eDist);
         }
         else
         if(eDist=scan(eGradi+=340,10)) cannon(eGradi,eDist);
         else
         if(eDist=scan(eGradi+=40,10)) cannon(eGradi,eDist);
         else eGradi+=40;
}

convergi() {

  if(scan(eGradi-8,4)) eGradi-=8;
  if(scan(eGradi+8,4)) eGradi+=8;
  if(scan(eGradi-4,2)) eGradi-=4;
  if(scan(eGradi+4,2)) eGradi+=4;
  if(scan(eGradi-1,1)) eGradi-=1;
  if(scan(eGradi+1,1)) eGradi+=1;  
	    
}

