/* NOME ROBOT:  ncmplt
   AUTORE:      Aneloni Giovanni

                PREFERISCO CHE PARTECIPI QUESTO ROBOT
                se se ne pu• presentare uno solo
*/
int scn,ang,pos;
int oang,oscn,inat=0;

main()
{
        if (loc_y()<500)
         giu();
        else
         su();
        if (loc_x()<500)
         sinistra();
        else
         destra();
        pos=(loc_x()>500)+2*(loc_y()>500);
        while(1)
        {
                if (damage()>80)                /* routine di attacco finale */
                 finale();
                if (!scn||scn>350)              /* routine di fuoco da fermo */
                 cecchina();
                if (pos==0)                     /* scappa ! */
                {
                        if (!(scan(0,10)))
                         destra();
                        else
                         su();
                        }
                else
                 if (pos==1)
                 {
                         if (!(scan(90,10)))
                          su();
                         else
                          sinistra();
                         }
                 else
                  if (pos==2)
                  {
                        if (!(scan(270,10)))
                        giu();
                        else
                         destra();
                        }
                  else
                  {
                        if (!(scan(180,10)))
                         sinistra();
                        else
                         giu();
                        }
                }
        }
su()
{
                while (loc_y()<920)
                {
                        drive(90,100);
                        fuoco();
                        }
                drive (270,0);
                pos+=2;
        }
giu()
{
                while (loc_y()>80)
                {
                        drive(270,100);
                        fuoco();
                        }
                drive (90,0);
                pos-=2;
        }
sinistra()
{
                while (loc_x()>80)
                {
                        drive(180,100);
                        fuoco();
                        }
                drive (0,0);
                --pos;
        }
destra()
{
                while (loc_x()<920)
                {
                        drive(0,100);
                        fuoco();
                        }
                drive (180,0);
                ++pos;
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
    if((scn=scan(ang-20,10))&&scn<750)                
      cannon(ang-=20,scn);
    else
      if((scn=scan(ang+20,10))&&scn<750)
        cannon(ang+=20, scn);
      else
        if((scn=scan(ang-40,10))&&scn<800)
          cannon(ang-=40,scn);
        else
          if((scn=scan(ang+40,10))&&scn<800)
            cannon(ang+=40,scn);
          else
            if((scn=scan(ang-60,10))&&scn<800)
              cannon(ang-=60,scn);
            else
              if((scn=scan(ang+60,10))&&scn<800)
                cannon(ang+=60, scn);
              else
                ang+=140;
  oscn=scn;
  }
mira5()
{
	if(scan(ang-5,1))
         ang-=5;
        if(scan(ang+5,1))
         ang+=5;
        if(scan(ang-3,1))
         ang-=3;
	if(scan(ang+3,1))
         ang+=3;
        if(scan(ang-1,1))
         ang-=1;
	if(scan(ang+1,1))
         ang+=1;
}
cecchina() /* hal9000 - routine di gestione del tiro da fermo */        
{
        int d,count;
        d=damage();
        count=700;
        while (--count&&!(damage()-d)&&(!scn||scn>300))
        {
                if(scan(ang,5))
                {
                        mira5();
                        if ((scn=scan(ang,5))&&scn<700)
                        {
                                oscn=scn;
                                oang=ang;
                                mira5();
                                if ((scn=scan(ang,10))&&scn<700)
                                {
                                        ang=(ang+(ang-oang)*((1050+scn)>>9));
                                        scn=(scn*250/(250+oscn-scn));
                                        /*valori org:1250,165*/
                                        cannon(ang,scn);
                                        }
                                else
                                 fuoco();
                        }
                        else
                         fuoco();
                }
                else
                 fuoco();
                }
        if (!count)
         finale();
        }
finale ()
{
        if (pos==2)
         giu();
        else
         if (pos==1)
          sinistra();
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
