/*

##       ##     ####       ####           ####
 ##     ##    ##    ##     ##  ##       ##    ##
  ##   ##    ##      ##    ##    ##    ##      ##
   ## ##     ##      ##    ##     ##   ##########
    ###      ##      ##    ##     ##   ##      ##
    ###       ##    ##     ##     ##   ##      ##
    ###         ####       #########   ##      ##

Crobots 	: Yoda
Type		: MiniCrobots type2
Version 	: 1.0
Author		: Maurizio Camangi
Begin		: 30-ott-2002
Revision	: 22-ott-2003


Yoda, senza spostarsi mai dal suo angolo, descrive un movimento oscillatorio perpendicolare
alla bisettrice dell'angolo stesso.
In ogni momento effettua un controllo sul numero di avversari rimasti.
Nel caso in cui sia rimasto un solo sopravvissuto adotta un movimento al centro dell'arena
di forma quadrata, ruotata di circa 10 gradi in senso antiorario, che varia in base alla
distanza del nemico.
                               ATTENZIONE


QUESTO C-ROBOT E' FATTO DI BIT AL 100%
NEL CASO IMPROBABILE CHE VENGA A CONTATTO CON ANTI-BIT DI QUALUNQUE TIPO
NE RISULTERA' UN'ESPLOSIONE.


                                AVVERTENZA


UN GIORNO, L'INTERO UNIVERSO (COMPRESO QUESTO C-ROBOT) POTREBBE COLLASSARE
IN UN PUNTO INFINITAMENTE PICCOLO. SE UN ALTRO UNIVERSO DOVESSE IN SEGUITO
EMERGERNE, L'ESISTENZA (ED IL FUNZIONAMENTO) DI QUESTO C-ROBOT IN
QUELL'UNIVERSO NON PUO' ESSERE GARANTITO.

*/

int ang, /* Angolo di scanning */
oang, /* Angolo di scanning precedente */
range, /* Gittata corrente */
orange, /* Gittata precedente */
dir, /* Direzione del cammino */
deg,
chk,
clock,
flag,
posx,
posy, /* Variabili temporanee ad un bit salva posizione */
x,
y,
dist1,
dist2,
enemy, /* Numero avversari */
f2f; /* Flag Face2Face */

dist(x,y) /* Distanza al quadrato (evita una sqrt())   */
int x,y;
{
        return (((x-=loc_x())*x+(y-=loc_y())*y));
}

degree(x,y)
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

the_force() {
	if (chk < 740) {
		enemy+=(scan(chk+=20,10) > 0);
	} else {
		f2f=(enemy <= 2); chk=enemy=0;
	}
}

int run_()
{
	drive(dir,100);
	if ((range=scan(oang=ang,10))&&(range<850)) {
	        if (!scan(ang+=355,5)) ang+=10;
	        if (!scan(ang+=357,3)) ang+=6;
	        cannon(ang+(ang-oang)*flag,2*scan(ang,10)-range);        

	} else {
        	if (range=scan(ang+=340,10)) return cannon(ang,range);
        	if (range=scan(ang+=40,10)) return cannon(ang,range);
        	if (range=scan(dir,10)) return cannon(ang=dir,range);
        	ang+=40;
    	}
}

int main() /* Inizializza alcune variabili ed innesca la routine principale */
{
	posy=loc_y(posx=loc_x()>500)>500;
	degree(x=250+500*posx,y=25+950*posy); /* micro1: 150, 700 */
	flag=enemy=chk=f2f=0;
	while (dist(x,y) > 7225) { /*the_force();*/ run_(); }
	dist2=1000-(dist1=650);	
	deg=135 + 90*(posy + posx - !posy*posx*2);
	while(1) {
		while(!f2f) {
			dir=deg+(clock^=1)*180;
			if (clock) while ((loc_y() < 915) && (loc_y() > 85)) { the_force(); run_(); } /* micro2: 915, 85 */
			else while((loc_x() > 85) && (loc_x() < 915)) { the_force();  run_(); }

		}
		flag=1;
		degree(x=650,y=500);
		while (flag) {
	
			while (loc_x() < dist1) { run_(); }
			dir=100;
			while (loc_y() < dist1) { run_(); }
			dir=190;
			while (loc_x() > dist2) { run_(); }
			dir=280;
			while (loc_y() > dist2) { run_(); }
			dir=10;
			dist2=1000-(dist1=(650 - 100*(range>300)));
		}
	}
}

/* May the Force be with you */