/**
 * Robot that bumps into the walls, but
 * otherwise, it's fine.
 *
 * Author: Mike Jonkmans
 */

int dir;
int sd;
int osd;
int dist;
int odist;
int fired;

main () {
	while (1) {
		drive (500, 500);
		while (!(dist = scan (sd += 20, 10))) 
			;
		
		cannon (sd, dist);

		while (dist) {

			move ();

			zoom (osd = sd, odist = dist); /* 45 cycles */

			while (!fired && dist) {
				move ();

				shoot ();

				zoom (osd = sd, odist = dist);
			}
			fired = 0;
		}
	}
}

move () {
	if (dist > 500)
		drive (dir = sd, 100);
	else
		drive (dir = sd + 180 * rand (1) - 90, 100);
}

zoom () {
	if (scan (sd + 13, 10)) sd += 3; else if (scan (sd -13, 10)) sd -= 3;
	dist = scan (sd, 10);
}

shoot () {
	if (!(dist < 5))
		fired = cannon (sd + sd - osd, dist + dist - odist);
}
