

/*  hak3.r     Hunter-Killer III  a.k.a.  submini

    Robot source by John Hardin           03/16/86
                    Westminster College
                    1840 South 1300 East
                    Salt Lake City, Utah  84105
                    [74076,22]

    strategy: Subminimal robot program. Scan the arena in 85 degree
              increments (precession will ensure we scan the entire
              arena). If we see a robot, charge at it firing continuously.
              Don't worry about taking hits.
              This robot is suicidal and fratricidal, but effective. */

/* modeled after t.r (MINI.ARC) by Steve Glynn [76314,1552] */

/* main */
main()
{
int dir;
int range;

  dir = 0;

  while(1)           /* Repeat Until dead */
  {
    drive(dir,50);   /* max speed and can still turn */
    while ((range = scan(dir,10))) cannon(dir,range);  /* while he's there, */
    dir += 85;       /* keep scanning */               /* shoot at him.     */
  }

}  /* end of main */

   /* compiled size: 38 instructions */