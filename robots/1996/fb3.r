/*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3*FB3 */
/*                                                                        */
/* from: ZIMBA WATU                                                       */
/*              Davide Centurione                                         */
/*              Fabio Nobile                                              */
/*              Max Parolini                                              */
/*                                                                        */
/* FB3 e' una evoluzione di Boss Robot, si muove di un piccolo tratto     */
/* lungo i muri ovest e sud se colpito. Da fermo spara in teoria precisamente*/
/* dall'angolo (con lo stesso tipo di fuoco di HIDER2) ma non ci piace tanto.*/





/* Dichiarazione variabili */


int scan_angle;     /* angolo corrente della funzione seek()        */
int scan_range;     /* range di scan della funzione seek()          */
int d;              /* contatore dei danni                          */
int t;              /* contatore dei cicli passati in un angolo     */
int x,y;            /* coordinate iniziali                          */
int old_angle;      /* primo angolo di scan nella funzione shot()   */
int old_range;      /* primo range di scan nella funzione shot()    */
int a;              /* angolo corrente di scan                      */
int range;          /* range corrente di scan                       */

int Xa,Ya,Xb,Yb,Xc,Yc;   /*variabili di posizione del nemico */
int C1,C2,DeltaR,MSinFi; /*costanti per il calcolo della precisione di fuoco*/
int ang_su, ang_giu;

main ()
{
    ang_su = 358;
    ang_giu = 272;
    C1 = 4452;
    C2 = 3452;
    DeltaR = 215;

    drive (270,100);
    while (loc_y()>70) s_su();
    drive (270,0);
    while (speed()>49) s_su();

    drive (180,100);
    while (loc_x()>70) s_su();
    drive (180,0);
    while (speed()>49) s_su();

    while (1) {
        fire_f ();

        drive (90,100);
        while (loc_y()<250) s_giu();
        drive (90,0);
        while (speed()>49) s_giu();

        drive (270,100);
        while (loc_y()>60) s_giu();
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
    }
}


/*sparo lungo il muro sud*/
s_su ()
{
    if (((range=scan(ang_su,8))!=0) && (range<800)) {
        if (range>45)
            cannon (ang_su,range);
        else
            cannon (ang_su,45);
    } else {
        if (ang_su==534)
            ang_su=342;
        ang_su += 16;
    }
}

/*sparo lungo il muro ovest*/

s_giu ()
{
    if (((range=scan(ang_giu,8))!=0) && (range<800)) {
        if (range>45)
            cannon (ang_giu,range);
        else
            cannon (ang_giu,45);
    } else {
        if (ang_giu==448)
            ang_giu=256;
        ang_giu += 16;
    }
}


/*sparo di movimento iniziale*/

fire_f ()
{
    range = 4000;
    d = damage ();
    t = 0;
    a = 0;
    scan_angle = 5;

    while (check ()) {
        if (range < 4000)
            shot_p ();
        seek ();
    }
}

/*prima individuazione*/
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
    a += 10 - (a>90)*100;
}

/*sparo di precisione*/
shot_now ()
{
    find ();
    if (old_range = scan (a,5)) {
        old_angle = a;
        find ();
        if (range = scan (a,5)) {
            Xa=(old_range*cos(old_angle))/100000;
            Ya=(old_range*sin(old_angle))/100000;
            Xb=(range*cos(a))/100000;
            Yb=(range*sin(a))/100000;
            Xc=(Xb*C1-Xa*C2)/1000;
            Yc=(Yb*C1-Ya*C2)/1000;
            MSinFi=(((Xb-Xa)*Yc-(Yb-Ya)*Xc)*1000)/(DeltaR*sqrt(Xc*Xc+Yc*Yc));
            /*Angolo=atan(100000*Yc/Xc)-atan(100000*MSinFi/sqrt(1000000-MSinFi*MSinFi));*/
            a=atan(100000*Yc/Xc)-(180-2*a/9)*MSinFi/3141;
            range=100000*Xc/(cos(a)-100000*(Xb-Xa)/DeltaR);
            cannon(a,range);
            return;
        }
    }
    range = 2000;
}

/*individuazione esatta del nemico*/
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

/*ricerca nemico in movimento*/
seek ()
{
    if (((scan_range = scan (scan_angle,10)) < (range+100)) && scan_range) {
        a = scan_angle;
        range = 3000;
    }
    scan_angle += 20 - (scan_angle==85)*100;
}


/*routine controllo dei danni*/

check ()
{
    if ((damage()-d > 5) || (t>100))
        return (0);
    ++t;

    return (1);
}

