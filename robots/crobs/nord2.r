/* */
int R, angle, Range, Flag, Dam, Count;

main() {
        Dam = damage();
        while (1) {
                Pick_Rnd;
                drive(R, 49);
                angle = 0;
                while (angle < 360) {
                        Range = scan(angle,1);
                        if (40 < Range) {
                                cannon(angle, Range);
                                drive(angle, 49);
                                angle = angle - 6;
                                if (angle < 0)
                                     angle = angle + 360; }
                        else  {
                                drive(angle ,0); }
                        if (Dam != damage()) {
                                Count = 0;
                                R = rand(360);
                                drive(R, 100);
                                while (Count < 30) {
                                        Count = Count + 1; }
                                Dam = damage(); }
                        angle = angle + 2; }
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


