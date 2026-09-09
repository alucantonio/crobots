/************************************************************************
Crobot:                 SECOND3.R                (Crobot di prima scelta)
*************************************************************************
Autore:                 Polverari Leonardo
*************************************************************************
Tattica:                All'inizio del gioco il robot si sposta in alto                 
                        a destra, ed esegue un movimento alto-basso 
                        alternato. Dopo circa 100000 cicli il movimento
                        cambia in destra-sinistra. Le routine di fuoco
                        sono molto primitive.
*************************************************************************
Obiettivo:              Superare le eliminatorie               
*************************************************************************
Priorit…:               Nel caso si rendesse necessario limitare i 
                        combattimenti ad un solo crobot per concorrente 
                        PREFERISCO VEDER COMBATTERE QUESTO. (SECOND3.R)
************************************************************************/


main()

{

int range,ang,limsup,liminf,ciclo,sicur;

ang=0;
limsup=950;
sicur=-70;
liminf=600;
ciclo=50;

/* posiziona il crobot nell'angolo superiore sinistro */
drive (0,100);
while (loc_x()<limsup) fuocoP(); 
drive(0,0);
while (speed()>49) fuocoP();
drive(90,100);
while (loc_y()<limsup+sicur) fuocoP();
drive(90,0);
while (speed()>49) fuocoP(); 


/* routine di movimento nei primi 100000 cicli */
while (ciclo)
{ 
drive (270,100);
while (loc_y()>liminf) fuoco11();
drive (270,0);
while (speed()>49) fuoco12();
drive (90,100);
while (loc_y()<limsup+sicur) fuoco11();
drive (90,0);
while (speed()>49) fuoco13(); 
--ciclo;
}

/* routine di movimento dopo i primi 100000 cicli */
while (1)
{ 
drive (180,100);
while (loc_x()>liminf) fuoco21(); 
drive (180,0);
while (speed()>49) fuoco22();
drive (0,100);
while (loc_x()<limsup+sicur) fuoco21();
drive (0,0);
while (speed()>49) fuoco13(); 
}



}


fuoco11()
{
if (range=scan ( 90,10)) cannon ( 90,range);
if (range=scan (110,10)) cannon (110,range);
if (range=scan (130,10)) cannon (130,range);
if (range=scan (150,10)) cannon (150,range);
if (range=scan (160, 5)) cannon (160,range);
if (range=scan (170, 5)) cannon (170,range);
if (range=scan (180, 5)) cannon (180,range);
if (range=scan (190, 5)) cannon (190,range);
if (range=scan (200, 5)) cannon (200,range);
if (range=scan (210, 5)) cannon (210,range);
if (range=scan (220, 5)) cannon (220,range);
if (range=scan (230, 5)) cannon (230,range);
if (range=scan (240, 5)) cannon (240,range);
if (range=scan (250, 5)) cannon (250,range);
if (range=scan (260, 5)) cannon (260,range);
if (range=scan (270,10)) cannon (270,range);
}

fuoco12()
{
if (range=scan (180,10)) cannon (180,range);
} 

fuoco13()
{
if (range=scan (270,10)) cannon (270,range);
} 

fuoco21()
{
if (range=scan (170,10)) cannon (170,range);
if (range=scan (180, 5)) cannon (180,range);
if (range=scan (190, 5)) cannon (190,range);
if (range=scan (200, 5)) cannon (200,range);
if (range=scan (210, 5)) cannon (210,range);
if (range=scan (220, 5)) cannon (220,range);
if (range=scan (230, 5)) cannon (230,range);
if (range=scan (240, 5)) cannon (240,range);
if (range=scan (250, 5)) cannon (250,range);
if (range=scan (260, 5)) cannon (260,range);
if (range=scan (270, 5)) cannon (270,range);
if (range=scan (280, 5)) cannon (280,range);
if (range=scan (290, 5)) cannon (290,range);
if (range=scan (300, 5)) cannon (300,range);
if (range=scan (310, 5)) cannon (310,range);
if (range=scan (320,10)) cannon (320,range);
if (range=scan (340,10)) cannon (340,range);
}

fuoco22()
{
if (range=scan (180,10)) cannon (180,range);
} 

/* routine di fuoco di veloce */
fuocoP()
{
ang+=20;
if (range=scan(ang,10)) cannon (ang,range);
}

