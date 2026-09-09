/*
Nome del robot  : Small Challenger of Simple Intelligence 
Nome del file   : SCSI.r
Autore          : Gianni Ino

Il robot non è per nulla una novità.
Si tratta semplicemente di Cisc, mio micro-robot dell'anno passato, regredito
verso l'iniziale Pirla-State. La Funzione di fuoco, infatti, abbandona le Toxiche.

inoltre, ha un attacco finale simile a quello di ADSL, l'altro mio microbo.
La routine e' identica, ma i risultati variano, dato che, a differenza del socio, non
si trova sempre sulla bisettrice, quando parte per l'attacco, ma in una posizione variabile
di uno dei due lati dell'arena.

Il conto degli avversari, infatti, è ancora effettuato durante l'oscillazione.
*/

int clock, flag3, flag, flag1, flag2;
int dan, park, angolo, oangolo, scn, oscn;
int mx, my, nx, ny, ang, dx, dy, bordo,lim,dir;

main()                             
{

  dy=1000-loc_x(dx=loc_y(dan-=100));
  lim=850;
  while (drive(ang+=180,0))
      {
        fuoco();
        if (clock^=1);
        else
          {
            if (scan(ang=90*((dx>500)+(1+2*(dx<500))*(dy>500)),10));
            else ang+=90;
          }

        if (((dan<damage()-15)||(flag3))&&(clock))
          {
             while ((park=20+(dx>500)*960)&&((scan(10+(ang=(360+((mx=(dx=20+((1000-dy)>500)*960)-loc_x())<0)*180+atan((((dy=park)-loc_y(dan=damage()))*100000)/mx))),10)+scan(350+ang,10))>400));
          }
        else
         {
            dy+=26000000/sin(ang);
            dx+=26000000/cos(ang);
         }

        while ((bordo=(nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>8200)
              {
                  drive(ang,100);

                  if (flag>10) flag1-=(scan(flag-=20,10)>0);
                  else
                    if (flag1>727) 
                    {
                       lim=3000;
                       dir=45+180*(loc_y()>500)+90*((loc_x()>500)==(loc_y()<500));
                       ang=dir+180*(loc_x()>500);

                       while (1)
                       {
                          if (loc_x()<500) fuoco(drive(dir=ang,100));
                          else fuoco(drive(dir=ang+180,100));	
                       }
                    }
                    else flag=flag1=730;

                    fuoco(bordo>25000);
              }
      }
}

fuoco()
  {
     if((oscn=scan(angolo,10))&&(oscn<lim))
        {
           if (scn=scan(angolo,3))return cannon (angolo,3*scn-2*oscn);
           else if (scn=scan(angolo-=7,3))return cannon (angolo-4,3*scn-2*oscn);
           else if (scn=scan(angolo+=14,3))return cannon (angolo+5,3*scn-2*oscn);
           else return;
	   
        }
     else
       if(scan(angolo+=21,10));
       else
         if(scan(angolo-=42,10));
         else
           if (lim<1000)if(scan(ang,10)) angolo=ang;else;
           else
             return (angolo+=84);
  }  
