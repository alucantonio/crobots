
/* €ﬂ‹ ‹ﬂ‹ €ﬂ‹ €ﬂ‹ ‹ﬂﬂ €ﬂ‹   DATI DEL CREATORE:                            */
/* € € € € € € € € €   € €   ˛ NOME: Federico Feroldi                      */

int     tgt,    /* Variabile di puntamento */
        dir,    /* Direzione attuale (1 su) (-1 Gi˘) del target */
        range,  /* Distanza del bersaglio */
        loc;    /* Buffer di posizione */

main()
{
tgt=270;                                /* Inizialmente punto a 270¯ */
dir=1;                                  /* dirigo il target verso l'alto */
loc=loc_x();                            /* Leggo la mia posizione orizz. */
if (loc<450) drive (0,100);             /* Ed in base ad essa mi dirigo */
else if (loc>550) drive (180,100);      /* verso la metÖ del campo */
while (loc<450 || loc>550)              /* Fino a quando non arrivo alla */
{                                       /* metÖ dello schermo, sparo e */
        kill();                         /* controllo la mia posizione */
        loc=loc_x();
}                                       /* Quando sono arrivato */
drive (0,0);                            /* spengo i motori e, fino a quando */
while (speed()>49) kill();              /* non mi sono fermato, sparo */

loc=loc_y();                            /* Leggo la mia posizione vert. */
if (loc<450) drive (90,100);            /* Ed in base ad essa mi dirigo */ 
else if (loc>550) drive (270,100);      /* verso la metÖ del campo */
while (loc_y()<450 || loc_y()>550)      /* Fino a quando non arrivo alla */ 
{                                       /* metÖ dello schermo, sparo e */
        kill();                         /* controllo la mia posizione */
        loc=loc_y();
}                                       /* Quando sono arrivato */
drive (0,0);                            /* spengo i motori e, fino a quando */
while (speed()>49) kill();              /* non mi sono fermato, sparo */

while (1)                               /* Inizia il loop infinito */
{
drive (90,100);                         /* Vado su a canna e, fino a che */
while (loc_y()<900) kill();             /* non tocco il soffitto... sparo! */
drive (90,0);                           /* Sono arrivato e spengo i motori */
while (speed()>49) kill();              /* Rallento e ... sparo!! */
drive (270,100);                        /* Vado gió a canna e, fino a che */
while (loc_y()>100) kill();             /* non tocco il pavimento... sparo! */
drive (270,0);                          /* Sono arrivato e spengo i motori */
while (speed()>49) kill();              /* Rallento e ... sparo!! */
}
}

kill()                                  /* Eccola la mia arma!! */
{                                       
/* Primo stadio di fuoco */
if (range=scan(tgt,10))                 /* Se ho il bersaglio in target */
cannon (tgt,range);                     /* gli sparo subito!! */
else                                    /* altrimenti */
if (range=scan(tgt+180,10))             /* se ce l'ho dietro il target */
cannon (tgt+180,range);                 /* gli sparo lo stesso!! */
else                                    /* e se proprio non lo trovo */
{                                       /* ne davanti ne dietro */
 tgt+=dir*20;                           /* incremento il target di Ò20¯ a */
 if (tgt==460 || tgt==260) dir=-dir;    /* seconda della direzione (dir) */
}                                       /* e se va fuori inverto la dir. */

/* Secondo stadio di fuoco */
if (range=scan(tgt,10))                 /* I quattro stadi di fuoco sono */
cannon (tgt,range);                     /* completamente uguali perciï ne */
else                                    /* commento uno solo. */
if (range=scan(tgt+180,10))             /* Ho preferito scrivere la routine */
cannon (tgt+180,range);                 /* quattro volte invece di mettere */
else                                    /* un for perchä cosç ho potuto */
{                                       /* risparmiare quei cicli di clock */
 tgt+=dir*20;                           /* che avrei perso durante i quattro */
 if (tgt==460 || tgt==260) dir=-dir;    /* salti. ( e poi fa anche figo ) */
}

/* Terzo stadio di fuoco */
if (range=scan(tgt,10)) cannon (tgt,range);
else
if (range=scan(tgt+180,10)) cannon (tgt+180,range);
else
{
 tgt+=dir*20;
 if (tgt==460 || tgt==260) dir=-dir;
}

/* Quarto stadio di fuoco */
if (range=scan(tgt,10)) cannon (tgt,range);
else
if (range=scan(tgt+180,10)) cannon (tgt+180,range);
else
{
 tgt+=dir*20;
 if (tgt==460 || tgt==260) dir=-dir;
}
}
