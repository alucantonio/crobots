/*
*/

int t,z,vdist;
int deg,ang,odeg,gitt,ogitt,dor,dan,anni,last,flag4;

main()
  {
        Peugeot(180*(loc_x()<500));
	Peugeot(90+180*(loc_y()<500));
        while (t=last=anni=20)
	{

                while ((anni+=20)<400) last+=(scan(anni,10)>0);
                if (last>21)
                while(--t)                                                   /*inizia il loop, nel quale, con una routine copiata da goblin, calcola l' angolo*/
                {
                        if(dan<damage()-5)
                        {
                                if (Scan(dor=180*(loc_x(dan=damage())>500)))    /*controlla se l' angolo precedente e' libero*/
                                {
                                        Peugeot(dor);
                                }
                                else if ((Scan(dor=90+180*(loc_y()>500))))              /*controlla se l' angolo seguente e' libero*/
                                {
                                        Peugeot(dor);
                                }
                        }
                        Vegeth_fire(0);
                  }
                else
                {
                        Peugeot(90+180*(loc_y(z=500)>500));
                        while (1)
                        {
                                Peugeot(180*(loc_x()>500));
                                drive (ang+180,48);
                        }
                }
        }
  }

Peugeot(k)  /*Si sposta verso le coordinate date*/
int k;
  {
        if ((ang=k)>180)
                while (loc_y()>150+z) Vegeth_fire(1);
        else if (ang>90)
                while (loc_x()>150) Vegeth_fire(1);
        else if (ang>0)
                while (loc_y()<850-z) Vegeth_fire(1);
                   else
                while (loc_x()<850) Vegeth_fire(1);
   }

/* Utilities per raccogliere il codice */

Scan(y)
int y;
  {
	return ((scan(y+353,7)+scan(y+7,7))<400);			/*effettua una scansione allargata di 14 gradi*/
  }


Vegeth_fire(flag)
int flag;
{
  drive (ang,flag*100);
  if ((gitt=scan(deg,10))>120)
  {
        Ext_scan();
        if (ogitt=scan(odeg=deg,10))
        {
                Ext_scan();
                if (gitt=scan(deg,10))                
                        return cannon((odeg+(deg-odeg)*3-flag*(sin(deg-ang)/19500)),(gitt*160/(160+ogitt-gitt-flag*(cos(deg-ang)/4167))));
        }
  }
  if((gitt)&&(gitt<770));
  else
    if((gitt=scan(deg+=339,10)));
    else
      if((gitt=scan(deg+=42,10)));
      else
      return (deg+=40);
  cannon (deg,2*scan(deg,10)-gitt);
}

Ext_scan()   
{
  if(scan(deg-8,4)) deg-=8;
  if(scan(deg+8,4)) deg+=8;
  if(scan(deg-4,2)) deg-=4;
  if(scan(deg+4,2)) deg+=4;
  if(scan(deg-1,1)) deg-=2;
  if(scan(deg+1,1)) deg+=2;
}
