/* Revenge3 - Robot di Mario Pacchiarotti */
/* Corre piu' veloce che puo' mantenendosi piu' o meno nella zona centrale
   dello schermo, schizzando a caso in un'altra direzione quando si avvicina
   alle pareti. Spara cercando di intuire il movimento dell'avversario.... */

int	cx, cy;
int	course;
int	arrivato;
int	count, dist, deg, g, d, pdeg, pdist;
int	escape;
int	lx, ly;

main()
{
	lx = 250;
	ly = 750;

	while (1) {
		if (loc_x() < 500) {
			if (loc_y() < 500)
				course = rand(50) + 20;
			else 
				course = rand(50) + 290;
			while (speed() > 50) 
				drive(course, 0);
		} else
		 {
			if (loc_y() < 500)
				course = rand(50) + 110;
			else 
				course = rand(50) + 200;
			while (speed() > 50) 
				drive(course, 0);
		}

		drive(course, 100);
		escape = 0;
		arrivato = 1;
		while (arrivato) {
			spara();
			drive(course, 100);
			if (escape > 2) {
				cx = loc_x();
				if ( cx < lx || cx > ly )
					arrivato = 0;
				else
				 {
					cy = loc_y();
					if ( cy < lx || cy > ly )
						arrivato = 0;
				}
			} else
				++escape;
		}
	}
}


spara()
{
	count = 0;
	while ( ( dist = scan( deg, 5 ) ) == 0 ) {
		deg += 10;
		count += 1;
	}
	if ( count > 5 )
		cannon( deg, dist );
	else 
		cannon( deg + ((deg - pdeg) / 2), dist + ((dist - pdist) / 2) );
	pdeg = deg;
	pdist = dist;
	deg  -= 25;
}


