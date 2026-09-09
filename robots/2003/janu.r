/*

 ######     ####       ###     ##   ##     ##
   ##     ##    ##     ## ##   ##   ##     ##
   ##    ##      ##    ##  ##  ##   ##     ##
   ##    ##########    ##   ## ##   ##     ##
   ##    ##      ##    ##    ####   ##     ##
  ##     ##      ##    ##     ###   ##     ##
###      ##      ##    ##      ##     #####

Crobots 	: Janu
Type		: MiniCrobots type2
Version 	: 1.0
Author		: Maurizio Camangi
Begin		: 30-ott-2002
Revision	: 22-ott-2003


Janu è un'evoluzione di Anakin (del 2002). Janu non si sposta mai dal suo angoletto,
in cui descrive un movimento triangolare che restringe di alcune unità nel caso in cui
venga colpito.
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


int d,
ang, /* Angolo di scanning */
oang, /* Angolo di scanning precedente */
range, /* Gittata corrente */
orange, /* Gittata precedente */
dir, /* Direzione del cammino */
dist,
dist1,
dist2,
flag,
posx,
posy, /* Variabili temporanee ad un bit salva posizione */
enemy, /* Variabili temporanee */
cycle; /* Massimo numero di cicli virtuali */

int run_() /* Funzione di fuoco compatta */
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

int goto_(x,d) { /* Funzione di spostamento compatta */
        
        if ((dir=x)%180)
                while((dist=(posy*(1000-loc_y())+!posy*loc_y()))>d) run_();
        else
                while((dist=(posx*(1000-loc_x())+!posx*loc_x()))>d) run_();
}

degree(x,y) /* Usata solo nel f2f */
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

int main() /* Inizializza alcune variabili ed innesca la routine principale */
{

	flag=0;
        dist2=1000-(dist1=300); /* 250-300 */
        posy=loc_y(posx=loc_x(cycle=1)>500)>500;
        goto_(270-180*posy,100); /* 120 */
	dist2=1000-(dist1=650);
        while (goto_(180+180*posx,100)) /* 120 */
        {


                run_(dir=90+(180*posy));
                if ((cycle-=1) <= (enemy=0)) {
                        while(cycle < 380) { enemy+=(scan(ang+(cycle+=20),10)!=0);}

			if (enemy<=1) {
				degree(650,500);
				flag=1;
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
			} else cycle=6;
                }
                dist2=1000-(dist1=(300 - 100*(damage() > d)));
                while((dist=(!posy*(dist1-loc_y())+posy*(loc_y()-dist2)))>0) run_() ;
                goto_((315-90*posx)-(270-180*posx)*posy,90);
                d=damage();
        }
}

/* May the Force be with you */
/* Dedicated to RDX */