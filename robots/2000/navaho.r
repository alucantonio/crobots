/*
Nome del robot  : Navaho
Nome del file   : Navaho.r
Autore          : Gianni Ino

Il robot e' basato sul vincitore dello scorso anno.
La scheda tecnica puo' quindi essere rinvenuta tra le specifiche di Dav46.
Le modifiche sono veramente marginali, infatti:
Navaho non cambia mai angolo ne' conta mai i superstiti;
il robot oscilla con una tecnica diversa;
l'attacco finale non esiste: continua il movimento precedente, nella convinzione che in molti useranno la
routine di Satana o quella di Stealth e si troveranno a malpartito.
*/

int scn, angolo, oscn, oangolo;   
int dir,i,danni,c2;
int x,y;

main()
{
    if (loc_x ()<500) x=40; else x=960;
    if (loc_y ()<500) y=40; else y=960;
    vai (x,y);

    c2=2;
    while (1) {
        angle ();
        go ();
    }        
}

vai (x,y)
{
    dir=ang (x,y);
    drive (dir,100);
    while (dist(x,y)<2500) {drive (dir,100); fuoco(0);}
    while (dist(x,y)>1600) {drive (dir,100);}
    drive (dir,0);
}

/* Angolo per andare in una certa direzione */
ang(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }

angle()
{
    coords ();
    oscilla();
}


go ()
{
    i=0;
    if (loc_y()<500)
        if (free(90)) {y=960;i=1;}
        else lor ();
    else
        if (free(270)) {y=40;i=1;}
        else lor ();

    if (i) vai (x,y);
}

lor () 
{ 
    if (loc_x()<500) {
        if (free(0)) {x=960;i=1;}
    }
    else { 
        if (free(180)) {x=40;i=1;}
    }
}


oscilla ()
{
    while (1) {
    if (dist(x,y)<13500)
        {
                drive (dir,100);
                fuoco(0);
                while (speed()<100) fuoco(1);
                while (speed()>50) drive (dir,0);
        }
    if (dist(x,y)>10000)
        {
                drive (dir+=180,100);
                fuoco(0);
                while (speed()<100) fuoco(1);
                while (speed()>50) drive (dir,0);
                dir+=180;
        }
    }
    drive (dir,0);
}

coords()
{
    if (loc_y()<500) { 
        if (loc_x()<500) {dir=45;}
        else {dir=135;}
    }
    else { 
        if (loc_x()<500) {dir=315;}
        else {dir=225;}
    }
}

free (gradi)
{
    return (!scan(gradi+350,10) && !scan(gradi+10,10));
}

fuoco(flag)
{
    drive (dir,100);
    if (oscn=scan(angolo,10)) {
        if (!scan(angolo+=355,5)) angolo+=10;
        if ((oscn>800)) {angolo+=40; return;}
        if (flag) {
            if (!scan(angolo+=357,3)) angolo+=6;
            cannon(angolo,2*scan(angolo,5)-oscn); return;
        }        

        drive (dir,100);
            if(scan(angolo+355,1)) angolo+=355;
            if(scan(angolo+5,1)) angolo+=5;
            if(scan(angolo+357,1)) angolo+=357;
            if(scan(angolo+3,1)) angolo+=3;
            if(scan(angolo+359,1)) angolo+=359;
            if(scan(angolo+1,1)) angolo+=1;
  
        drive (dir,100);

        if (oscn=scan(oangolo=angolo,5)) {

            if(scan(angolo+355,1)) angolo+=355;
            if(scan(angolo+5,1)) angolo+=5;
            if(scan(angolo+357,1)) angolo+=357;
            if(scan(angolo+3,1)) angolo+=3;
            if(scan(angolo+359,1)) angolo+=359;
            if(scan(angolo+1,1)) angolo+=1;

            if (scn=scan(angolo,10)) {
                cannon(angolo+(angolo-oangolo)*((1200+scn)>>9)-(sin(angolo-dir)>>14),
                       scn*160/(160+oscn-scn-(cos(angolo-dir)>>12)));
            }
        }
    } 
    else {
        if (scan(angolo+=340,10)) return;
        if (scan(angolo+=40,10)) return;
        angolo+=40;
    }
}
