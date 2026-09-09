int ping;		/* flag to change direction... */

main()
{
	int dir;
	dir=0;

	ping=10;
	while(1)
	{
		dir=run(dir)-50;
	}
}

run(init)
{
	int dir;
	int olddir1, olddir2;
	int r;

	dir=init;
	while(dir<360)
	{
/*		if((r=scan(dir,10))&&r<=700)*/
		if(r=scan(dir,10))
		{
			dir-=10;
			olddir1=dir+20;
			while(dir<olddir1)
			{
/*				if((r=scan(dir,5))&&r<=700)*/
				if(r=scan(dir,5))
				{
					dir-=5;
					olddir2=dir+10;
					while(dir<olddir2)
					{
/*						if((r=scan(dir,1))&&r<=700)*/
						if(r=scan(dir,1))
						{
							mark(dir,r);
							return(dir);
						}
						dir++;
					}
				}
				dir+=5;
			}
		}
		dir+=20;
	}
	ping=10;
	return(0);
}


/* Some 'static' variables... */
int oldangle, oldrange;

mark(dir, r)
{
	int ddir;	/* drive direction */
	if(ping>9)
		cannon(dir, r);
	else
		cannon((dir-oldangle)*14/10+oldangle, (r-oldrange)*14/10+oldrange);

	oldangle=dir;
	oldrange=r;

	if(ping>5 || !speed())
	{
		ping=0;
		ddir=rand(90);
		if(loc_x()<500)
		{
			if(loc_y()>500)
				ddir+=270;
		}
		else
		{
			if(loc_y()<500)
				ddir+=90;
			else
				ddir+=180;
		}
		drive(ddir, 49);
	}
	ping++;
}
