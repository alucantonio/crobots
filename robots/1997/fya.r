/* NOME ROBOT:  fya 
   AUTORE:      Aneloni Giovanni
*/        
int count,scn,ang,oscn;
main()
{
        count=0;
        while (loc_y()>70)              /* si mette in posizione */
        {
                drive (270,100);
                fuoco();
                }
        if (loc_x()<725)
         while (loc_x()<725)
         {
                drive (0,100);
                fuoco();
                }
        else
         while (loc_x()>725)
         {
                drive (180,100);
                fuoco();
                }
        while (++count<70)                      /*comincia il ciclo principale */
        {                                       
                while (loc_x()<930)
                {
                        drive (45,100);
                        fuoco();
                        }
                while (loc_y()>70)
                {
                        drive (225,100);
                        fuoco();
                        }
                }
                finale();
        }
fuoco() /* rambo3 - routine gestione tiro in movimento */
{
  if(30<(scn=scan(ang,10))&&scn<700)          
  {
        if(scan(ang-6,3))
         ang-=6;
        else
         if(scan(ang+6,3))
          ang+=6;
        cannon(ang,(scn<<1)-oscn);
        }
  else
    if((scn=scan(ang-20,10))&&scn<700)                
      cannon(ang-=20,scn);
    else
      if((scn=scan(ang+20,10))&&scn<700)
        cannon(ang+=20, scn);
      else
        if((scn=scan(ang-40,10))&&scn<700)
          cannon(ang-=40,scn);
        else
          if((scn=scan(ang+40,10))&&scn<700)
            cannon(ang+=40,scn);
          else
            if((scn=scan(ang-60,10))&&scn<700)
              cannon(ang-=60,scn);
            else
              if((scn=scan(ang+60,10))&&scn<700)
                cannon(ang+=60, scn);
              else
                ang+=140;
  oscn=scn;
  }
finale ()
{
        while (loc_x()>70)
        {
                drive (180,100);
                fuoco();
                }
        while(1)
        {
                while (loc_x()<900)
                {
                        drive (45,100);
                        fuoco();
                        }
                while (loc_x()>100)
                {
                        drive (225,100);
                        fuoco();
                        }
                }
        }
