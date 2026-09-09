/************************************************************************
 * Nome Robot: CASUAL                                                   *
 * Dati Autore:                                                         *
 * VIDALI MATTEO                                                        *       
 ************************************************************************/


/* casual.r */

int newx,newy,ang;

main()
{
        int direz,x=loc_x(),y=loc_y(); /*setta posiz. correnti*/
        newxy(); /*nuove coordinate calcolate in modo random*/
        direz=muovi(newx,newy);  /*calcola angolo per spostamento*/
        while(1)  {
                drive(direz,100);  
                if (newx<x)  {  /*controlla e realizza spostamento*/
                        if (newy<y)  {
                                while(loc_x()>newx && loc_y()>newy && speed())  fire();
                        } else  while(loc_x()>newx && loc_y()<newy && speed())  fire();
        
                } else {
                        if (newy<y)  {
                                while(loc_x()<newx && loc_y()>newy && speed())  fire();
                        } else  while(loc_x()<newx && loc_y()<newy && speed())  fire();

                }
                
                newxy();   /*altre coordinate random*/
                direz=muovi(newx,newy);  /*nuovo angolo*/
                while(speed()>50)  {    /*decrementa velocit… per cambiare direzione*/
                        drive(direz,50);
                } 
        }
}


newxy() /*funzione che calcola nuove coordinate*/
{
        newx=rand(700);  /* 300 e 700 sono i limiti dello spostamento*/
        if (newx<300) newx=300;
        newy=rand(700);
        if (newy<300) newy=300;
}
                            

muovi(x,y)    /*funzione che calcola angolo per spostamento*/
int x,y;
{
        int gradi,pos_x,pos_y;
        pos_x=loc_x();
        pos_y=loc_y();

        if (pos_x==x)  {
                if (y<pos_y)  gradi=270;
                else gradi=90;
        }  else  {
                if (y<pos_y) {
                        if (x>pos_x)
                                gradi=360+atan((100000*(pos_y-y))/(pos_x-x));
                        else    gradi=180+atan((100000*(pos_y-y))/(pos_x-x));
                } else if (x>pos_x)
                         gradi=atan((100000*(pos_y-y))/(pos_x-x));
                       else  gradi=180+atan((100000*(pos_y-y))/(pos_x-x));
        }
        return(gradi);
}

fire()    /*semplice funzione di sparo*/
{
        int range;
        if (range=scan(ang,10))
                cannon(ang,range);
        else ang+=20;

}
