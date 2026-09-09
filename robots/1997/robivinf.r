
/*ROBOT:   ROBIVINF                                             */
/*AUTORE: Roberto & Ivan Infante                             */
/*PRIORITA': prima scelta                                    */

int x,y,x0,y0,Dx,Dy,Lato,Dir,r,Parziale;
int Ang,Tratto,Deg,Rng,Old_Rng,Old_Range,old_rdge,Old_Ang,Previsto,Counter;
int Jump,tmp,Side,Lim1,Lim2,Lim3,Lim4,Num_Rob,Num_Osc,Radar,old_deg;


main()
{

        /* Valori iniziali */
        Lato = 250;
        Tratto = 100;
        Counter = 34;
        Parziale = 0;
        Num_Rob = 0;
        Num_Osc = 0;
        Radar = 0;

        Lim1 = 999-Tratto;
        Lim2 = 999-Lato;
        Lim3 = Lato;
        Lim4 = Tratto;

        Side=-1;

        /* spostamento iniziale */
        y0=loc_y();
        x0=loc_x();

        if (y<500)
                vai(x0,y0,999,Lato,270);
        else
        {
                vai(x0,y0,999,999-Lato,90);
                Side = 1;
        }

        Previsto=damage()+Counter;

        /* movimento vicino lo spigolo pi— vicino */
        while (1)
        {

                if (Num_Osc == 20)
                {
                        Num_Osc = 0;
                        Radar = 70;
                        while (Radar < 280)
                                Num_Rob +=(scan(Radar+=19,10)!=0);
                        if (Num_Rob < 2) attacca();
                        Num_Rob = 0;
                }

                drive(Dir,100);

                if (Side == 1)
                        if (Dir==90)
                                while (loc_y()<Lim1) fuoco();
                        else
                                while (loc_y()>Lim2) fuoco();
                else
                        if (Dir==90)
                                while (loc_y()<Lim3) fuoco();
                        else
                                while (loc_y()>Lim4) fuoco();

                drive(Dir,0);
                while (speed()>40);


                /* eventuale cambio di spigolo */
                if ((damage()>Previsto) && !(scan((Parziale=360-Dir),10)) && !(scan(Parziale+20*Side,10)))  
                {  
                        Side *= -1;  
                        while (speed()>49);  
                        drive((Dir=Parziale),100);  
  
                        if (Dir==90)
                                while (loc_y()<Lim1) fuoco();  
                        else   
                                while (loc_y()>Lim4) fuoco();  
  
                        drive(Dir,0);  
                        Previsto=damage()+Counter;  
                        while(speed()>49);  
                }  

                /* incremento del contatore  */
                Dir = 360 - Dir;
                ++Num_Osc;

                

        }

}

/*fine main*/


/* spostamento verso x2,y2 da x1,y1 */
vai(x1,y1,x2,y2,tmp)
{
        Dx=x1-x2;
        Dy=(y1-y2)*100000;
        Dir=360+atan(Dy/Dx);

        while((x=x2-loc_x())*x+(y=y2-loc_y())*y>8100)
        {
                drive(Dir,100);
                fuoco();
        }
        drive(Dir,49);
        while((x=x2-loc_x())*x+(y=y2-loc_y())*y>225);

        drive((Dir=tmp),49);
}


fuoco()
{
        if (!(Rng=scan(Deg,10)))
                if (!(Rng=scan(Deg-=20,10)))
                        if (!(Rng=scan(Deg+=40,10)))
                        { Deg+=40; return; }

        if (!scan(Deg+=5,5)) Deg-=10;
        if (!scan(Deg+=3,3)) Deg-=6;
        if (r=scan(Deg,10)) cannon(Deg,r+r-Rng);
        if (Rng>705) Deg+=40;
}



attacca()       /* attacco dinamico */
{
        Rng=0;
        Jump = 50;

	while(1)
	{
		Ang+=344;  
                while(!Rng)
		{
                        if (Rng=scan(Deg,11)) /* Se trova un nemico... */
			{
                                cannon(Deg,Rng); /* ...lo spara... */
                                drive(Dir=Deg,100); /* ... e lo insegue */
                                fuoco3();
                                Rng=0;  
                                Deg=Dir+155*(old_rdege<200);  
			}
                        else Deg+=14; 
		}
	}
}

fuoco3()
{
        while (Rng && Rng<638)  /* Sparo dinamico */
	{
                old_deg=Deg; 
                old_rdege=Rng; 
                Deg+=4-(scan(Deg-4,4) != 0)*8; 
                Deg+=2-(scan(Deg-2,2) != 0)*4;
                if ((Rng=scan(Deg,10))>150) 
		{          
                        Deg+=1-(scan(Deg-1,1) != 0)*2; 
                        cannon(Deg+(Deg-old_deg)*Rng/198,Rng+(Rng-old_rdege+Jump)*Rng/275);
		}
		else 
		{  
                        if (Rng<60 && Rng) Rng=60;  
                        if (Rng) cannon(Deg,7*Rng/8);   
		}
                if (speed()<51 || (Deg-Dir)*(Deg-Dir)>397)
		{
                        drive(Deg,100);
                        Dir=Deg;
			Jump=25;   
		}
		else Jump=50;
	}
}


