main()
int x,range,flag;
{
drive(rand(360),100);
    while(1)
    {
	flag=0;
	if (scan(x,10) == 0)
	    x+=200;
	while(flag==0)
	{
	    range=scan(x,10);
	    if (range != 0)
	    {
		if (range > 400)
		{
		    cannon(x,range);
		    drive(x,100);
		    x-=19;
		}
		else
		{
		    while ((range != 0) && (range < 500))
		    {
			x+=5-(scan(x-5,5) != 0)*10;
			x+=3-(scan(x-3,3) != 0)*6;
			range=scan(x,10);
			if (range>40)
			    cannon(x,range);
			if (range>100 || speed()<51)
			    drive(x-10,100);
		    }
		    flag=1;
		}
	    }
	    else x-=19;

	}
    }
}

