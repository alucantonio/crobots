/*
+ --------------------------------------------------------------------------- +
+                                                                             +
+  Torneo di MicroRobots 2000                                                 +
+                                                                             +
+  CROBOT: MD9.R  (MiniDav9)                                                  +
+                                                                             +
+  AUTORE: Lorenzi Davide                                                     +
+                                                                             +
+ --------------------------------------------------------------------------- +

                          SCHEDA TECNICA:

 Inizialmente il microbo si reca nell'angolo piu' vicino e comincia ad oscillare
 parallelamente al muro laterale con un'ampiezza di circa 100 metri.
 Oscilla per 25 volte o finche' un avversario si avvicina piu' di 300 metri.
 A questo punto si sposta su un angolo adiacente preferendo quello in verticale.
 Arrivato a circa meta' dell'incontro comincia la modalita' "offensiva" (umhhhh)
 nella quale cambia angolo molto piu' frequentemente.
 Se invece i danni superano il 55% riduce l'ampiezza dell'oscillazione per difendersi meglio.

 Un ringraziamento va agli autori di Goblin.r, Tox.r, Tornado.r, Son-Goku.r da
 cui ho ripreso e modificato parti di codice.
 Grazie anche ai responsabili della mailing list ed a tutti gli amici che vi
 hanno partecipato.

 DIFETTI: Questo robot e' quasi inoffensivo (direi ridicolo) :(
   PREGI: Nessuno a parte la procedura di sparo che e' del tipo toxica ma molto ridotta :)
-------------------------------------------------------------------------------
*/


int eDist, eGradi;     /* Distanza e Gradi          */
int oeDist, oeGradi;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int i;
int danni;
int lim_o, lim_v;
int segno_o;
int inc;
int rip;
/* -------------------------------------------------------------- */


main()
{
    /* va sull'angolo piu' vicino */
    o (segno_o=1);
    lim_v=(160+680*(loc_y(inc=50,rip=6)>500));


    while (1) {
        danni=damage(i=25)+8;
        

        while ((damage()<danni)&&(--i)) {
            while (loc_y()<lim_v+inc) f(90);
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
    drive (mdir,100);
    if (oeDist=scan(oeGradi=eGradi,10)) {
        if (!scan(eGradi+=355,5)) eGradi+=10;
        if (!scan(eGradi+=357,3)) eGradi+=6;
        cannon(eGradi+(eGradi-oeGradi),2*scan(eGradi,10)-oeDist);        
        if (oeDist>800) eGradi+=40;
    } 
    else {
        if (scan(eGradi+=340,10)) return;
        if (scan(eGradi+=40,10)) return;
        eGradi+=40;
    }
}
