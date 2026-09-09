/*      
      =======================================================
      =                                                     =
      =  Hack Attack                written by John Nordlie =
      =                                                     =
      =     A program solely dedicated to the destruction   =
      =       of other C robots.                            =
      =                                                     =
      =                     (c) 1990                        =
      =                                                     =
      =======================================================

                                                                  */
int R, angle, Range, Dam, Count;

main() {
        Dam = damage();
        while (1) {
                R = rand(360);
                drive(R, 49);
                angle = 0;
                while (angle < 360) {
                        Range = scan(angle,5);
                        if (Range > 40) {
                                cannon(angle, Range);
                                cannon(angle, Range);
                                drive(angle, 100);
                                angle = angle - 8;
                                if (angle < 0) {
                                     angle = angle + 360; }
                        }
                        if (Dam != damage()) {
                                Count = 0;
                                R = rand(360);
                                drive(R, 100);
                                while (Count < 40) {
                                        cannon(Count * 9, rand(400) + 40);
                                        Count = Count + 1; }
                                Dam = damage(); }
                        angle = angle + 3; }
        }
}


