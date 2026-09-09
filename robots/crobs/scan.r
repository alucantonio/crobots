/*
	SCANNER.R - Scanning Robot
	Built to beat the standard robots (and SUBMIN.R)
	The following design parameters were used:
	- scan field rapidly using lowest resolution (greatest scan width)
	- if a target robot is spotted at a distance, move toward it
	- use higher and higher resolution to zero in on target
	- fire as quickly as possible
	- if robot disappears from scan, check adjacent sectors first
	- always keep moving to minimize damage from less accurate robots


	The scanning operation was designed to give good accuracy while providing results as quickly as possible.  It was determined that at long range, absolute accuracy was desirable in order to assure damage on the target robot.  However, at extremely short distances, accuracy was not as important.

	The implementation scans the field in wide swaths (21 degrees).  When a target is found, the field of view is narrowed to 9 degrees for the second scan.  If the target is not found, the sectors on either side are checked.  Once relocated, the field of view is again narrowed to 3 degrees, and then finally to 1 degree.

	The process is terminated early (at lower rresolution) for targets that are not a great distance away.

		                    degrees of arc
						--------------
		 0                   1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2
		 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6
		             *
		 ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^
4th		 | | | | | | * | | | | | | | | | | | | | | | | | | | |	

3rd		|<--->|<--->|<-*->|<--->|<--->|<--->|<--->|<--->|<--->|
	
2nd		|<-------*------->|<--------------->|<--------------->|
	
1st scan		 |<-------------------*------------------->|


Have fun with this one.  I'll be interested to hear from you if you have a robot of your own that can beat SCANNER.

     Randy MacLean 70446,70

*/
main()

{
int direction;
int distance;
int left;
int min_resolution;
int resolution;
int right;

direction = rand(360);

while(1)
	{
	distance = scan(direction,10);
	while(distance != 0)

		/* If there is a robot in the sector, find it and fire */

		{
		cannon(direction,distance);

		resolution = 16;
		offset = 9;
		min_resolution = (600 / distance) / 2;
		while (resolution > min_resolution)
			{
			resolution /= 4;
			left = (direction - offset) % 360;
			right = (direction + offset) % 360;
			if (scan(direction,resolution) == 0)
				{
				if (scan(left,resolution) != 0)
					direction = left;
				else
					{
					direction = right;
					}
				}
			offset /= 3;
			}
		distance = scan(direction,10);
		if (distance != 0)
			{
			cannon(direction,distance);
			drive (direction,(distance/10)+10);
			}
		else
		
		/* If the robot disappears look in the adjacent sectors */

			{
			direction = (direction - 20) % 360;
			distance = scan(direction,10);
			if (distance == 0)
				{
				direction = (direction + 40) % 360;
				distance = scan(direction,10);
				}
			}
		}

	/* If no robot found; set for normal speed and continue scanning */

	drive (direction,10);
	direction = (direction - 74) % 360;
	}
}
