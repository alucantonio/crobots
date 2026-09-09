
/* 
**   ap_5.r - Antonio Pennino - 30/11/1999
**
**   robot senza pretese, giusto per poter presentare qualcosa 
**   degno dell' ultimo posto al torneo del (cosiddetto) millennio
**
**   solita tattica raschia-bordo ma con un occhio speciale
**   ai robot che amano nascondersi negli angoli e a quelli
**   che cercano i due lati (solo quando mi trovo negli angoli)
**
**   in caso di impicci riavvio da capo il programma, richiamando main()
**
**   per eventuali commenti, scrivete a pennino@mclink.it
*/

int dist; /* distanza dall' obbiettivo, vedi bumbum() */
int ang;  /* angolo in ricerca/sparo su bersaglio     */
int dir;  /* direzione di movimento del robot         */

inizio()
{
  if   (loc_y() <  60) return; else drive(270,100);
  while(loc_y() >  60) ;
  drive(270,0); while (speed()) ;
}

lato()
{
      dist = scan(90,7); if (dist) cannon(90,dist); 
}

topi1()
{
      dist = scan(184,8); if (dist) cannon(184,dist);
      dist = scan(356,8); if (dist) cannon(356,dist);
}

topi2()
{
      dist = scan(176,6); if (dist) cannon(176,dist);
      dist = scan(  4,6); if (dist) cannon(  4,dist);
}

bumbum()
{
  if (dist>700) return;
  if (dist<55)  return;
  cannon(ang,dist);
}

main()
{
 inizio(); dir=0; ang=0; drive(dir,100);

 while(speed()) 
 {
   topi1();
   if (loc_x()>910) { dir=180; drive(dir,100); lato(); ang=90; }
   if   (dist=scan(ang+=10,7)) bumbum(ang);
   if   (dist=scan(ang+=10,7)) bumbum(ang);
   topi2();
   if   (dist=scan(ang+=10,7)) bumbum(ang);
   if   (dist=scan(ang+=10,7)) bumbum(ang);
   if (loc_x()< 90) { dir=0;   drive(dir,100); lato(); ang=0;  }
   if (ang>170) ang=0;
 }

 main();
}
