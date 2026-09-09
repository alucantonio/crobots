/* *****************  LEBBRA ******************** 

Luca Stringher
Tutti i miei virus di quest'anno (2003) sono frutto più di un lavoro di psicologia che di tecnica, quindi non mi aspetto molto! Spero almeno che siano utili esperimenti per i futuri programmatori.
L'idea di partenza mi è venuta notando che durante i vari combattimenti tutti i  robottini tendono ad andare negli angoli dell'arena e una volta giunti lì si mettono a gironzolare in vario modo per non essere colpiti. Per avere una routine efficace di movimento e di sparo tendono a stare piuttosto lontani dal limite evitando di sbattere contro le pareti. Resta pertanto un'area inutilizzata che va da 50*50 a 100*100 unità. Inoltre quasi tutti i crobottini tendono a selezionare l'angolo di sparo in base all'algolo in cui si trovano per risparmiare preziosi cicli.
Viste le premesse descrivo come si comporta lebbra.
Come al solito raggiunge l'angolo più vicino con un movimento orizzontale e poi verticale e si avvicina il più posibile all'angolo. Giunto li si mette in guardia sparando solo ai robottini che si avvicinano di più tentando di passare inosservato.Quando incominciano a mazzolarlo abbastanza (per esempio il movimento rettangolare di rudolf_7 gli  rompe assai le scatole) incomincia ad andare a destra e a sinistra dell'arena sparando a chi gli è vicino; spesso riesce a sopravvivere a questo suicidio. Visto che si sente spavaldo quando arriva all'80 % dei danni incomincia a percorrere tutto il bordo dell'arena mantenendo l'avversario sempre puntato e avendo le spalle coperte. Questa tecnica (non so se è nuova, ma può essere interessante) gli permettere di sopravvivere per alcuni round. Quello che penalizza questo robot è sicuramente la routine di sparo che è stata presa pari pari da arale ( uno dei pochi robot di cui comprendo tutte le funzioni) per mancanza di tempo.
Probabilmente c'è un bug nel codice poichè ogni tanto lebbra si impalla e resta ferma nell'arena a farsi mazzolare fino alla morte.( chi trovasse il perchè è pregato di farmelo sapere, grazie)


*/

int x,y,xi,yi,ang,amax,d;

main ()
{
settore();
trip(xi,yi);
while(damage()<20) reazione();
while(damage()<85) lila();
while(1) {lila();sugiu();}

}

settore()
{
if(loc_x()>500){xi=999;}else{xi=0;}
if(loc_y()>500){yi=999;}else{yi=0;}
}

trip(x,y)
{
while(sqrt((loc_x()-x)*(loc_x()-x))>10)
        {
        drive((180*(999-x)/999),sqrt((loc_x()-x)*(loc_x()-x)));
        reazione();
        }
drive(0,0);
while(sqrt((loc_y()-y)*(loc_y()-y))>10)
        {
        drive((180*(999-y)/999)+90,sqrt((loc_y()-y)*(loc_y()-y)));
        reazione();
        }
drive(0,0);
}


reazione()
{
if ( (d=scan(ang,10)) && (d<850) ) 
  { 
   if (d=scan(ang+353,3)) cannon(ang+=353,d);
   else if (d=scan(ang,3)) cannon(ang,d);
   else if (d=scan(ang+7,3)) cannon(ang+=7,d); 
  }
 else
  {
   if ((d=scan(ang+21,10))&&(d<800)) {ang+=21;cannon(ang,d);}
   else if ((d=scan(ang+42,10))&&(d<800)) ang+=42;
        else ang+=63;
   }
}

lila()
{
xi+=999;if(xi>1500) {xi=0;xf=120;} else {xi=999;xf=870;}
while(sqrt((loc_x()-xi)*(loc_x()-xi))>20)
        {
        drive((180*(999-xi)/999),sqrt((loc_x()-xi)*(loc_x()-xi)));
        reazione();
        }
drive(0,0);
}


sugiu()
{
yi+=999;if(yi>1500) {yi=0;yf=120;} else {yi=999;yf=870;}
while(sqrt((loc_y()-yi)*(loc_y()-yi))>15)
        {
        drive((180*(999-yi)/999)+90,sqrt((loc_y()-yi)*(loc_y()-yi)));
        reazione();
        }
drive(0,0);
}
