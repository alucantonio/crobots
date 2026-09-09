/*-------------------------------------------------------------------------*/
/*  T-REX.r                     Programmato da:  Ugolini Davide            */
/*  Dopo la presentazione di questa tecnica                                */
/*  i robot a inseguimento saranno danger!!!                               */
/*                                                                         */
/*  1) Si sposta subito per evitare i colpi iniziali                       */
/*  2) Effettua uno scan con step +20 e risoluzione a 10                   */
/*     per cercare il bersaglio velocemente, e mette il contatore a tre.   */
/*  3) Appena trovato il bersaglio fa un cannon a + 36                     */
/*     per compensare lo spostamento del robot nemico, e si dirige         */
/*     verso lo stesso con speed di 100 e porta lo scan piu indietro       */
/*     di 5 gradi e rimette il contatore a tre                             */
/*  4) Fa uno scan con risoluzione a 3 gradi e se non trovato decrementa   */
/*     un contatore di 1 e incrementa lo scan di 5 gradi e ripete dal      */
/*     punto (3) finche il contatore e` maggiore di zero                   */
/*  5) se non trovato sposta l'ultimo scan a - 40 gradi e riparte da (2)   */
/*-------------------------------------------------------------------------*/

int r,d,c;

main() {
  if (loc_x()>500) drive(180,100); else drive(0,100);      /* via subito! */
  while(1) {
    c=3;
    while(!(r=scan(d,10))) d+=20;                   /* cerca il bersaglio */
    while(c) {
      if (r) {drive(d,100); cannon(d,r+36); d+=355; c=3;}    /* magico!!! */
      else {--c; d+=5;}                    /* tiene in linea il bersaglio */
      r=scan(d,3);               /* e spara a raffica con alta precisione */
    }
    d+=320;              /* se perde il bersaglio riparte da piu indietro */
  }
}
