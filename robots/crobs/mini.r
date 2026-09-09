/*
	MINI.R Minimal robot by Steve Glynn 76314,1552

	This robot started as an exercise to determine how little
	code was needed for a successful robot.

	I was surprised to discover that it in general beats the standard
	robots AND H-K.R

	One problem, however is fratricide. The strategy of running toward
	anything scanned, shooting wildly, produces a deadly embrace
	if two or more copies are present.
*/
main()
{
int angle;
angle = 0;

  while(1) {
	int range;
	drive(angle,49);		/* maximum speed for turning */
 
	while((range = scan(angle,10)))	/* shoot as soon as we see anything */
	{				/* and keep firing */
	    cannon(angle,range);
	}
	angle = (angle + 85) % 360;	/* scan in rough quadrants */
  }
    
}  /* end of main */ 



