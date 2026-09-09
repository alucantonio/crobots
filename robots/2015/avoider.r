/* avoider.c */
/* author name : Ceyrolle */
/* author surname : Arnaud */
/* strategy : shoot at 1 opponent at a time and try to protect himself by moving */



main() {
    int i;
    int d;
    int deg;
    int dist;
    int in_move;
    int in_approach;
    int last_damage;
    int nbDetected;
    int move_length;
    int move_ticks;


    /* const */
    move_length = 10;
    /* start as stopped */
    in_move = 0;
    last_damage = 0;
    move_ticks = 0;
    in_approach = 0;

    while(1) {
	if (!in_move) {
	    /* si dommages, bouger ailleurs */
	    d = damage();
	    if (d > last_damage) {
		last_damage = d;
		in_move = 1;
		movese();
	    }
	    /* scane le champ jusqu'a trouver un opposant */
	    deg=0; dist = 0;
	    while ( (deg <= 355) && (dist == 0) ) {
		dist = scan(deg,5);
		if (dist) {
		    if (dist > 300) {
			/* approach the opponent */
			in_approach = 1;
			drive(deg, 20);
		    } else {
			if (in_approach) {
			    /* if we were in approach, stop it */
			    in_approach = 0;
			    drive(0, 0);
			}
		    }
		    /* fire */
		    cannon(deg, dist);
		    cannon(deg, dist);
		}
		deg+=10;
	    }
	    /* si pas d'opposants vu, c'est qu'on est trop loin d'eux -> bouger */
	    if (!dist) {
		in_move = 1;
		movese();
	    }

	} else {
	    /* we are in move */
	    move_ticks+=1;
	    if (move_ticks > move_length) {
		move_ticks = 0;
		/* stop */
		drive(0,0);
		in_move = 0;
	    }
	}
    }
}


movese() {
    int change_dir;
    int border;
    int max;
    int min;
    int dir;

    /* inits */
    border = 30;
    max = 1000 - border;
    min = border;

    /* pick a random direction */
    dir = rand(360);
    change_dir = 0;
    /* test if near border */
    if ( (loc_x() > max) || (loc_x() < min) || (loc_y() > max) || (loc_y() < min) )
	change_dir = 1;
    /* if so, change direction */
    while (change_dir) {
	dir = rand(360);
	change_dir = 0;
	if ( (dir >= 0) && (dir <90) ) {
	    /* dir nord-est */
	    if ( (loc_x() > max) || (loc_y() > max) )
		change_dir = 1;
	}
	if ( (dir >= 90) && (dir <180) ) {
	    /* dir nord-ouest */
	    if ( (loc_x() < min) || (loc_y() > max) )
		change_dir = 1;
	}
	if ( (dir >= 180) && (dir <270) ) {
	    /* dir sud-ouest */
	    if ( (loc_x() < min) || (loc_y() < min) )
		change_dir = 1;
	}
	if ( (dir >= 270) && (dir <360) ) {
	    /* dir sud-est */
	    if ( (loc_x() > max) || (loc_y() < min) )
		change_dir = 1;
	}
    }
    /* when direction ok, drives towards */
    drive(dir, 20);
}

