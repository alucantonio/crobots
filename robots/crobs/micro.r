/*
	MINI.R Minimal robot by Steve Glynn 76314,1552

	This robot started as an exercise to determine how little
	code was needed for a successful robot.
*/
main()
{
int angle;
angle = 0;
while(1)
	{
	while(scan(angle,10)) cannon(angle,scan(angle,10));
	angle += 85;
	}
}
