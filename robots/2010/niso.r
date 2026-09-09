/*
Nome            : Niso - micro
Versione        : 1.0
Autore		: Simone Ascheri

Commento
========

Trattasi di Doom2099... aggiornato????
Ho cambiato qualche costante ma non ho nemmeno testato
*/

int vel,r_coord,x_pos,y_pos;
int ang,oang,a,r,or,clock,don,dan;
int time,run,d,gradi,conta;
int si,z,oa,lim,cl,discr;
int ly,ul,ll,b,tempo,oscar,aq,xora,aa,count,dax,flag,flag1,nas,dri,oor,over,dver,danni,dor,daa,mm,ang,dr,do,aq,rng,t,dir,oldr,deg,odeg,dist,yora,xora;
int ang,pivot,pivot1,clock,corr;
main()
{
        r_coord=822;
	run-=8;
        while (run+=conta=gradi=10)
             {
                if (damage(vel=100)>80) {time=0;r_coord=822;}
                x_pos=(loc_y(y_pos=(loc_x()<500)*(r_coord-=10*(++time>5)))<500)*r_coord;

                while (--run)
                     { 
                        while(loc_y() <910-x_pos) CucchiaioKender(90);
                        while(loc_x() >r_coord-y_pos+90) CucchiaioKender(180);
                        while(loc_y() >r_coord-x_pos+90) CucchiaioKender(270);
                        while(loc_x() <910-y_pos) CucchiaioKender(0);
                     }
                CucchiaioKender(vel=0);

                while (((gradi+=21)<390))
			conta+=(scan(gradi,10)>0);
                while (conta<12)
                     {	
			discr=80+(loc_y()<500)*840;
			while((loc_y()>discr)==(z=(discr<500))) 
			{
				
				if(loc_x()>500)
				{
                                        Fuoco(165+30*z);
				}
				else
				{
                                        Fuoco(375-30*z);
				}
			}
		}
            }
}

CucchiaioKender(dir)
int dir;
  {
     drive (dir,vel);
     if((or=scan(oa=a,10))&&(or<800))
        {
           if (r=scan(a,3));
           else if (r=scan(a-=7,3));
           else if (r=scan(a+=14,3));
           else return a+=21;
	   cannon (a,r);
        }
     else
       if(scan(a+=20,10));
       else
         if(scan(a-=40,10));
         else
           if(scan(dir,10)) a=dir;
           else
             return (a+=80);
  }  

Fuoco(verso)
{
	drive (verso,100);
    if (oldr=scan(a,10)) {
           if (scan(a,2)) cannon(a,3*scan(a,10)-2*oldr);
           else if (scan(a-=7,6)) { cannon(a-5,2*scan(a,10)-oldr);}
           else if (scan(a+=14,6)) { cannon(a+5,2*scan(a,10)-oldr);}
	else return Fuoco(verso);
    } 
    else {
        if (oldr=scan(a+=339,10))	cannon(a,oldr);
        else if (oldr=scan(a+=42,10))	cannon(a,oldr);
        else if (oldr=scan(a+=297,10))	cannon(a,oldr);
        else if (oldr=scan(a+=84,10))	cannon(a,oldr);
        else a+=61;
    }
}





