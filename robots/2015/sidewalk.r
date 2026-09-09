/* sidewalk.c */
/* author name : Ceyrolle */
/* author surname : Arnaud */
/* strategy : move to a border, go to the next clockwise corner, */
/* then go to the side corner and repeat */
/* while travelling, check if sees a target and */
/* if yes then stops and fire at it */


main() {
    int dir;
    int max;
    int look;
    int range;
    int margin;
    int border;

    /* inits */
    dir = 0;
    margin = 20;
    max = 1000;
    
    /* goes upward */
    while (loc_y() < max -  margin) {
        drive(90, 10);
    }
    drive(90,0);

    border = 1;
    
    /* MAIN */
    while(1) {
        if (border == 1) { /* north */
            if (loc_x() > max - margin) {
                border = 2;
            } else {
	        /* drive horizontally to the right */
                dir = 0;
                /* look under */
                look = 270;
            }
        } else if (border == 2) { /* west */
            if (loc_y() < margin) {
                border = 3;
            } else {
	        /* drive vertically to the bottom */
                dir = 270;
                /* look left */
                look = 180;
            }
        } else if (border == 3) { /* south */
            if (loc_x() < margin) {
                border = 4;
            } else {
	        /* drive horizontally to the left */
                dir = 180;
                /* look above */
                look = 90;
            }
        } else { /* = 4 */ /* east */
            if (loc_y() > max - margin) {
                border = 1;
            } else {
	        /* drive vertically to the top */
                dir = 90;
                /* look right */
                look = 0;
            }
        }

        drive(dir, 20);

	/* test */
	lookAndFire(look);
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
