/**********************************************************************
 * Nome Robot : plump.r                                               *
 * Autore     : Sergio Chersovani                                     *
 * Strategia  : si muove lungo i lati nord e est modificando gli      *
 *              spostamenti in funzione della posizione del nemico    *
 *              con una buona precisione di tiro                      *
 **********************************************************************/


int	dir,range,dirfire,tmp;
main()
{
    while (loc_x()<800) {drive(0,100);
    if (range==0) { range=scan(dirfire+=20,10);}
    else spara(); }
    drive(dir=0,100);
    tmp=700;
    while (1) { if (damage()>75) tmp=550; muovi(); spara();}
}

spara()
{
    if ((range=scan(dirfire,10))>0) 
     { 
      precis();
     }
    else 
    { 
    if ((range=scan(dirfire+=20,10))==0) 
     { 
     if ((range=scan(dirfire-=40,10))==0) dirfire+=60;
     else precis();
     }
    else precis();
    }
    if (range>0) cannon(dirfire, range);
}

precis()
{
  if ((range=scan(dirfire+=5,5))==0) range=scan(dirfire-=10,5); 
  if ((range=scan(dirfire+=3,3))==0) range=scan(dirfire-=6,3);
}

muovi()
{
    if (loc_x()<=tmp && dir==180) dir = 0;
    else if (loc_x()>=850 && dir==0) { if ((scan(270,5)==0) && range>50) dir = 270; else {dir=180; dirfire=dir; } }
    else if (loc_y()<=tmp && dir==270) dir = 90;
    else if (loc_y()>=850 && dir==90) { if ((scan(180,5)==0) && range>50) dir = 180; else { dir =270; dirfire=dir; }} 
    drive(dir,100);
}
