/* Horse3.r by Summa Giovanni

    Horse si muove su 3 lati dell' arena con un movimento a U o ferro
    di cavallo sparando con una portata leggermente allungata o accorciata
    a seconda dell' aumento o diminuzione della portata.
    Pur mantenendo la stessa struttura di Horse2, in caso di danneggiamento
    invece di invertire la marcia, rallenta la sua andatura leggermente,
    e in caso di robot che si muovono lungo i lati, e piu' preciso (sono state
    eliminate alcune deviazioni non previste).
*/
int Direz,Ang,Dest,OldPort,OldDir,Vers,Dam,Fuga,NewAng;
main()
{
 Dest=0;
 Ang=340;
 Vers=1;
 Dam=0;
 Fuga=270;
 drive(Dest,100);
 while (1)
 {
  OldPort=0;
  OldDir=0;
  Direz=Ang;
  if (Dest == 0)
    {
     while (loc_x() < 910 && speed() > 0)
          {
           if (Vers)
              seek2();
           else
              seek();
           if (damage() > (Dam + 25))
             {
              drive(Dest,60);
              Dam=damage();
              if (Vers)
                 seek2();
              else
                 seek();
             }
          }
     drive(Dest,0);
    }
  else
    {
     if (Dest == 180)
       {
        while (loc_x() > 100 && speed() > 0)
             {
               if (Vers)
                   seek2();
               else
                   seek();
               if (damage() > (Dam + 25))
                 {
                  drive(Dest,60);
                  Dam=damage();
                  if (Vers)
                      seek2();
                  else
                      seek();
                 }
             }
        drive(Dest,0);
       }
     else
       {
        if (Dest == 90)
          {
           while ( loc_y() < 910 && speed() > 0)
                 {
                  seek2();
                  if (damage() > (Dam + 25))
                    {
                     drive(Dest,60);
                     Dam=damage();
                     seek2();
                    }
                 }
           drive(Dest,0);
          }
        else
          {
           while ( loc_y() > 100 && speed() > 0)
                {
                 seek();
                 if (damage() > (Dam + 25))
                   {
                    drive(Dest,60);
                    Dam=damage();
                    seek();
                   }
                }
           drive(Dest,0);
          }
       }
    }
  frena();
  if (Dest==0)
    {
     if (Vers)
       {
        Dest=90;
        Ang=70;
        Fuga=0;
       }
     else
       {
        Dest=270;
        Ang=290;
        NewAng=Ang - 220;
        Fuga=0;
       }
    }
  else
    {
     if (Dest == 180)
       {
        if (Vers)
          {
           Dest=0;
           Ang=20;
           NewAng= 180;
           Vers=0;
           Fuga=90;
          }
        else
          {
           Dest=0;
           Ang=340;
           Vers=1;
           Fuga=270;
          }
       }
     else
       {
        if (Dest==90)
          {
           Dest=180;
           Ang=160;
           Fuga=180;
          }
        else
          {
           Dest=180;
           Ang=200;
           NewAng= Ang - 220;
           Fuga=180;
          }
       }
    }
  drive(Dest,100);
 }
}
/* Funzioni di scansione e attacco */
/* funzione usata durante la marcia in senso orario */
seek()
{
 int Portata,Por_Rid,Dir_Rid;
 if (Portata=scan(Direz,10))
    {
     if (Direz > (Dest - 10))
       {
        if (Direz > (Dest - 7))
           Dir_Rid = Direz;
        else
           Dir_Rid = Direz - 1;
       }
     else
         Dir_Rid = Direz - 5 ;
     if (Portata > OldPort)
         cannon(Dir_Rid, 8 * Portata / 7);
     else
         cannon(Dir_Rid, 7 * Portata / 8);
     Direz+= 20;
    }
 OldPort=Portata;
 OldDir=Direz;
 Direz-= 20;
 if (Direz < 0)
     Direz += 360;
 if (Dest == 0)
    {
     if (Direz < NewAng && Direz > 20)
         Direz=Ang;
    }
 else
    {
     if (Direz < NewAng)
         Direz=Ang;
    }
}
/* funzione usata durante la marcia in senso anti orario */
seek2()
{
 int Portata,Por_Rid,Dir_Rid;
 if (Portata=scan(Direz,10))
    {
     if (Direz < (Dest + 10))
       {
        if (Direz < (Dest + 7))
           Dir_Rid = Direz;
        else
           Dir_Rid = Direz + 1;
       }
     else
         Dir_Rid = Direz + 5 ;
     if (Portata > OldPort)
        cannon(Dir_Rid, 8 * Portata / 7);
     else
        cannon(Dir_Rid, 7 * Portata / 8);
     Direz-= 20;
    }
 OldPort=Portata;
 OldDir=Direz;
 Direz+=20;
 if (Direz > (Ang + 220))
     Direz=Ang;
}
frena()
{
        while (speed() > 49)
             {
              if (Vers)
                 seek2();
              else
                 seek();
             }
}
