/* ---> Giali1   V. 1.0   del 14/7/1994   by GlnSOFT <---
   di Giuliano Ferraguti

 IL ROBOT EFFETTUA UNA PERLUSTRAZIONE LUNGO  TUTTO  IL PERIMETRO DELL' AREA DI
 COMBATTIMENTO.  INDIVIDUATO IL LATO NEL QUALE HA SUBITO MENO DANNI, LIMITA IL
 SUO MOVIMENTO ALLO SCORRIMENTO DI QUESTO LATO. LA PROCEDURA DI INDIVIDUAZIONE
 E DANNEGGIAMENTO DEGLI AVVERSARI CONSISTE:  
   - NELLA LOCALIZZAZIONE DELL' AVVERSARIO NEL SETTORE NON LIMITATO  DAL MURO;
   - NEL TENTATIVO DI DANNEGGIARLO SPARANDO CON CORREZIONE SE GIA' INDIVIDUATO
     IN PRECEDENZA, O SENZA CORREZIONE SE INDIVIDUATO PER LA PRIMA VOLTA. */

int ang_sp;       /* ANGOLO DI SPOSTAMENTO DEL ROBOT */
int ang_sc;       /* ANGOLO DI SCANNER PER L'INDIVIDUAZIONE DEGLI AVVERSARI */
int distanza;     /* DISTANZA DAL ROBOT AVVERSARIO */
int dist_prec;    /* PRECEDENTE DISTANZA DAL ROBOT AVVERSARIO */
int danniSx;      /* DANNI SUBITI PERCORRENDO IL LATO SINISTRO */
int danniDx;      /* DANNI SUBITI PERCORRENDO IL LATO DESTRO */
int danniA;       /* DANNI SUBITI PERCORRENDO IL LATO ALTO */
int danniB;       /* DANNI SUBITI PERCORRENDO IL LATO BASSO */
int latoScelto;   /* LATO SCELTO: 1=DESTRO; 2=ALTO; 3=SINISTRO; 4=BASSO */
int danni;        /* RILEVATORE DI DANNI SUBITI */

int sud;          /* ORDINATA DELL'ASSE DI MOVIMENTO A SUD */
int ovest;        /* ASCISSE DELL'ASSE DI MOVIMENTO AD OVEST */
int nord;         /* ORDINATA DELL'ASSE DI MOVIMENTO A NORD */
int est;          /* ASCISSE DELL'ASSE DI MOVIMENTO AD EST */

main()
{
   /* **** INIZIALIZZAZIONE VARIABILI **** */
   ang_sc     =   0;
   dist_prec  =   0;
   danniSx    =   0;
   danniDx    =   0;
   danniA     =   0;
   danniB     =   0;
   latoScelto =   0;
   sud        = 130;
   ovest      = 130;
   nord       = 870;
   est        = 870;

   /* **** PRENDI DISTANZA DI SICUREZZA DAL MURO **** */
   while ( loc_x() < ovest+50 )
   {
      drive( 0, 100 );
      Fuoco();
   }
   while ( loc_y() < sud+50 )
   {
      drive( 90, 100 );
      Fuoco();
   }
   drive( 0, 0 );                       /* STOP */
   while ( speed() > 0 )                /* ATTENDI LO STOP */
   {
      Fuoco();
   }

   /* **** POSIZIONAMENTO IN BASSO A SINISTRA **** */
   ang_sp = Angolo( loc_x(), loc_y(), ovest, sud );
   VaiESpara( sud, ovest );             /* SPARANDO, VA NELL'ANGOLO A S-O */
   ang_sc = 270-20;

   /* **** INIZIA IL GIRO DI PERLUSTRAZIONE **** */
   danni = damage();                    /* RILEVAZIONE DANNI SUBITI */
   FrenaESpara();                       /* FRENA E SPARA */
   ang_sp = 90;
   ang_sc = 180+ang_sp-20;
   VaiESpara( nord, ovest );            /* SPARANDO, VA NELL'ANGOLO A N-O */
   danniSx += damage()-danni;           /* DANNI SUBITI NEL LATO SINISTRO */

   danni = damage();                    /* RILEVAZIONE DANNI SUBITI */
   FrenaESpara();                       /* FRENA E SPARA */
   ang_sp = 0;
   ang_sc = 180+ang_sp-20;
   VaiESpara( nord, est );              /* SPARANDO, VA NELL'ANGOLO A N-E */
   danniA += damage()-danni;            /* DANNI SUBITI NEL LATO ALTO */

   danni = damage();                    /* RILEVAZIONE DANNI SUBITI */
   FrenaESpara();                       /* FRENA E SPARA */
   ang_sp = 270;
   ang_sc = 180+ang_sp-20;
   VaiESpara( sud, est );               /* SPARANDO, VA NELL'ANGOLO A S-E */
   danniDx += damage()-danni;           /* DANNI SUBITI NEL LATO DESTRO */

   danni = damage();                    /* RILEVAZIONE DANNI SUBITI */
   FrenaESpara();                       /* FRENA E SPARA */
   ang_sp = 180;
   ang_sc = 180+ang_sp-20;
   VaiESpara( sud, ovest );             /* SPARANDO, VA NELL'ANGOLO A S-O */
   danniB += damage()-danni;            /* DANNI SUBITI NEL LATO BASSO */

   /* **** SCELTA DEL LATO MIGLIORE E LOOP PERPETUO FINALE **** */
   if ( (danniSx <= danniA) && (danniSx <= danniDx) && (danniSx <= danniB) )
   { /* MINORI DANNI SUL LATO SINISTRO */
      latoScelto = 3;                   /* LATO SCELTO: SINISTRO */
      ang_sc = 270-20;
      while (1)
      {
	 FrenaESpara();                 /* FRENA E SPARA */
	 ang_sp = 90;
	 VaiESpara( nord, ovest );      /* SPARANDO, VA NELL'ANGOLO A N-O */
	 FrenaESpara();                 /* FRENA E SPARA */
	 ang_sp = 270;
	 VaiESpara( sud, ovest );       /* SPARANDO, VA NELL'ANGOLO A S-O */
      }
   }
   else
   {
      if ( (danniA <= danniSx) && (danniA <= danniDx) && (danniA <= danniB) )
      { /* MINORI DANNI SUL LATO ALTO */
	 ang_sp = 90;
	 ang_sc = 180 + ang_sp - 20;
	 VaiESpara( nord, ovest );      /* SPARANDO, VA NELL'ANGOLO A N-O */
	 latoScelto = 2;                /* LATO SCELTO: ALTO */
	 ang_sc = 180-20;
	 while (1)
	 {
	    FrenaESpara();              /* FRENA E SPARA */
	    ang_sp = 0;
	    VaiESpara( nord, est );     /* SPARANDO, VA NELL'ANGOLO A N-E */
	    FrenaESpara();              /* FRENA E SPARA */
	    ang_sp = 180;
	    VaiESpara( nord, ovest );   /* SPARANDO, VA NELL'ANGOLO A N-O */
	 }
      }
      else
      {
	 if ( (danniB <= danniSx) && (danniB <= danniDx) && (danniB <= danniA) )
	 { /* MINORI DANNI SUL LATO BASSO */
	    latoScelto = 4;             /* LATO SCELTO: BASSO */
	    ang_sc = 360-20;
	    while (1)
	    {
	       FrenaESpara();           /* FRENA E SPARA */
	       ang_sp = 0;
	       VaiESpara( sud, est );   /* SPARANDO, VA NELL'ANGOLO A S-E */
	       FrenaESpara();           /* FRENA E SPARA */
	       ang_sp = 180;
	       VaiESpara( sud, ovest ); /* SPARANDO, VA NELL'ANGOLO A S-O */
	    }
	 }
	 else
	 { /* MINORI DANNI SUL LATO DESTRO */
	    ang_sp = 0;
	    latoScelto = 4;             /* FINTA IMPOSTAZIONE: E' IMPORTANTE
					   PER LA ROUTINE DI FUOCO */
	    ang_sc = 360 - 20;
	    FrenaESpara();              /* FRENA E SPARA */
	    VaiESpara( sud, est );      /* SPARANDO, VA NELL'ANGOLO A S-E */

	    latoScelto = 1;             /* LATO SCELTO: DESTRO */
	    ang_sc = 90-20;
	    while (1)
	    {
	       FrenaESpara();           /* FRENA E SPARA */
	       ang_sp = 90;
	       VaiESpara( nord, est );  /* SPARANDO, VA NELL'ANGOLO A N-E */
	       FrenaESpara();           /* FRENA E SPARA */
	       ang_sp = 270;
	       VaiESpara( sud, est );   /* SPARANDO, VA NELL'ANGOLO A S-E */
	    }
	 }
      }
   }
}

/* Fuoco E' LA PROCEDURA DI SCANSIONE DEL CAMPO DI BATTAGLIA E DI ATTACCO DEI
   ROBOT AVVERSARI INDIVIDUATI.  SI EVITA DI SPARARE A ROBOT TROPPO LONTANI O
   TROPPO VICINI (RISCHIO DI AUTODANNEGGIARSI). SE UN ROBOT VIENE INDIVIDUATO
   PER LA PRIMA VOLTA, SI SPARA SENZA  NESSUNA  CORREZIONE.   SE E' GIA STATO
   INDIVIDUATO, SI SPARA CON UNA CORREZIONE CHE TIENE CONTO DEL FATTO  CHE LO
   AVVERSARIO E' IN FASE DI AVVICINAMENTO O DI ALLONTANAMENTO. */
Fuoco()
{
   distanza = scan( ang_sc, 10);              /* SCANSIONE */
   if ( ( distanza > 46 ) && ( distanza < 700 ) ) /* LA DISTANZA E' OK */
   {
      if ( dist_prec == 0 )                   /* 1ø INDIVIDUAZIONE */
      {
	 cannon( ang_sc, distanza );          /* SPARA SENZA CORREZIONE */
      }
      else
      {
	 if ( distanza > dist_prec )          /* 2ø INDIVIDUAZIONE */
	 {                                    /* AVVERSARIO IN ALLONTANAMENTO */
	    cannon( ang_sc, 8*distanza/7 );   /* SPARA CON CORREZIONE */
	 }
	 else
	 {                                    /* AVVERSARIO IN AVVICINAMENTO */
	    cannon( ang_sc, 7*distanza/8 );   /* SPARA CON CORREZIONE */
	 }
      }
   }
   else
   {
      ang_sc += 20;                           /* INCREMENTA ANGOLO DI SCANNER */
      if ( latoScelto == 0 )
      {
	 if ( ang_sc > 360+20+ang_sp )        /* TORNA NEL SETTORE DI SCANNER */
	 {
	    ang_sc = 180+ang_sp-20;
	 }
      }
      else
      {
	 if ( ang_sc > 90*latoScelto+180+20 ) /* TORNA NEL SETTORE DI SCANNER */
	 {
	    ang_sc = 90*latoScelto-20;
	 }
      }
   }
   dist_prec = distanza;                      /* REGISTRA LA DISTANZA ATTUALE */
}

/* Angolo E' UNA FUNZIONE CHE RICEVE IN INPUT LE COORDINATE DEL PUNTO A(xa,ya) 
   DI PARTENZA DEL ROBOT E QUELLE DEL PUNTO  B(xb,yb)  DI ARRIVO E RESTITUISCE
   L'ANGOLO CON IL QUALE OCCORRE PROCEDERE PER ANDARE da A a B.             */
Angolo( xa, ya, xb, yb )
int xa;
int ya;
int xb;
int xa;
{
   int ang;

   if ( xa != xb )
   {
      ang = atan( 100000*(yb - ya) / (xb - xa) ) + 180*(xb < xa);
      ang += 360*(ang < 0);
   }
   else
   {
      ang = 90 + 180*(ya > yb);
   }

   return( ang );
}

/* FrenaESpara E' LA PROCEDURA DI VIRATA DEL ROBOT: SI ATTENDE CHE LA VELOCITA'
   SIA TALE DA CONSENTIRE UN CAMBIO DI DIREZIONE, SPARANDO AGLI AVVERSARI. */
FrenaESpara()
{
   drive(ang_sp, 0);
   while (speed() > 50)
   {
      Fuoco();
   }
}

/* VaiESpara E' LA PROCEDURA DI MOVIMENTO DEL ROBOT. L'OBIETTIVO E' QUELLO  DI
   RAGGIUNGERE IL PUNTO (x,y) (UN ANGOLO DEL CAMPO DI COMBATTIMENTO) E SPARARE
   AI ROBOT AVVERSARI. VIENE COSTANTEMENTE CONTROLLATA LA  POSIZIONE  CORRENTE
   PER EVITARE URTI CONTRO IL MURO E LA VELOCITA' PER EVITARE CHE ESSA DIVENTI
   NULLA A CAUSA DI UNO SCONTRO CON UN ROBOT AVVERSARIO. */
VaiESpara( y, x )
int y;                                  /* ORDINATA DEL PUNTO DI ARRIVO */
int x;                                  /* ASCISSE DEL PUNTO DI ARRIVO */
{
   drive(ang_sp, 100);                  /* PROCEDI A VELOCITA' MASSIMA */
   while (  ( (loc_x() > x) && (x < 500) )
	 || ( (loc_x() < x) && (x > 500) )
	 || ( (loc_y() > y) && (y < 500) ) 
	 || ( (loc_y() < y) && (y > 500) ) )
   {
      Fuoco();
      if ( speed() == 0 )               /* IN CASO DI SCONTRO CI SI RIAVVIA */
      {
	 drive( ang_sp, 100 );          /* ... A VELOCITA' MASSIMA */
      }
   }
}
