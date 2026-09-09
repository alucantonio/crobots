/* cantor.r

  Sandro Biraghi

  Questo e' il CRobottino di riserva, ha l'unico compito istituzionale
  di rompere le scatole a quei fantasiosi che fanno muovere le loro
  creature sui lati (come il mio Jager lo scorso torneo).
  La routine di fuoco shoot() e' banale, corregge il tiro in base al
  movimento dell'avversario e spara verso il centro del campo solo se 
  sul lato corrente non c'e' nessuno.
  Ogni volta che arriva all'angolo piu' a destra guarda se ci sono 
  avversari alle spalle nel qualcaso non combia lato.
  In caso contrario ruota do 90 gradi percorrendo percio' il lato
  successivo in senso antiorario.

						Sandro Biraghi
*/


int range,orange,D,dir,i,lato,Doomsday;

main() {

 Doomsday=1;                     /* essenziale inizializzazione */

 drive(D=270,100);               /* si porta sul lato sud */
 lato=0;                         
 while(loc_y()>100) shoot();
 drive(D,50);
 while(loc_y()>20);              /* posizionamento di precisione */
 drive(D,20);
 while(loc_y()>1);

 while(Doomsday) {     /* fino al giorno del Giudizio... */

  /* questa catena di if penso non abbia bisogno di commenti */

  if (lato==0) {D=360;
		drive(D,100);
		while(loc_x()<900) shoot();
		drive(D,50);
		while(loc_x()<990);
		drive(D,10);
		while(loc_x()<998);
		if((range=scan(D+180,10))==0) lato=1; /* cambia lato */
		  else {D=180;              /* c'e' qualcuno, rimani */
			drive(D,100);
			while(loc_x()>100) shoot();
			drive(D,0);
			while(speed()>49);
		       }
		}
  if (lato==1) {D=90;
		drive(D,100);
		while(loc_y()<900) shoot();
		drive(D,50);
		while(loc_y()<990);
		drive(D,10);
		while(loc_y()<998);
		if((range=scan(D+180,10))==0) lato=2;
		  else {D=270;
			drive(D,100);
			while(loc_y()>100) shoot();
			drive(D,0);
			while(speed()>49);
		       }
		}

  if (lato==2) {D=180;
		drive(D,100);
		while(loc_x()>100) shoot();
		drive(D,50);
		while(loc_x()>10);
		drive(D,10);
		while(loc_x()>1);
		if((range=scan(D+181,10))==0) lato=3;
		  else {D=0;
			drive(D,100);
			while(loc_x()<990) shoot();
			drive(D,0);
			while(speed()>49);
		       }
		}

  if (lato==3) {D=270;
		drive(D,100);
		while(loc_y()>100) shoot();
		drive(D,50);
		while(loc_y()>10);
		drive(D,10);
		while(loc_y()>1);
		if((range=scan(D+180,10))==0) lato=0;
		  else {D=90;
			drive(D,100);
			while(loc_y()<990) shoot();
			drive(D,0);
			while(speed() > 49);
		       }
		}



 }
}

shoot()
{
	drive(D,100); /* per evitare di rimanere fermi dopo una collisione */
	if((range=scan(D+180,10))>0) {dir=D+180;orange+=30;} /* spalle */
	 else {
	      if ((range=scan(D,10))>0) {dir=D;orange-=30;}  /* fronte */
		else if((range=scan(dir,10))==0) {dir+=20;return;}/* centro */

	 }

	cannon(dir,(695+(range>orange)*240)*range/800);  /* fuoco ! */

	orange=range;
}

