/*  == Didimo ==  di  Federico Macchi   29/09/1993

    Questo robot staziona in un angolo per sparare in continuazione fin 
    quando non viene disturbato, in tal caso cambia angolo. 
    Corregge lo sparo di un 10% sulla distanza, a seconda che il robot 
    nemico si stia allontanando o avvicinando
*/

int danno, ang, new, old, d, x, y; /* new e old contengono la nuova e vecchia
                                      distanza del robot intercettato 
                                      d Š il quadrato della distanza da n punto
                                      x,y sono usate per calcolare le distanze
                                    */
main()
{
        ang=0;
        drive(atan((loc_y()-50)*100000/(loc_x()-50))+180,100);                     
                /* Si porta verso l'angolo in basso a sinistra */
        while(dist_a()>5000) spara_da_fondo();
        
        while(1) {                   /* Routine principale */
                drive(0,0);
                danno=damage();
                while(!(damage()-danno)) spara_da_a();

                drive(0,100);
                while(dist_b()>5000) spara_da_fondo();

                drive(0,0);
                danno=damage();
                while(!(damage()-danno)) spara_da_b();

                drive(180,100);
                while(dist_a()>5000) spara_da_fondo();
        }
}

dist_a()
{
        x=loc_x()-50;
        y=loc_y()-50;
        d=x*x+y*y;
        return d;
}

dist_b()
{
        x=950-loc_x();
        y=loc_y()-50;
        d=x*x+y*y;
        return d;
}

spara_da_a()
{
        if(new=scan(ang,10)) {        /* Routine di sparo da ang. basso-sin */
                if(new<old) cannon(ang,new*9/10);
                else cannon(ang,new*11/10);
                }
        else ang=(ang+16)%90;
        old=new;
}             

spara_da_b()
{
        if(new=scan(ang+90,10)) {        /* Rout. di sparo da ang. basso-des */
                if(new<old) cannon(ang+90,new*9/10);
                else cannon(ang+90,new*11/10);
                }
        else ang=(ang+16)%90;
        old=new;
}

spara_da_fondo()
{
        if(new=scan(ang,10)) {        /* Routine di sparo dal bordo in basso */
                if(new<old) cannon(ang,new*9/10);
                else cannon(ang,new*11/10);
                }
        else ang=(ang+16)%180;
        old=new;
}
