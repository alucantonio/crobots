/* randGuard.c */
/* author name : Ceyrolle */
/* author surname : Arnaud */
/* strategy : move randomly, check if target & fire */

int dir;

main() {
    int i,j,n;

    /* inits */
    n = 10;

    while(1) {
	moverand();
        /* keep direction at least n times */
        j=0;
        while (j < n) {
            /* drive to it */
            drive(dir,20);
            /* check in all 4 cardinal directions */
            i=90;
            while (i <= 360 ) {
                lookAndFire(i);
                i+=90;
            }
            j+=1;
        }
    }
}


moverand() {
    int change_dir;
    int border;
    int max;
    int min;

    /* inits */
    border = 30;
    max = 1000 - border;
    min = border;
    change_dir = 1;

    while (change_dir) {
	/* pick a random direction */
	dir = rand(360);
	/* check if we are going to hit the border with this dir */
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

}


lookAndFire(deg) {
    int range;
    /* if found someone */
    range = scan(deg,5);
    if ( range ) {
	/* stops */
	drive(0,0);
	/* and fire */
	cannon( deg, range);
    }
}
