/*=========================================================================*/
/*      FILE NAME : BELVA.R                                                */
/*-------------------------------------------------------------------------*/
/*      DATA      : 12-SETTEMBRE-1997                                      */
/*-------------------------------------------------------------------------*/
/*      AUTORE    : Sebastiano GRIMALDI                                    */
/*-------------------------------------------------------------------------*/
/*      STRATEGIA :                                                        */
/*                  LA BELVA [IL CROBOT] SI ANNIDA AGLI ANGOLI DELLA       */
/*                  ARENA SPARANDO SENZA SOSTA AI MALCAPITATI PASSANTI     */
/*                  E/O AGLI AGGRESSORI.                                   */
/*                  SE LA BELVA VIENE FERITA SCAPPA SUBITO NELLO           */
/*                  ANGOLO SUCCESSIVO .                                    */
/*                  NON MI SEMBRA CATTIVA LA FUNZIONE DI FUOCO             */
/*                  CHE CAMBIA LA MODALITA' DI SPARO IN FUNZIONE DELLA     */
/*                  DISTANZA DEL NEMICO ... BOH E' MEGLIO CHE SIANO        */
/*                  GLI ALTRI [ROBOTS] A GIUDICARE.                        */
/*                  VOLEVO SCRIVERE UNA FUNZIONE 'ASSASSINA',CIOE'         */
/*                  ..DOPO UN CERTO NUMERO DI CICLI MACCHINA SI            */
/*                  PRESUME CHE SIA RIMASTO IN CAMPO UN SOLO AVVERSARIO    */
/*                  PER CUI ....VA E COLPISCI.                             */
/*                  MI SONO CHIESTO :                                      */
/*                  E SE LA POTENZA DI FUOCO DEL MIO AVVERSARIO E'         */
/*                  PIU' FORTE DELLA MIA ?                                 */
/*                  RISPOSTA:                                              */
/*                  MI TENGO LA PARTITA PATTA ANZICHE' UNA SCONFITTA!      */
/*                  LA BELVA HA DUELLATO CENTINAIA DI VOLTE CON IL         */
/*                  MITICO !.R  .....BATTENDOLO SEMPRE.                    */
/*-------------------------------------------------------------------------*/
/*      CRITICA   :                                                        */
/*                  TENTO SEMPRE DI FARE UNA CRITICA OBBIETTIVA SU         */
/*                  TUTTO CIO' CHE FACCIO, IN QUESTO CASO POSSO DIRE       */
/*                  CHE LA MIA BELVA HA UN BEL TALLONE D'ACHILLE.          */
/*                  MI SPIEGO :                                            */
/*                  IL PARGOLO HA UN BUON COMPORTAMENTO CONTRO  I          */
/*                  ROBOTS "POSIZIONALI" [QUELLI CHE NON VANNO A SPASSO],  */
/*                  NON ALTRETTANTO CON I "GIROVAGHI".                     */
/*                  COMUNQUE ..... L'IMPORTANTE E' PARTECIPARE.            */
/*-------------------------------------------------------------------------*/
/*      CREDITS   : UN GRAZIE ED UNA STRETTA DI MANO [..DA FABBRO FERRAIO] */
/*                  A TUTTA LA REDAZIONE DI MC-Microcomputer.              */
/*                  VI SEGUO FEDELMENTE DAL NUMERO-UNO, SIETE IL MIO       */
/*                  PERSONALE ED UNICO FARO GUIDA.                         */
/*                  USO I CALCOLATORI PER PROFESSIONE E PER PASSIONE.      */
/*                  COSA AVREI FATTO SENZA DI VOI ! BOOOOOOOOH.            */
/*-------------------------------------------------------------------------*/


/*      INIZIALIZZO LE VARIABILI GLOBALI        */
int d,deg,dam,r,rng,counter ;

main()
{
/*      PARTE IL LOOP INFINITO PER LO SPOSTAMENTO DELLA BELVA   */
while (1)
{
        go (100,100) ;
dam = damage();
while (damage() < dam+5)
    defence();
        go (100,900) ;
dam = damage();
while (damage() < dam+5)
    defence();
        go (100,100) ;
dam = damage();
while (damage() < dam+5)
    defence();
        go (900,100) ;
dam = damage();
while (damage() < dam+5)
    defence();
        go (900,900) ;
dam = damage();
while (damage() < dam+5)
    defence();
        go (900,100) ;
dam = damage();
while (damage() < dam+5)
        defence();
        go (900,900) ;
dam = damage();
while (damage() < dam+5)
        defence();
        go (100,900) ;
}
}

/* defence - SPARA CON BUONA PRECISIONE    */
/*           SE LA DISTANZA E' INFERIORE AI 250 METRI   */
/*           CAMBIA MODALITA' DI SPARO  */

defence()
{
if (r=scan(deg,3))
{
        if((r=scan(deg,6))<250)
        {
                cannon(deg+2,r/8*7);
                cannon(deg-2,r/8*7);
                return;
        }
            else
                {
                        cannon(deg+1,r);
                        cannon(deg-1,r);
                        return;
                }
}
    else
deg-=6 ;
if (r=scan(deg,3))
{
        if((r=scan(deg,6))<250)
        {
                cannon(deg+2,r/8*7);
                cannon(deg-2,r/8*7);
                deg-=3;
                return;
        }
            else
                {
                        cannon(deg+1,r);
                        cannon(deg-1,r);
                        deg-=3;
                        return;
                }
}
    else
deg-=6 ;
if (r=scan(deg,3))
{
        if((r=scan(deg,6))<250)
        {
                cannon(deg+2,r/8*7);
                cannon(deg-2,r/8*7);
                deg-=3;
                return;
        }
            else
                {
                        cannon(deg+1,r);
                        cannon(deg-1,r);
                        deg-=3;
                        return;
                }
}
    else
deg+=18 ; 
if (r=scan(deg,3))
{
        if((r=scan(deg,6))<250)
        {
                cannon(deg+2,r/8*7);
                cannon(deg-2,r/8*7);
                deg+=3;
                return;
        }
            else
                {
                        cannon(deg+1,r);
                        cannon(deg-1,r);
                        deg+=3;
                        return;
                }
}
    else
deg+=6;
if (r=scan(deg,3))
{
        if((r=scan(deg,6))<250)
        {
                cannon(deg+2,r/8*7);
                cannon(deg-2,r/8*7);
                deg+=3;
                return;
        }
            else
                {
                        cannon(deg+1,r);
                        cannon(deg-1,r);
                        deg+=3;
                        return;
                }
}
    else
deg+=180;
}



/* go - VAI A DESTINAZIONE        */

go (dest_x, dest_y)
int dest_x, dest_y;
{
  int course;

  course = plot_course(dest_x,dest_y);
  drive(course,100);
  while(distance(loc_x(),loc_y(),dest_x,dest_y) > 50)
  defence() ; 
  drive(course,35);
  while (speed() > 49)
  defence() ; 
}



/* TEOREMA DI PITAGORA PER IL CALCOLO DELLA DISTANZA     */

distance(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));

  return(d);
}



/* plot_course - TROVA LA DIREZIONE IN CUI SI TROVA L'OBBIETTIVO */

plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;  /* scale for trig functions */

  curx = loc_x();
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  if (x == 0) {
    if (yy > cury)
      d = 90;
    else
      d = 270;
  } else {
    if (yy < cury) {
      if (xx > curx)
	    d = 360 + atan((scale * y) / x);
      else
	    d = 180 + atan((scale * y) / x);
    } else {
      if (xx > curx)
	    d = atan((scale * y) / x);
      else
	    d = 180 + atan((scale * y) / x);
    }
  }
  return (d);
}

    
/* FINE DI  BELVA.R */

