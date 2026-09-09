/*
Nome del robot  : Charles.r
Autore		: Alessandro Tassara

Il robot cerca di non farsi massacrare dai nemici descrivendo un quadrato nell'
angolo scelto per defilarsi..
Quando subisce troppi danni cerca una nuova casetta e vi si trasferisce.
Le Toxiche sono utilizzate esclusivamente nell'attacco finale, dal momento
che non ho trovato un algoritmo sufficientemente compatto per poterle usare con
successo anche nella fase del medio-gioco.
								Dedicato a Z.
*/

int gitt, ogitt,deg,odeg,z,k,a,r,t,d,anni,last;

main()
{
	z=loc_y(k=loc_x()<500)<500;

	while (t=last=anni=10)
	{
		while(--t)					/*Percorre un quadrilatero in uno dei 4 angoli*/
		{
			if (d>damage()-26)
			{
                                while(loc_y() <910-z*790) {fire(90);}
                                while(loc_x() >880-k*790) {fire(180);}
                                while(loc_y() >880-z*790) {fire(270);}
                                while(loc_x() <910-k*790) {fire(0);}
                                drive (0,0);
                         }
			else
			{
				if (scan(90+z*180,10))
				if (scan(k*180,10)); else k^=1;
				else  z^=1;
				d=damage();
			}
		}

		while ((anni+=20)<390) last+=(scan(anni,10)>0);

		while(last<12)					/*Attacco finale da Arale*/
		{
                        if ((loc_y()<440)||(loc_y()>560))
			{
                                fire(90+180*(loc_y()>500));
			}
			else
			{
                                while (loc_x()>200) Vegeth_fire(180);
                                while (loc_x()<800) Vegeth_fire(0);
			}
		}
	}
}

Vegeth_fire(dir)
int dir;
{
  drive (dir,100);
  if ((gitt=scan(deg,10))>120)
  {
        Ext_scan();
        if (ogitt=scan(odeg=deg,10))
        {
                Ext_scan();
                if (gitt=scan(deg,10))                
                        return cannon((odeg+(deg-odeg)*3-(sin(deg-dir)/19500)),(gitt*160/(160+ogitt-gitt-(cos(deg-dir)/4167))));
        }
  }
  fire(dir);
}

fire(dor)
int dor;
{
  drive (dor,100);
  if((gitt=scan(deg,10))&&(gitt<770)) cannon (deg,gitt);
  else
    if((scan(deg+=339,10)));
    else
      if((scan(deg+=42,10)));
      else
      return (deg+=40);
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
