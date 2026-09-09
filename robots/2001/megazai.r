/*
Nome del robot  : MegaZai.r
Autore          : Alessandro Tassara

Raffazzonato in poco piu' di una mattinata, AltroZai Š un'evoluzione del poco
performante NewZai17, di cui mantiene quasi invariata la struttura generale.
Scopiazzature piu' o meno evidenti provengono da Daryl e Vegeth.
Spulciando nel listato inoltre, si possono ancora rinvenire arcaici riferimenti
al vecchio AleZai17, a Son-Goku, Arale e persino al vetusto Jedi.
Per prima cosa all'inizio della partita, raggiunto l'angolo piu' vicino, conta
i nemici, e se ne ha solo uno attacca.
Non sta mai fermo, dal momento che tale comportamento non e' assolutamente
raccomandabile, vista la brutta aria che tira ultimamente nell'universo
crobotico: pare infatti che tutti abbiano inspiegabili tendenze maniaco persecutorie
verso gli altri amici che giocherellano nell'arena. 
Oscilla alternativamente in direzione di un nemico (inclinato di 15 gradi, come Daryl)
o brevemente lungo la diagonale (in stile dav46): la scelta Š dettata dalla vicinanza
dell'avversario.
Anche questa volta l'ampiezza dell'oscillazione lunga viene calcolata al volo, prestando
attenzione a non arrivare mai a meno di 600 metri dal nemico.
Quando non ne puo' piu' di evitare i colpi dei compagnoni li' attorno salta
su cio' che rimane della gloriosa Peugeot106 (che oramai sta insieme con il fil di ferro ma,
essendo il budget tiranno, ancora non ha potuto cambiare) e scappa in un altro angolo.
La routine finale e', una volta di piu' copiata.
Il donatore e' nienetemeno che il buon Vegeth, che discretamente bene fece
nella scorsa edizione (e tanto male, quindi, fara' in questa). Qualche modifica
comunque l'ho fatta, se non altro per non beccare uno 0% tondo tondo.
*/

int oang,ndist,vdist;
int ang,dir,curx,cury,dan,anni,last,flag4;
int l,conta;
int dang, alfa, corr, anco;
int vang, gira;

main()
  {

        curx=(980*(loc_x()>500)+10);
        cury=(980*(loc_y(anni=20)>500)+10);
        while(1)                                /*inizia il loop*/
	  {
                dir=(360+((curx-loc_x())<0)*180+atan(((cury-loc_y())*100000)/(curx-loc_x())));
                Peugeot();

                Vai();

                if (((vdist)&&(vdist<770))||(damage()>80))
                {
                        dir+=315;
                        while (Loin(curx,cury)<12000) fire(drive (dir,100));
                }
                else
                {
                        if ((vdist=scan(dir,10))>(ndist=scan(dir+270,10))) {ang=dir-10;dir+=280;l=ndist-700;}
                        else {ang=(dir-=10);l=vdist-700;}
                        if ((l*=l)>70000) l=70000;
                        if (l<12000) l=12000;
                        drive (dir,100);
                        conta=l/6000+1;
                        while (--conta) fire2();
                        while (Loin(curx,cury)<l) fire();
                }
                drive (dir,0);
                while (speed()>49) fire2();
	  }
  }

Vai()
int three,count,odeg;
{
   if (((++anni)>12)&&(damage()<90))            /*controlla se per caso e' rimasto un solo superstite e in quel caso attacca*/
   {

          odeg=dir-89;
          count=(three=16);
          while(three && (count>11))
                if (scan(odeg+15*((--three)%8),7)) --count;

          if (count>=14)
             Vegetale();
          anni=0;
   }

   if((dan<damage()-20)||((vdist)&&(vdist<500)))
   {
	if (Scan(dir))				/*controlla se l' angolo precedente e' libero*/
        {
                Viaggia();
	}
	else if ((Scan(dir+270)))		/*controlla se l' angolo seguente e' libero*/
		{
			dir+=270;
                        Viaggia();
		}
/*                else if (Scan(dir+315))        
			{
				dir+=315;
                                cury=1000-cury;
                                Viaggia();
			}
  */      dan=damage();
    }
}

Viaggia()
  {
        if (sin(dir)) cury=1000-cury;           /*calcola le nuove coordinate delle destinazioni*/
	if (cos(dir)) curx=1000-curx;
        Peugeot();                             /*va a destinazione*/
  }      

Peugeot()  /*Si sposta verso le coordinate date*/
  {
	drive(dir,100);
	while((Loin(curx,cury)>27000)&&(speed()))
                if (vdist>700) fire();
                else fire2();                        /*quando e' lontano dai bordi usa le routine di Jedi*/
        drive(dir,80);
        while((Loin(curx,cury)>11000)&&(speed()))
		fire2();			/*quando e' vicino ai bordi usa le routine di Drago6*/

        while (Loin(curx,cury)>3500);
        while (speed()>49) fire2(drive (dir,0));

        if (loc_x()<500) if (loc_y()<500) dir=90; else dir=0;
                         else if (loc_y()<500) dir=180; else dir=270;
  }

/* Utilities per raccogliere il codice */

Scan(i)
int i;
{
    return ((scan(i+350,10)+scan(i+10,10))<400);   /*effettua una scansione allargata di 14 gradi*/
}


Loin(nx,ny) /*da Son-Goku (ciao Simo)*/
int nx, ny;
  {
	return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

/* Le routines d'attacco */

fire()    /* fire() - routine di sparo in movimento - generoso lascito di nonno Jedi, con un'aggiunta di Coppi e una di Vegeth */
  {
	if(vdist=scan(ang,10))
	  {
                if (vdist<200)
			return fire2();

                if (!scan(ang-=5,10)) ang+=10;

		if(scan(ang+354,1)) ang+=354;	/*tranne questo che viene da Coppi*/
		if(scan(ang+6,  1)) ang+=6;
		if(scan(ang+356,1)) ang+=356;
		if(scan(ang+4,  1)) ang+=4;
		if(scan(ang+358,1)) ang+=358;
		if(scan(ang+2,  1)) ang+=2;

		if (vdist=scan(oang=ang,5))
                  {
			if(scan(ang+354,1)) ang+=354;
			if(scan(ang+6,  1)) ang+=6;
			if(scan(ang+356,1)) ang+=356;
			if(scan(ang+4,  1)) ang+=4;
			if(scan(ang+358,1)) ang+=358;
			if(scan(ang+2,  1)) ang+=2;

			if (ndist=scan(ang,10))
			{
                                /*da Vegeth*/
                                cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(ndist*160/(160+vdist-ndist-(cos(ang-dir)/4167))));
			}
		   }
		else fire2();
		}
       else Dove();
  }

fire2() /*da Drago6*/
  {
	if((vdist=scan(ang,10))&&(vdist<770))
	  {
		if (!scan(ang+=355,5)) ang+=10;
		if (!scan(ang+=357,3)) ang+=6;
		cannon(ang,3*scan(ang,10)-2*vdist);
	  }
	else
	  if((ndist=scan(ang+=340,10)))
		cannon(ang,ndist);
	  else
		if((ndist=scan(ang+=40,10)))
			cannon(ang,ndist);
		else
			if((ndist=scan(ang+=300,10)))
				cannon(ang,ndist);
			else
				if((ndist=scan(ang+=80,10)))
					cannon(ang,ndist);
				else
					return (ang+=40);
  }

Dove() /*da Coppi, ma almeno qui c' e' del mio*/
{
    if((ndist=scan(ang+339,10))) cannon (ang+=339,ndist);
    else if((ndist=scan(ang+21,10))) cannon (ang+=21,ndist);
    else if (ndist=scan(dir,10))
           cannon (ang=dir,scan(ang,10));
    else return(ang+=40);
}

Stop()                                                  /*Procedura di rallentamento speciale*/
  {                                                     
     drive (dir,40);
     ang+=10;
     while(!scan(ang+=21,10));
     fire2();
  }

Vegetale() 
int z;
  {
    fuoco(vang=dir+315);
    fuoco(vang);
    fuoco(vang);
    fuoco(vang);
    fuoco(vang);
    vang=((ang+180)/90)*90;
    while (fuoco(vang+50))
          {
            fuoco(vang-50);
            if (((loc_x()%750)<250)||(z=((loc_y()%750)<250)))
              {
                if (vdist) cannon(ang+(ang-oang)*3,vdist);
                vang=180*(!z)*(loc_x(gira=3)>500)+(90+180*(loc_y()>500))*z;
                dan=damage();
              }
            else
             {
               if (--gira);
               else
                 {
                   vang=((ang+180)/90)*90+90;
                   gira=3;
                dan=damage();
                while (dan==damage())
                        {
                           fuoco(vang+90);
                           fuoco(vang-90);
                        }
                 }
             }
          }
  }


TrovaAura()
  {
    if (TrovaB()) return 1;
    if (TrovaB(ang-=19)) return 1;
    if (TrovaB(ang+=38)) return 1;
    return 0;
  }


TrovaB()

{

if ( vdist = scan(ang,10) )  
 { if ( scan(ang+6,5) )
   {  if ( scan(ang+2,2) )
      {  if ( scan(ang+4,1) ) 
         {  if ( scan(ang+3,0) ) 
             ang+=3; 
	    else
             ang+=4;
	 }
	 else
            if ( scan(ang+2,0) )
             ang+=2; 
	    else
             ang+=1; 
      }
      else
      {  if ( scan(ang+8,1) ) 
         {  if ( scan(ang+7,0) ) 
             ang+=7; 
	    else
             ang+=9;
	 }
      else
         if ( scan(ang+6,0) )
            ang+=6; 
	 else
            ang+=5; 
      }
   }
   else
   {  if ( scan (ang-1,2) )
      {  if ( scan(ang-3,1) )
         {  if ( scan(ang-2,0) ) 
             ang-=2;
	    else
             ang-=3;        
	 }
	 else
           if ( scan(ang-1,0) )
            ang-=1;
	   else
            ang-=0;        
      }
      else
      {  if ( scan(ang-4,1) )
         {  if ( scan(ang-5,0) ) 
             ang-=5;
	    else
             ang-=4;        
	 }
	 else
           if ( scan(ang-6,1) )
            ang-=6;
	   else
            ang-=8;        
      }
   }
 return 1;
 }
return 0;
}

/*Procedure di fuoco*/

fuoco(a)
int a;
  {
     drive (dir=a,100);
     if (TrovaAura())
       {
         drive(dir,100);
         GenkiDama();
       }
     else
         Stop();
  }

GenkiDama()
  {
     if (TrovaAura(oang=ang))
       {    
         drive (dir,40);
         if (vdist<130)
           {
             if (vdist<50) return cannon(ang+(ang-oang)*3,2*scan(ang,10)-vdist);
             return fire2();
           }
         corr=cos(alfa=(ang-dir)-((ang-dir)/360)*360);
         dang=ang+(ang-oang)*3-sin(alfa)/17600;
         if (ndist=scan(ang,10))
           cannon (dang,ndist*350/(350+vdist-ndist-corr/3000));
         else   
            Dove();
       }
     else
       Stop();
  }
