/*************************************************************************/
/**   NOME ROBOT: COURAGE            ** COURAGE  si posiziona sulla     **/
/**   DATA      : 01 - 09 - 1993     ** diagonale NO - SE del campo di  **/
/**   AUTORE    : Igor  Infante      ** battaglia, e si muove in senso  **/
/**                                  ** obliquo.     La funzione di     **/
/**               (studente)         ** sparo, fuoco(), fa in modo che  **/
/**                                  ** nel caso in cui venga individua-**/
/**                                  ** to un nemico la mira viene      **/
/**                                  ** progressivamente migliorata.    **/
/**                                  **                                 **/
/*************************************************************************/

int Ang, Range, Dir, Old_Range;

main()
{
    drive(GotoXY(500, 400), 100);   /* posizionamento iniziale */
    while (loc_x() < 610 && speed()) fuoco();

    while (1)   /* ciclo principale */
    {
         Dir = GotoXY(400, 500);
         drive (Dir, 50);   
         while (speed() > 50);
         drive (Dir, 100);
         while (loc_x() > 390 && speed()) fuoco();

         Dir = GotoXY(500, 400);
         drive (Dir, 50);   
         while (speed() > 50);
         drive(Dir, 100);
         while (loc_x() < 510 && speed()) fuoco();

     }
}

GotoXY(x, y)    /* ... vedi plot course ...*/
int x, y;
{
     int d, locx, locy; /* movimento in (x, y) */

     locx = loc_x();
     locy = loc_y();

     if (locx == x)
     {
         if (y > locy)
            d = 90;
         else
            d = 270;
     }
     else
     {
         if (y < locy)
         {
            if (x > locx)
               d = 360 + atan ((100000 * (locy - y)) / (locx - x));
            else
               d = 180 + atan ((100000 * (locy - y)) / (locx - x));
         }
         else if (x > locx)
               d = atan ((100000 * (locy - y)) / (locx - x));
         else
               d = 180 + atan ((100000 * (locy - y)) / (locx - x));
     }

     return (d);
}

fuoco()             
{
        if (Range = scan(Ang,3)) bang(); /* sparo */
        else
        {
                Ang -= 23;
                while (!(Range = scan(Ang, 10))) Ang += 20;
                if (Range < 60) Range = 60;
                bang();
        }
}

bang()
{
        if (Old_Range < Range)  /* miglioramento mira */
        {
                cannon(Ang, 8*Range/7);
                Old_Range=Range;
        }
        else
        {
                cannon(Ang, 7*Range/8);
                Old_Range=Range;
        }
}

