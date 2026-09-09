/* 
  BOSS Robot 2001 

   di:
   
  Centurione Davide
  Parolini Max


   SCHEDA TECNICA

  Il movimento di Boss Robot e' piuttosto semplice. Si muove vicino ai muri
  nord e ovest, avanti e indietro, senza mai allontanarsi dall'angolo.
  Le routine s_su() e s_giu() eseguono lo scan e il fuoco in maniera magari
  non troppo intelligente ma abbastanza veloce.
  Dopo un certo numero di cicli Boss Robot amplia lo spostamento lungo i muri,
  allontanandosi maggiormente dall'angolo, in modo da poter attaccare eventua-
  li robots rimasti che si muovono lungo i muri est o sud.

*/


/* Dichiarazione variabili */

int ang_su, ang_giu, angle, a_su, a_giu;
int range, i;

main ()
{
    /* Inizializzazione variabili */
    ang_su = 358;
    ang_giu = 272;
    angle = 270;
    i = 0;

    /* Movimento verso l'angolo nord ovest */
    drive (90,100);
    while (loc_y()<930) s_su();
    drive (180,0);
    while (speed()>49) s_su();
    
    drive (180,100);
    while (loc_x()>70) s_su();
    drive (180,0);
    while (speed()>49) s_su();

    /* Ciclo principale */
    while (1)
    {
        /* Controllo cicli */
        if (i>25)
            boss ();

        drive (270,100);                
        while (loc_y()>750) s_giu();
        drive (270,0);
        while (speed()>49) s_giu();

        drive (90,100);                
        while (loc_y()<940) s_giu();
        drive (0,0);
        while (speed()>49) s_giu();

        drive (0,100);                 
        while (loc_x()<250) s_su();
        drive (0,0);
        while (speed()>49) s_su();

        drive (180,100);               
        while (loc_x()>60) s_su();
        drive (180,0);
        while (speed()>49) s_su();
        
        ++i;
    }
}

/* Routine di sparo durante movimento muro nord */
s_su ()
{
    if (((range=scan(ang_su,8))!=0) && (range<700))
        if (range>45)  cannon (ang_su,range);
            else  cannon (ang_su,45);
    else
    {
        if (ang_su==182)  ang_su=374;
        ang_su -= 16;
    }
}

/* routine di sparo durante movimento muro sud */
s_giu ()
{
    if (((range=scan(ang_giu,8))!=0) && (range<700))
        if (range>45)  cannon (ang_giu,range);
            else  cannon (ang_giu,45);
    else
    {
        if (ang_giu==448)  ang_giu=256;
        ang_giu += 16;
    }
}
                                                 
/* Attivazione secondo robot */
boss ()
{
    /* inizializzazione variabili */
    a_su = 352;
    a_giu = 278;
    /* ciclo principale */
    while (1)
    {
        drive (270,100);
        while (loc_y()>520) sp_giu();
        drive (270,0);
        while (speed()>49) sp_giu();
        drive (90,100);
        while (loc_y()<940) sp_giu();
        drive (0,0);
        while (speed()>49) sp_giu();

        drive (0,100);
        while (loc_x()<480) sp_su();
        drive (0,0);
        while (speed()>49) sp_su();
        drive (180,100);
        while (loc_x()>60) sp_su();
        drive (270,0);
        while (speed()>49) sp_su();
    }
}

/* Routine di sparo durante il movimento lungo il muro nord */
sp_su ()
{
    if (range=scan(a_su,8)) cannon (a_su,range);
    else
    {
        if (a_su==192) a_su=368;
        a_su-=16;
    }
}

/* Routine di sparo durante il movimento lungo il muro sud */
sp_giu ()
{
    if (range=scan(a_giu,8)) cannon (a_giu,range);
    else
    {
        if (a_giu==438) a_giu=262;
        a_giu+=16;
    }
}

