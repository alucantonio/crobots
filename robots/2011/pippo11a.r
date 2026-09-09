/*
 Pippo 11 A

 Tattica semplice: gira intorno al perimetro dell'arena di gioco
 in senso antiorario.
 Ringrazio l'autore dei CVirus, non posso cercare il nome
 perchä ho poco tempo.
 La routine di fuoco ä la variante di non ricordo quale robot.
 Classica routine, se trova un avversario gia' all'entrata nella
 funzione cerca di migliorare la mira.
 In caso contrario lo cerca con un metodo grezzo ma veloce.


*/
int rng,
    deg,
    odeg,
    dir,
    px,
    py;

main()
{
   while(1)
   {
    while (loc_x()<900) fuoco(drive(dir=0,100));
    fuoco(drive(dir=90,0));
    while (loc_y()<900) fuoco(drive(dir=90,100));
    fuoco(drive(dir=180,0));
    while (loc_x()>100) fuoco(drive(dir=180,100));
    fuoco(drive(dir=270,0));
    while (loc_y()>100) fuoco(drive(dir=270,100));
    fuoco(drive(dir=0,0));
   }
}

fuoco()
{
	if (rng=scan(odeg=deg,10))
        {
		if (scan(deg-8,5))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
		if (scan(deg+8,5))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
		if (scan(deg,10))   { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
	}
	else if(scan(deg+=20,10));
	else if(scan(deg-=40,10));
	else if(scan(dir,10)) deg=dir;
	else while(!scan(deg,10))deg+=19;
}

