main()
{
    int ang;

    ang = 0;
    while (1)
        Sdrive(ang = QuickSeek( ang , 10) , 50);
}

/* don't let me hit the wall !*/
int Sdrive( ang, speed )
int ang, speed;
{
    if (loc_x() < 50)
    {
        if (loc_y() < 50)
            return drive( 45, 50 );
        else
            return drive( 0, 50 );
    }
    if (loc_y() < 50)
        return drive( 90, 50 );
    if (loc_x() > 970)
    {
        if (loc_y() > 950)
            return drive( 225, 50 );
        else
            return drive( 180, 50 );
    }
    if (loc_y() > 950)
        return drive( 270, 50 );

    return drive( ang, speed );
}

/* this is the targeting mechanism */
int QuickSeek( ang,res )
int ang, res;
{
    int newres;
    int range;

    if (ang > 360) ang = 0;
    if (range = scan( ang, res ))
    {
        if (res > 4)                    /* have a blat - Rambo style ! */
            cannon( ang , range );      /* otherwise let cannon reload for */
        if (res < 3)                    /* a more precise hit */
        {
            cannon( ang, range );
            return ang;
        }
        newres = res / 2;
        if (scan( ang + newres, newres))
           return QuickSeek( ang + newres, newres);     /* recurse to a finer */
        return QuickSeek( ang - newres, newres);        /* resolution */
    }

    return QuickSeek( ang + 20, 10);                    /* nothing, try next sector */
}
