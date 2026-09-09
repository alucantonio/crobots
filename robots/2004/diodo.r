/*
Nome            : DIODO.r
Versione        : 1.0
Autore		: Angelo Ciufo


Versione ridotta di Colosseum.r del 2002.
Deriva da fizban del 2001, in particolare nel moto quadratico.
E' un notevole miglioramento di Vauban.r del 2002.


*/

int vel,r_coord,x_pos,y_pos;
int ang,a,r,or;
int time,run,d,gradi,conta;

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
                            while (loc_x()<=500) spara(0);
                            drive(90,0);

                            while (loc_y()<=500) spara(90);
                            drive(180,0);

                            while (loc_x()>500) spara(180);
                            drive(270,0);

                            while (loc_y()>500) spara(270);
                            drive(0,0);
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
     if(or=scan(a,10))
     {
           if (r=scan(a,4)) return cannon(a,3*scan(a,10)-r-or);
           else if (r=scan(a-=7,3)) return cannon(a-6,3*scan(a,10)-r-or);
           else if (r=scan(a+=16,4)) return cannon(a+6,3*scan(a,10)-r-or);
           else return;
     } else if(scan(a+=21,10));
     else if(scan(a-=42,10));
     else if(scan(dir,10)) a=dir;
     else return (a+=84);
}

