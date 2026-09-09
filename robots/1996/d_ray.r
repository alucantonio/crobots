/* NOME ROBOT:  d_ray
   AUTORE:      Aneloni Giovanni
   DESCRIZIONE: d_ray si muove lungo la diagonale invertendo il senso del moto
                se i danni si fanno ingenti e fermandosi nell'angolo in alto a
                destra se la situazione sembra tranquilla.
                per sparare usa una sola routine : fuoco.
   COMMENTI:    Š un robot estremamente semplice, ma mi sembra abbastanza
                costante nei risultati.
*/
int ang,scn,dmg;
main()
{
        angolo();
        while (1)
        {
                giu();
                dmg=damage();
                su();
                while (dmg==damage())
                {
                        drive (0,0);
                        fuoco ();
                        }
                }
        }
angolo()  /* si porta con precisione nell'angolo in basso a sinistra */
{
	while (dist(50,50)>15000)
	{
                fuoco();
                drive(dir(50,50),100);
                }
        }

su()    /* si porta nell'angolo alto a destra */
{
        int dmg;
        dmg=damage();
        while (loc_x()<900&&damage()-dmg<10)
        {
                fuoco();
                drive(45,100);
                }
        }
giu()   /* si porta nell'angolo in basso a sinistra */
{
        int dmg;
        dmg=damage();
        while (loc_x()>100&&damage()-dmg<10)
        {
                fuoco();
                drive(225,100);
                }
        }

fuoco()
{
        if(scn=scan(ang,6))             /* verifica se il nemico Š ancora a tiro */
         cannon(ang,scn-(scn>>4));
        else
         if(scn=scan(ang-13,7))         /* scanna i 72 gradi attorno all'ultimo sparo */
          cannon(ang-=13,scn);
         else
          if(scn=scan(ang+13,7))
           cannon(ang+=13,scn);
            else
             if(scn=scan(ang-28,8))
              cannon(ang-=28,scn);
             else
              if(scn=scan(ang+28,8))
               cannon(ang+=28,scn);
              else
               ang+=72;
        }
dir (x,y) /* V2.1 restituisce l' angolo sotto il quale viene visto un punto */
{
        x-=loc_x();
        y-=loc_y();
        if (x==0)
         if (y>0)
          return (90);
         else
          return (270);
        if (x>0)
         if (y>0)
          return(atan((100000*y)/x)); /* quad. bs */
         else
          return(360+atan((100000*y)/x)); /* atan negativa quad. as/*
        if (y>0)
         return(180+atan((100000*y)/x)); /* atan negativa quad. bd*/
        else
         return(180+atan((100000*y)/x)); /* quad. ad */
        }        
dist (x,y)
{
        x-=loc_x();
        y-=loc_y();
        return (x*x+y*y);
        }
