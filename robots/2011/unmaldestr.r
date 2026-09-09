/* CROBOT*/
/* Name: unmaldestrotentativodicreareuncrobotinvincibilecheconlobiettivooppostofinirà.r*/
/* Date: 05/10/2010 */
/* Author: Simone Chiarelli */
/* Category: 472/2000 (micro)*/

/**************************************************************
Introduzione:
-------------------
Dopo essermi letto attentamente il regolamento del torneo
(http://crobots.deepthought.it/home.php?link=163)
ho deciso che avrei partecipato con questo c-robot.
Come dice il nome stesso del c-robot, questo e' il risultato
di un maldestro tentativo di creare il c-robot invincibile e
questo risultato potrebbe portare a tre conclusioni:
O questo c-robot sara' imbattuto, o perdera' tutti i match
oppure li disputera' cercando di aggiudicarsi il miglior posto.

Descrizione:
-------------------
Il c-robot non ha strategie per il 4v4; ne ha una sola per
il f2f. Appena iniziato il match comincia ad attaccare
gli avversari forsennatamente.
**************************************************************/

int range, dir, oang, ang;
int b;
int posy, posx;

/* Il robot parte subito in boom */
/* Questa routine e' una versione modificata della boom() di taglia.r */
main()
{

		int b=0;
		while(1) {
            if ((posx=loc_x(posy=loc_y()))>880 ) dir=160+40*(posy>500);
            else if (posx<120) dir=340+40*(posy<500);
            else if ((posy)>880) dir=250+40*(posx<500);
            else if (posy<120) dir=70+40*(posx>500);                        
			else if (range>600) dir=ang+25+(b^=1)*235;
			else if (range<150) dir=ang+170+(b^=1)*25;
			else dir=ang+135+180*(b^=1);
			
			fuoco(drive(dir,100));
			fuoco(drive(dir,100));
			fuoco(drive(dir,100));
			drive(dir,60); 
        }
}

/* routine di fuoco unica, tanto il robot ha una sola strategia */
/* la routine e' quella di taglia.r senza modifiche */
fuoco()
{
	
	if ((range=scan(oang=ang,10))) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))     { if (scan(ang-=3,2)) ; else ang+=6; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
	} 
	else {
		if (range=scan(ang+=340,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=40,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=300,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=80,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=260,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=120,10)) return cannon(ang,3*scan(ang,10)-2*range);
		ang+=80;
	}
}