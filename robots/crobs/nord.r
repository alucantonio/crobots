/* */
int R, angle, Range, Flag, Dam;

main() {
        Dam = 0;
        while (1) {
                Pick_Rnd;
                drive(R, 49);
                angle = 0;
                while (angle < 358) {
                        Range = scan(angle,1);
                        if (40 < Range) {
                                cannon(angle, Range);  
                                angle = angle - 2; }
                        if (Dam != damage()) {
                                Pick_Rnd;
                                drive(R, 49);
                                Dam = damage(); }
                        angle = angle + 1; }
        }
}

Pick_Rnd() {
        Flag = 1;
        while (Flag == 1) {
                R = rand(360);
                if ( (( 90 < R < 270) && (loc_x() < 100))||
                     ((  0 < R < 180) && (loc_y() > 900))||
                     ((180 < R < 360) && (loc_y() < 100))||
                     ((  0 < R <  90) && (loc_x() > 900))||
                     ((270 < R < 360) && (loc_x() > 900)));
                else
                  Flag = 0;
        }
}

