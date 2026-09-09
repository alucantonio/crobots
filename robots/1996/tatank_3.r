/************************************************************************
Crobot:                 TATANK_3.R             (Crobot di seconda scelta)
*************************************************************************
Autore:                 Polverari Leonardo
*************************************************************************
Tattica:                All'inizio del gioco il robot si sposta verso             
                        l'angolo pi— vicino, poi esegue un movimento a 
                        triangolo. Se il robot accumula danni troppo   
                        consistenti muove verso l'angolo successivo.
                        Se i danni sono inferiori al 60% e si sono
                        superati i 100000 cicli il robot cambia angolo
                        continuamente.
*************************************************************************
Obiettivo:              Superare le eliminatorie               
*************************************************************************
Priorit…:               Nel caso si rendesse necessario limitare i 
                        combattimenti ad un solo crobot per concorrente 
                        questo crobot non va' utilizzato
************************************************************************/



int ang,p,x,y,range,direz,d1,flag;
int limsup,liminf,danno,ciclo;

main()
{
flag=2;
x=loc_x();
y=loc_y();
limsup=920;
liminf=80;
danno=30;
ciclo=0;
ang=0;

/* stabilisce la direzione in cui muoversi */
if ((x>=500) && (y>500)) p=90;
if ((x<=500) && (y>500)) p=180;
if ((x<=500) && (y<500)) p=270;
if ((x>=500) && (y<500)) p=0;

Vai(); 

/* ciclo principale, dove viene effettuato un movimento a triangolo */
while (1)
        {
        d1=damage();
        drive (p+90,100);
        if (p==90) while (loc_x()>720) fuoco1();
        if (p==180) while (loc_y()>720) fuoco1();
        if (p==270) while (loc_x()<280) fuoco1();
        if (p==0) while (loc_y()<280) fuoco1();
        drive (p+225,0);
        while (speed()>49) fuoco1();
        drive (p+225,100);
        if (p==90) while (loc_x()<limsup) fuoco1();
        if (p==180) while (loc_y()<limsup) fuoco1();
        if (p==270) while (loc_x()>liminf) fuoco1();
        if (p==0) while (loc_y()>liminf) fuoco1();
        drive (p,0);
        while (speed()>49) fuoco1();
        drive (p,100);
        if (p==90) while (loc_y()<limsup) fuoco1();
        if (p==180) while (loc_x()>liminf) fuoco1();
        if (p==270) while (loc_y()>liminf) fuoco1();
        if (p==0) while (loc_x()<limsup) fuoco1();
        drive(p+90,0);
        while (speed()>49) fuoco1();
        if (d1>dannorif || (d1<60 && ciclo>50))   /* decide se cambiare angolo */
                {
                p+=90;
                if (p==360) p=0;
                dannorif+=30;
                Vai();
                }
        ciclo++;
        }
}

/* routine di fuoco di veloce */
fuocoP()
{
ang+=20;
if (range=scan(ang,10)) cannon (ang,range);
}


/* routine di fuoco di precisione */
fuoco1()
{
direz=0;
if (range=scan(ang,10)) 
        {
        if (range<720 && range>20)
                {
                direz=1;
                cannon (ang,range);
                if (range=scan(ang+=5,5)) 
                        {
                        cannon (ang,range);
                        if (range=scan(ang+=3,3)) 
                                cannon (ang,range);
                        if (range=scan(ang-=3,3)) 
                                cannon (ang,range);
                if (range=scan(ang-=5,5)) 
                        {
                        cannon (ang,range);
                        if (range=scan(ang+=3,3)) 
                                cannon (ang,range);
                        if (range=scan(ang-=3,3)) 
                                cannon (ang,range);
                        }
                }
        }
}

if (direz==0) ang-=20;

}

/* Routine di posizionamento in un angolo */
Vai()
{
drive (p+270,100);
if (p==180) while (loc_y()<limsup) fuocoP();
if (p==270) while (loc_x()>liminf) fuocoP();
if (p==0)  while (loc_y()>liminf) fuocoP();
if (p==90)  while (loc_x()<limsup) fuocoP(); 
drive (p,0);
while (speed()>49);
drive (p,100);
if (p==180) while (loc_x()>liminf) fuocoP();
if (p==270) while (loc_y()>liminf) fuocoP();
if (p==0) while (loc_x()<limsup) fuocoP();
if (p==90) while (loc_y()<limsup) fuocoP(); 
drive (p,0);
while (speed()>49);
}


                                   
