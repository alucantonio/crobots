/*************************************************************************/
/*                                                                       */
/* MARLENE                                                               */
/*                                                                       */
/* Author: Marco Giovannini                                              */
/*                                                                       */
/*                                                                       */
/* Descrizione del robot:                                                */
/*   Marlene e' un robot oscillante che preferisce la parte alta dello   */
/*   schermo. Cosi' all'inizio della pugna si porta all'angolo superiore */
/*   piu' vicino ed inizia ad oscillare. Se per 6 volte consecutive non  */
/*   vede nessuno nell'angolo inferiore allunga la propria oscillazione, */
/*   ma se invece per 20 volte consecutive vede qualcuno allora cambia   */
/*   angolo, portandosi a quello opposto. L'angolo viene cambiato anche  */
/*   nel caso in cui venga colpito un po' troppo spesso.                 */
/*   Se ad un certo punto si stanca, oppure riesce a fare un certo       */
/*   numero di oscillazioni lunghe allora si attiva la routine di        */
/*   attacco finale, che non e' altro che un'oscillazione orrizzontale   */
/*   lunga alla meta' dello schermo.                                     */
/*                                                                       */
/* Commenti:                                                             */
/*   Non so se questo robottino avra' successo, ne avevo anche una       */
/*   versione probabilmente migliore ma non sapevo perche' funzionava    */
/*   (per me aveva un bug che lo avrebbe dovuto rendere inutile): questo */
/*   invece almeno fa cio' che volevo fargli fare, anche se magari non   */
/*   e' la cosa giusta...                                                */
/*                                                                       */
/*************************************************************************/

int i,l,t;
int oa,va,ca;
int dam;

main(void)
{
    oa=180*(loc_x()<500);
    while (va=270) {
        drive(oa%=360,dam=100);
        while ((oa && (i=loc_x())>80) || (!oa && i<920)) fire();
        wait(oa+=180,0,20);
    }
}

wait(ma,k,m)
{
    int s;
    while (l!=550) {
        reverse();
        while (loc_y()<920) fire();
        reverse(k*=!scan(270,10));

        if (++t>100 || ++k>13) {
            if (scan(oa,10)) return;
            l=550;
        } else {
            if (--m && (i=damage())-dam<6) ; else return;
            dam=i;
	    l=80+790*((m*=(k<6))>0);
        }

        while (loc_y()>l) fire();
    }
    reverse();
}

reverse(a)
{
    drive(va,0);
    while (speed()) fire();
    drive(va+=180,100);
}

fire()
{
    int r,or;
    if (or=scan(ca,10)) {
        if (scan(ca-=5,5)) ; else ca+=10;
        if (scan(ca-=3,3)) ; else ca+=6;
        if (r=scan(ca,10)) cannon(ca,(160*r)/(160+or-r));
        ca+=40*(r>705);
    } else if (scan(ca-=20,10)) ;
      else if (scan(ca+=40,10)) ;
      else ca+=40;
}

/* eh eh eh il codice non commentato e' ancora piu' bello, vero? */
