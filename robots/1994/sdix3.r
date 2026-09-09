/*  == SDix3 ==  di  Federico Macchi   29/09/1994

    Questo robot staziona in un angolo per sparare in continuazione fin 
    quando non viene disturbato o quando, essendo stata chiamata la 
    routine di sparo, non sono stati sparati un certo numero di colpi, 
    in tal caso cambia angolo. 
    Corregge lo sparo a seconda che il robot nemico si stia allontanando 
    o avvicinando; inoltre mentre si sposta sul fondo delllo schermo
    ricerca robot davanti e dietro di sè, in modo da recar danno a quei 
    robot che usano la stessa tattica.
*/

int danno, ang, new, old, d, x, y; /* new e old contengono la nuova e vecchia
                                      distanza del robot intercettato 
                                      d Š il quadrato della distanza da n punto
                                      x,y sono usate per calcolare le distanze
                                    */
int ad,as,nd,ns,m,i,mod;      /* mod,m sono modifiche dell'angolo  
                                 e della distanza di sparo in funzione 
                                 del movimento del robot 
                                 i conta il numero di volte in cui non
                                 vengono sparati colpi */
                       
main()
{
        int dir;
        ang=0;
        ad=0;
        as=0;
        drive(dir=atan((loc_y()-50)*100000/(loc_x()-50))+180,100);                     
                /* Si porta verso l'angolo in basso a sinistra */
        while(dist_a()>5500) 
        {
                sp_fondo();
                drive(dir,100);
        }
        
        while(1) {                   /* Routine principale */
                drive(0,0);
                i=20;
                danno=damage();
                while((!(damage()-danno)) && (i)) 
                       sp_a();
                
                drive(0,100);
                m=5;
                mod=1;
                while(dist_b()>5500) 
                {
                       sp_fondo();
                       drive(0,100);
                }
                
                drive(0,0);
                i=20;
                danno=damage();
                while((!(damage()-danno))&&(i)) 
                       sp_b();
                
                drive(180,100);
                m=-5;
                mod=-1;
                while(dist_a()>5500) 
                {
                       sp_fondo();
                       drive(180,100);
                }
                
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

sp_a()
{
        i-=1;
        if(new=scan(ang,10)) {        /* Routine di sparo da ang. basso-sin */
                if(!(old)) i+=cannon(ang,new*11/10);
                else i+=cannon(ang,new*3-old*2);
                }
        else ang=(ang+16)%90;
        old=new;
}             

sp_b()
{
        i-=1;
        if(new=scan(ang+90,10)) {        /* Rout. di sparo da ang. basso-des */
                if(!(old)) i+=cannon(ang+90,new*11/10);
                else i+=cannon(ang+90,new*3-old*2);
                }
        else ang=(ang+16)%90;
        old=new;
}

sp_fondo()
{
        if(new=scan(ang,10)) {        /* Routine di sparo dal bordo in basso */
                if(new<old) cannon(mod*(1+(new>350))+ang,new*9/10);
                else cannon(mod*(1+(new>350))+ang,new*11/10);
                }
        else ang=(ang+16)%180;
        old=new;


        if((nd=scan(ad-4,1))>47)  /* sparo destra */
                cannon(ad-4,nd-m);
        else angd=(ad+4)%8;

        if((ns=scan(as+176,1))>47) /* sparo sinistra */
                cannon(ad+176,ns+m);
        else angs=(as+4)%8;
}
