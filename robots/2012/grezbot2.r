/*

Nome Robot		: Grezbot2
Tipo Robot		: Micro
Autore			: Antonio Iervolino


Versione rivista e migliorata dell'originale grezbot scritto nel 2001. 
Migliorata la routine di fuoco ed il controllo del movimento.
Il robot si porta in basso o in alto in base alla posizione di partenza e da li inizia ad oscillare e a sparare.
La funzione di fuoco è una Tox-like usata da diversi robot tra i quali ataman.r dal quale è stata presa e leggermente modificata. 
Nel 4vs4 può capitare che si tenga sottotiro un robot che è oltre il range massimo dei 700 metri, se il bersaglio è 3 volte consecutive fuori portata ne cerca un altro. Senza questa funzione il robot già abbastanza grezzo nel 4vs4 era veramente pessimo.
*/


int ang,dist,x,y,trovato,limite,dir,oang,odist,fuori;

main()
{
	y=loc_y();					/* in queste prime righe viene imposto al robot */
	x=loc_x();					/* di posizionarsi in basso o in alto dello schermo */
	if(y<500) drive(dir=270,100); else drive(dir=90,100);	/* in base alla sua posizione iniziale */
	while (y>100 && y<900)
	{
		if(dist=scan(ang,10)){
			if(dist && dist<700) cannon(ang,dist);
		} else ang+=20;
		y=loc_y();
	}
	if (x<500) drive(dir=0,100); else drive(dir=180,100);
	
	while(1)							/* Da qui in poi inizia ad oscillare */
	{
		while(!scan(ang,10)) ang+=20;
		odist = follow();
		dist = follow();
		if(odist > 0 && dist>0 && dist<700) cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(dist*220/(220+odist-dist-(cos(ang-dir)/4167))));
		else if (dist>700) fuori++;
		if (fuori==2) {
			fuori = 0;
			ang+=40;
		}
		muovi();
	}

}

follow()  
{
  if(scan((oang=ang)-8,3)) ang-=8;
  if(scan(ang+8,3)) ang+=8;
  if(scan(ang-4,2)) ang-=4;
  if(scan(ang+4,2)) ang+=4;
  if(scan(ang-2,1)) ang-=2;
  if(scan(ang+2,1)) ang+=2;
  return (scan(ang,10));
}

muovi()      /* Questo blocco di codice controlla solo se è fermo e lo fa rimettere in movimento */
{
        x=loc_x();      
        if (x<350+rand(140)) drive(dir = 0,100);
        if (x>650-rand(140)) drive(dir = 180,100); 
		if (!speed()) if (x<500) drive(dir=0,100); else drive(dir=180,100);
 
}

