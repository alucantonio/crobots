main()
{
  int angle, range;
  while(1) {
    while ((scan(angle,10)) > 0) {
		range=scan(angle,10);
	        drive(angle,100);
		if (range>10) cannon(angle,range);
    }
    angle += 20;
    angle %= 360;
  }
}
