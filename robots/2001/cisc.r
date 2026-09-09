/*
Nome del robot  : Condensed Instruction Set Challenger
Nome del file   : Cisc.r
Autore          : Gianni Ino

Il robot non Š per nulla una novit….
Si tratta semplicemente di un micro combattente dello scorso torneo (Pirla.r)
che ho cercato di attualizzare con l'aggiunta di una funzione di fuoco pi—
cattiva e con la modifica di qualche dettaglio.
Di Pirla mi era piaciuta la tecnica usata per oscillare, e ho cercato di
migliorarla quanto ho potuto.
In particolare il calcolo volante delle nuove coordinate Š realizzato
utilizzando il sistema impiegato da Son-Goku.r nell'oscillazione a'la !.r

Il resto della scheda tecnica pu• essere trovato nella documentazione di Pirla.r
*/

int clock, flag3, flag, flag1, flag2;
int dan, park, angolo, oangolo, scn, oscn;
int mx, my, nx, ny, ang, dx, dy, bordo;

main()                             
{

  dy=1000-loc_x(dx=loc_y(dan-=100));

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
            dy+=30000000/sin(ang);
            dx+=30000000/cos(ang);
         }

        while ((bordo=(nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>8200)
              {
                  drive(ang,100);

                  if (flag>10) flag1-=(scan(flag-=20,10)>0);
                  else
                    if (flag1>727) flag3=1;        /*Attiva l' attacco finale*/
                       else flag=flag1=730;

                  fuoco(bordo>25000);
              }
      }
}

fuoco(si)
{
    if (si)
    if ((oscn=scan(angolo,10))&&(oscn<800))
      {
        radar();

        if (oscn=scan(oangolo=angolo,5))
        {

        radar();

            if (scn=scan(angolo,10)) 
                return cannon(angolo+(angolo-oangolo)*((1200+scn)>>9)-(sin(angolo-ang)>>14),
                       scn*200/(200+oscn-scn-(cos(angolo-ang)>>12)));
        }
      }
    if ((oscn=scan(angolo,10))&&(oscn<700));
    else if ((oscn=scan(angolo+=340,10)));
    else if ((oscn=scan(angolo+=40,10)));
    else if ((oscn=scan(angolo+=20,10)));
    else return angolo+=40;
    cannon (angolo,2*scan(angolo,10)-oscn);

}

radar()
{
            if(scan(angolo+355,5)) angolo+=355;
            if(scan(angolo+5,5)) angolo+=5;
            if(scan(angolo+356,2)) angolo+=356;
            if(scan(angolo+4,2)) angolo+=4;
            if(scan(angolo+358,1)) angolo+=358;
            if(scan(angolo+2,1)) angolo+=2;
}
