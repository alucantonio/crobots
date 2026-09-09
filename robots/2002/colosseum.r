/*
Nome            : Colosseum.r
Versione        : 4.0a
Autore		: Angelo Ciufo

Basato su fizban del 2001.
Difende e attacca con quadrati.

*/

int vel,r_coord,x_pos,y_pos;
int ang,a,r,or;
int time,run,d,gradi,conta;
int deg,rng,dir,odeg,orng;

main()
{
        r_coord=822;
        while (run+=conta=gradi=10)
	{
                if (damage()>80) r_coord=837;
                x_pos=(loc_y(y_pos=(loc_x()<(vel=500))*(r_coord-=15*(++time>6)))<500)*r_coord;
                while ((loc_x()%890)>110) spara(ang=(loc_x()<500)*180);
                vel=0;
                spara(ang);
                while ((loc_y(vel=100)%890)>110) spara(ang=90+(loc_y()<500)*180);
                vel=0;
                spara(ang);
                while (((gradi+=21)<390)&&(conta<12))  if (scan(gradi,10)>0) {++conta;spara(a=ang=gradi);}
                vel=100;
                while (conta<12)
                {
                  while (1) {
                    while (loc_x()<=500) {
                      Fire(drive(0,100));
                    }
                    Turn(90);

                    while (loc_y()<=500) {
                      Fire(drive(90,100));
                    }
                    Turn(180);

                    while (loc_x()>500) {      
                      Fire(drive(180,100));
                    }
                    Turn(270);

                    while (loc_y()>500) {     
                      Fire(drive(270,100));
                    }
                    Turn(0);
                  }

                }
                while (--run)
                     { 
                        while(loc_y() <910-x_pos) spara(90);
                        while(loc_x() >r_coord-y_pos+90) spara(180);
                        while(loc_y() >r_coord-x_pos+90) spara(270);
                        while(loc_x() <910-y_pos) spara(0);
                     }

	}
}

spara(dir)
int dir;
{
     drive (dir,vel);
     if((r=scan(a,10))&&(r<850)) {
           if (r=scan(a,4));
           else if (r=scan(a-=7,3));
           else if (r=scan(a+=14,3));
           else return;
           cannon (a,r);
     } else if(scan(a+=21,10));
     else if(scan(a-=42,10));
     else if(scan(dir,10)) a=dir;
     else return (a+=84);
}  

Turn(d)
{
  while (speed()>70) drive(d,0);
  dir=d;
}


Fire()
{
    if (orng=scan(deg,10))
    {
        if (orng<420) 
        {
          if (orng<100) return cannon(deg,orng);
          if (scan(deg-10,6)) deg-=10;
          else if (scan(deg+10,6)) deg+=10;
          cannon(deg,(scan(deg,10)<<1)-orng);
          return;   
        }
        if (!scan(deg-=6,6)) deg+=12; 

        Find();

        if (orng=scan(odeg=deg,5))
        {
            Find();
            cannon(deg+(deg-odeg)*((1200+(rng=scan(deg,10)))>>9)-(sin(deg-dir)>>14),
                   rng*250/(250+orng-rng-(cos(deg-dir)>>12))); 
        } 
     }
     else
     {
        if (scan(deg-=20,10)) return Fire();
        if (scan(deg+=40,10)) return Fire();
        deg+=40; 
     }
}

Find()
{
  if(scan(deg-7,3)) deg-=7;
  if(scan(deg+7,3)) deg+=7;
  if(scan(deg-4,2)) deg-=4;
  if(scan(deg+4,2)) deg+=4;
  if(scan(deg-2,1)) deg-=2;
  if(scan(deg+2,1)) deg+=2;
}
