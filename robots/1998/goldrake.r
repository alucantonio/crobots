/* GM '98 */

/**************************************************************************
  GOLDRAKE.r    (in ricordo dei cartoni animati della mia adolescenza)

  VIII Torneo di MCmicrocomputer

  Autore    :  Gianmaria Mancosu
***************************************************************************/

/**************************************************************************
                            LA STRATEGIA

  La strategia si basa sull'osservazione che e' inutile scrivere c-robot
  efficacissimi nel duello perche' potrebbero risultare inefficienti nella
  mischia. Infatti capita spesso che, mentre un robot sta' facendo la
  pelle ad un altro, un terzo gli spari "alle spalle".
  Goldrake fa una mappa dei robot nell'arena per fuggire nell'angolo piu'
  lontano da tutti fino a tre quarti della partita (circa 150.000 cicli)
  nella speranza che si ammazzino tra loro.
  Poi attacca vigliaccamente l'ultimo superstite che dovrebbe essere gia'
  stato abbastanza rovinato dagli altri.
  La routine di fuoco e' una versione modificata di quella di Rudolf2.r
  da cui e' stata presa anche la routine finale di attacco.

  Nel dettaglio:
  1)  Accende i motori per disorientare quei robot che sparano da subito
  2)  Calcola il baricentro della figura geometrica che ha per vertici
      i robot rimasti
  3)  Va nel quadrante opposto in tre tempi: avanti sino a meta' percorso,
      un po' indietro, avanti sino a destinazione
  4)  Oscilla nell'angolo scelto finche' non e' troppo danneggiato o non
      siamo ancora ai 3/4 della partita
  5)  Esegue una fuga verso il centro a tutta velocita'
  6)  Se non siamo ancora a 3/4 del tempo o e' troppo danneggiato per
      tentare la sortita torna al punto 2
  7)  Esegue "THE END", routine di eliminazione dell'ultimo nemico

  Ringraziamenti a:
    Alessandro Carlin,  per aver scritto Rudolf2.r fonte di grandi
                        ispirazioni
    Enrico Colombini,   per avere scritto CCRobots.c grazie al quale
                        sono riuscito a vedere il combattimento a
                        velocita' umana (ne ho fatto una versione
                        che fa la pausa ogni 30 cicli di CPU invece di
                        attendere il movimento di un robot: utile per
                        vedere il funzionamento dei robot statici)
    Laura,              per aver sopportato pazientemente i miei
                        deliri sulle tattiche e i combattimenti anche
                        di fronte ad un magnifico tramonto sul mare

***************************************************************************/

/* stato del robot */
int head;
int s_ang,e_ang;
int fuga_ang;
int x_rif;
int o_ang1,o_ang2;
int dam;

/* stato del cannone */
int ang,range;
int aa,rr;

/* stato dell'arena */
int nr,nr_lim;
int rx,ry;
int dxx,dyy;
int qd;
int timer;
int vicino;

main()
{
  /* evita i primi colpi */
  if(loc_x()>500)
    head=180;
  else
    head=0;
  drive(head,100);

  /* inizializza le variabili */
  s_ang=ang=10;
  e_ang=350;
  timer=180;
  vicino=0;
  nr_lim=2;

  while(1)
  {
    middle();
    if(damage()<81 && nr<nr_lim)
    {
      /* attacco finale */
      the_end();
    }
    nr_lim=3;
    timer=50; /* attende un altro po' */
  }
}

/* funzione di combattimento del centro partita */

middle()
{
  while(timer)
  {
    /* calcola il baricentro dei robot */
    baricentro();

    /* va nel quadrante opposto */
    if (qd==0)
    {
      Go(950,850);
      s_ang=150;
      e_ang=310;
      fuga_ang=225;
      o_ang1=135;
      o_ang2=315;
      x_rif=920;
    }
    else if (qd==1) 
    {
      Go(150,950);
      s_ang=230;
      e_ang=390;
      fuga_ang=315;
      o_ang1=225;
      o_ang2=45;
      x_rif=80;
    }
    else if (qd==2)  
    {
      Go(950,170);
      s_ang=50;
      e_ang=210;
      fuga_ang=135;
      o_ang1=225;
      o_ang2=45;
      x_rif=920;
    }
    else
    {
      Go(150,70);
      s_ang=330;
      e_ang=490;
      fuga_ang=45;
      o_ang1=135;
      o_ang2=315;
      x_rif=80;
    }

    /* rimane fino a quando non e' troppo danneggiato */
    dam=damage();
    vicino=0;
    while(damage() < dam+10 && --timer)
    {
      /* oscilla velocemente */
      oscillazione();
    }

    /* fuga a tutta velocita' */
    drive(head,0);
    while(speed()>49) ;
    drive(head=fuga_ang,100);
  }
}

/* Routine di posizionamento nell'arena */

Go(dx,dy)
int dx,dy;
{
  int dist;

  drive(head,0);

  if((dist=distanza(dx,dy)) > 6400)
  {
    head=angolo_rotazione(dx,dy);
    dist >>= 2;
    s_ang=10; e_ang=350;
    while(speed()>49) ;

    while(distanza(dx,dy) > dist)
    {
      drive(head,100); fuoco();
    }
    head+=180;
    while(distanza(dx,dy) < dist)
    {
      drive(head,100); fuoco();
    }

    head-=180;
    while(distanza(dx,dy) > 2500)
    {
      drive(head,100); fuoco();
    }
    drive(head,0);
  }
}

angolo_rotazione(xx, yy)
int xx,yy;
{
  int x,y;
  x = (loc_x() - xx);
  y = (loc_y() - yy) * 100000;
  if (x < 0)
    return(360 + atan(y / x));
  else if (x>0)
    return(180 + atan(y / x));
  else
    return 90;
}

distanza(xx1, yy1)
int xx1,yy1;
{
  int x,y;
  x = xx1 - loc_x();
  y = yy1 - loc_y();
  return ((x * x) + (y * y));
}

/* calcola il baricentro dei robot */

baricentro()
{
  if(vicino)
  {
    vicino=0;
    s_ang=10;
    e_ang=350;
  }

  calc_pos();

  if(!nr)
  {
    /* se non ha trovato robot prova a scandire di nuovo tutta l'arena */
    s_ang=10;
    e_ang=350;
    calc_pos();
  }

  dxx = loc_x() + rx / nr;
  dyy = loc_y() + ry / nr;

  /* calcola quadrante di appartenenza */
  /* 10 | 11 */
  /* 00 | 01 */
  qd=0;
  if(dxx>500)  qd =  1;
  if(dyy>500)  qd |= 2;
}

/* scansione dell'arena */

calc_pos()
{
  int a,ro;
  nr=rx=ry=0;
  a = s_ang;
  while(a <= e_ang && nr<3)
  {
    if (ro=scan(a,10))
    {
      rx += ro * cos(a) / 100000;
      ry += ro * sin(a) / 100000;
      ++nr;
    }
    a += 20;
  }
}

/* oscillazione veloce */

oscillazione()
{
  head=o_ang1;
  while (loc_x()>=x_rif) {drive(head,100);fuoco();} 
  head=o_ang2;                   
  while (loc_x()<x_rif) {drive(head,100);fuoco();} 
}

/* routine di fuoco con aggiustamento del tiro */

fuoco()
{
  if (!(range=scan(ang,10)))
    if (!(range=scan(ang-=20,10)))
      if (!(range=scan(ang+=40,10)))
      {
        ang+=40;
        if (ang > e_ang)  ang=s_ang;
        return;
      }
  aa=ang;
  if (!scan(ang+=5,5)) ang-=10;
  if (!scan(ang+=3,3)) ang-=6;
  if ((rr=scan(ang,10)))
  {
    cannon(ang+(ang-aa),rr+(rr-range)*2);
    if(rr<60)   vicino=1;
  }

  if (rr>705)
  {
    if(rr>range && nr>=nr_lim)
      ang+=40;    /* se si allontana cambia bersaglio */
  }
}

/* routine di attacco finale */

the_end()
{
  int p;
  s_ang=10;
  e_ang=350;

  /* va al centro */
  Go(500,500);
  p=0;
  head=ang+135;
  while (speed()>49);

  /* attacca oscillando */
  while (1)          
  {
    while (speed()<80) { drive(head,100); fuoco(); }
    drive(head,0);                       
    if (!Sicuro()) Go(500,500);   
    if (p=!p) head=ang-80; else head=ang+80;  
    while (speed()>49);                
  }
}

Sicuro()
{
  int x,y;
  if (((x=loc_x())<150) || (x>850) || ((y=loc_y())<150) || (y>850)) return 0;
  return 1;
}

