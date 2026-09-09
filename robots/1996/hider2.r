/****************************************************************************
 *                                                                          *
 * ROBOT :HIDER2                                                            *
 *                                                                          *
 * DATA :29/9/96                                                            *
 *                                                                          *
 * AUTORE :      ZIMBA WATU  ovvero:                                        *
 *       Davide Centurione                                                  *
 *       Fabio Nobile                                                       *
 *       Max Parolini                                                       *
 *                                                                          *
 * SCHEDA TECNICA :                                                         *
 * Hider2 si muove lungo il bordo se colpito o dopo un tot di tempo sparando*
 * con una routine di fuoco rozza. Negli angoli, da fermo, utilizza una funzione*
 * purtroppo poco testata ma che in teoria dovrebbe essere il massimo della *
 * precisione in quanto sfrutta formule matematiche di intercettazione.     *
 * Ma non ci piace affatto!                                                 *
 ****************************************************************************/

/************************
 * Lista delle funzioni *
 ************************/

/*  main ()         Funzione principale
 *  fire_f ()       Fuoco da fermo
 *  shot_p ()       Torretta principale
 *  shot_now ()     Fuoco di precisione
 *  find ()         Ricerca della posizione esatta del nemico
 *  check ()        Controllo danni e tempo passato in un angolo
 *  first_move ()   Movimento iniziale
 *  move_n ()       Movimento verso nord
 *  move_s ()       Movimento verso sud
 *  move_e ()       Movimento verso est
 *  move_o ()       Movimento verso ovest
 *  fire_m ()       Fuoco in movimento
 */

/*********************
 * Variabili globali *
 *********************/

int angle_m;        /* angolo di fuoco in movimento                 */
int start_angle;    /* angolo di partenza per lo scan negli angoli  */
int d;              /* contatore dei danni                          */
int t;              /* contatore dei cicli passati in un angolo     */
int x,y;            /* coordinate iniziali                          */
int old_angle;      /* primo angolo di scan nella funzione shot()   */
int old_range;      /* primo range di scan nella funzione shot()    */
int a;              /* angolo corrente di scan                      */
int range;          /* range corrente di scan                       */
int test;           /* variabile controllo ciclo while              */
int Xa,Ya,Xb,Yb,Xc,Yc; /*variabili di calcolo posizione nemico*/
int C1,C2,DeltaR,MSinFi;/*costanti per il calcolo della routine di fuoco*/

/************
 * Funzioni *
 ************/

/****
 * Funzione principale
 ****/
main ()
{
    C1 = 4595;
    C2 = 3595;
    DeltaR = 215;

    first_move ();

    while (1) {
        move_e (1);
        move_n (1);
        move_o (1);
        move_s (1);
    }
}
/****
 * Routine di fuoco da fermo
 ****/
fire_f ()
{
    range = 4000;
    d = damage ();
    t = 0;

    while (check ())
        shot_p ();
}
/****
 * Torretta principale
 ****/
shot_p ()
{
    if (scan (a,5)) {
        shot_now ();
        return;
    } else if (range < 4000) {
            if (scan ((a-=10),5)) {
                shot_now ();
                return;
            } else {
                if (scan ((a+=20),5)) {
                    shot_now ();
                    return;
                } else
                    range = 4000;
            }
    }
    a += 10 - (a>start_angle+90)*100;
}
/****
 * Fuoco di precisione
 ****/
shot_now ()
{
    find ();
    if (old_range = scan (a,5)) {
        old_angle = a-start_angle;
        find ();
        if (range = scan (a,5)) {
            a-=start_angle;
            Xa=(old_range*cos(old_angle))/100000;
            Ya=(old_range*sin(old_angle))/100000;
            Xb=(range*cos(a))/100000;
            Yb=(range*sin(a))/100000;
            Xc=(Xb*C1-Xa*C2)/1000;
            Yc=(Yb*C1-Ya*C2)/1000;
            MSinFi=(((Xb-Xa)*Yc-(Yb-Ya)*Xc)*1000)/(DeltaR*sqrt(Xc*Xc+Yc*Yc));
            a=atan(100000*Yc/Xc)-(180-2*a/9)*MSinFi/3141;
            range=100000*Xc/(cos(a)-100000*(Xb-Xa)/DeltaR);
            cannon(a+=start_angle,range);
            return;
        }
    }
    range = 2000;
}
/****
 * Ricerca della posizione esatta del nemico
 ****/
find ()
{
    if (scan (a+3,3))
        if (scan (a+4,1))
            if (scan (a+5,1))
                if (scan (a+5,0))
                    a += 5;
                else
                    a += 4;
            else
                a += 3;
        else
            if (scan (a+2,1))
                if (scan (a+2,0))
                    a += 2;
                else
                    a += 1;
            else
                a += 0;
    else
        if (scan (a-4,1))
            if (scan (a-5,1))
                if (scan (a-5,0))
                    a -= 5;
                else
                    a -= 4;
            else
                a -= 3;
        else
            if (scan (a-2,0))
                a -= 2;
            else
                a -= 1;
}
/****
 * Controllo danni e tempo passato in un angolo
 ****/
check ()
{
    if ((damage()!=d) || (t>100))
        return (0);
    ++t;

    return (1);
}
/****
 * Routine di movimento iniziale
 ****/
first_move ()
{
    x = loc_x();
    y = loc_y();

    if (x<500) {
        if (y<500) {
            /* quad 0,0 */
            move_o (0);
            move_s (1);
        } else {
            /* quad 0,1000 */
            move_n (0);
            move_o (1);
            move_s (1);
        }
    } else {
        if (y<500) {
            /* quad 1000,0 */
            move_s (0);
        } else {
            /* quad 1000,1000 */
            move_e (0);
            move_n (1);
            move_o (1);
            move_s (1);
        }
    }
}
/****
 * Routine di movimento verso nord
 ****/
move_n (control)
int control;
{
    go (90);
    start_angle = 180;
    while (loc_y() < 850) shot_p ();
    while (loc_y() < 940) fire_m (270);
    drive (90, 0);
    while (speed() > 49) fire_m (270);
    arrivo (180,control);
}
/****
 * Routine di movimento verso sud
 ****/
move_s (control)
int control;
{
    go (270);
    start_angle = 0;
    while (loc_y() > 150) shot_p ();
    while (loc_y() > 60) fire_m (450);
    drive (270, 0);
    while (speed() > 49) fire_m (450);
    arrivo (0,control);
}
/****
 * Routine di movimento verso est
 ****/
move_e (control)
int control;
{
    go (0);
    start_angle = 90;
    while (loc_x() < 850) shot_p ();
    while (loc_x() < 940) fire_m (180);
    drive (0, 0);
    while (speed() > 49) fire_m (180);
    arrivo (90,control);
}
/****
 * Routine di movimento verso ovest
 ****/
move_o (control)
int control;
{
    go (180);
    start_angle = 270;
    while (loc_x() > 150) shot_p ();
    while (loc_x() > 60) fire_m (360);
    drive (180, 0);
    while (speed() > 49) fire_m (360);
    arrivo (270,control);
}
/****
 * Routine di fuoco in movimento
 ****/
fire_m (max_angle)
int max_angle;
{
    if (range = scan (angle_m,5))
        cannon (angle_m,range);
    else {
        range = 4000;
        angle_m += 10 - (angle_m==max_angle)*190;
    }
}
/****
 * Routine di supporto
 ****/
go (angle)
int angle;
{
    angle_m = angle;
    drive (angle, 100);
}

arrivo (angle, control)
int angle, control;
{
    a = angle;
    if (control) fire_f ();
}

