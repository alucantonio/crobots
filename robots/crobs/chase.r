/* Robot:      Chase          */
/*                            */
/* Designer:   Roger Trigg    */
/* Phone:      549-6606       */
/*                            */
/* One on one specialty robot */


main ()
{
int
  direction,
  run_offset,
  distance,
  second_distance;

  direction = 0;
  while (1) {
    while ((distance = scan (direction, 10)) == 0) {
      direction += 140;
    }/*endwhile*/
    if (distance > 200) {
      drive (direction, 100);
      run_offset = distance / 5;
    } else {
      run_offset = 2;
      drive (direction + 90, 100);
    }/*endif*/
    if ((second_distance = scan (direction, 4)) != 0) {
      cannon (direction, second_distance + run_offset);
    } else {
      if ((second_distance = scan (direction -= 8, 4)) != 0) {
        cannon (direction - 5, second_distance + run_offset);
      } else {
        if ((second_distance = scan (direction += 16, 4)) != 0) {
          cannon (direction + 5, second_distance + run_offset);
        }/*endif*/
      }/*endif*/
    }/*endif*/
  }/*endwhile*/
}/* end main */
