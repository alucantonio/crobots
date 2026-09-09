/*
				   VANNINA

      Questo robot si muove in  una direzione casuale  fino a raggiun-
    gere uno dei lati dell' arena, muovendosi ad una velocita' limita-
    ta (40). Se subisce dei danni aumenta la velocita' e, se sono con-
    sistenti (5%), cambia anche direzione.
      La funzione di sparo e' stata ricavata da 'cube', ma  migliorata
    in modo abbastanza sensibile.


      Realizzato da 

		Andrea Murru (MC4327)
*/

int     an, sc_dir, sfas, oldd, dist, scd2, d;

main()
{
	an=rand(360);drive(an,100);
	d=damage();
	
	while (1) {
		  
		  if (loc_x()>800) an=rand(180)+90;
		  if (loc_x()<200) {an=rand(180)-90; if (an<0) an=360-90;}
		  if (loc_y()>800) an=rand(180)+180;
		  if (loc_y()<200) an=rand(180);
		  
		  /* Se si e' avvicinata ad un lato cambia direzione */
		  
		  if (damage()-d > 4) an=rand(360); 
		  
		  /* Se ha subito danni consistenti cambia direzione */
		  
		  drive(an,40+60*(damage()-d));
		  d=damage();
		  spara();
		  }
}

spara ()
{
	if (!(dist = scan (sc_dir, 5))) {
		if (dist = scan(sc_dir -= 10, 5)) sfas = -6;
		   else if (dist = scan(sc_dir -= 15, 10)) sfas = -10;
			   else if (dist = scan(sc_dir += 35, 5)) sfas = 6;
				   else if (dist = scan(sc_dir += 15, 10)) sfas = 10;
					   else {
						sc_dir-=100;
		 
		 /* Incomincia a cercare a 60ø in meno della precedente posizione angolare del nemico */ 
						
						while (!(dist = scan(sc_dir += 20, 10))) ;
						sfas = 0;
						oldd = dist;
						}
					 }
	if (dist<1000) {          
		      cannon(sc_dir + sfas, 2 * dist - oldd);
	
	/* Cerca di anticipare lo spostamento dell' avversrio, ipotizzando
	   che si sposti di quanto si e' spostato tra gli ultimi due rilevamenti */
		      
		      oldd = dist;
		      }
	else {
	/* Cerca un altro avversario */
	     
	     while (!(dist = scan(sc_dir += 20, 10)));
	     oldd = dist; 
	     sfas=0;
	     }
}





