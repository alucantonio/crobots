/* E  L  I  S  I  R  .  r 
(Nome in codice: LENTERON)



 Michelangelo Messina                         


        Everything is free...


Quanto puo' essere redditizio un OVERCLOCK?

Vediamo l'Overclock di un robot famoso a cosa porta




Elisir e' basato su Goblin.r, per la cui stesura si 'ringrazia' Daniele Nuzzo.

   Inizialmente il crobot si reca nell'angolo piu' vicino.
   Nell'angolo viene utilizzata questa strategia:

       - Se il crobot si trova in un angolo in basso controlla nell'angolo
         sopra se ci sono altri crobots e se non c'e' nessuno si reca sopra
         nel nuovo angolo; analogamente se si trova a nord e non c'e' nessuno
         in basso scende;

        - Altrimenti rimane fermo e defilato nell'angolo finche' non viene
          colpito con una certa precisione (almeno 5% di danno) o finche'
          non si avvicina nessuno nell'angolo;

        - Quindi cambia angolo spostandosi sempre in uno dei due angoli
          adiacenti, preferendo se possibile (se non ci sono altri crobots)
          muoversi lungo le pareti verticali dell'arena di combattimento.

   Durante tutto il match il crobots controlla continuamente se e' rimasto
   un solo avversario ed in tal caso lo attacca; la routine di attacco e'
   basata sullo spostamento lungo le due grandi diagonali, utilizzando un
   piccolo accorgimento: il crobot non va mai incontro ad un avversario
   che si trova in un angolo; infatti dopo aver percorso meta' diagonale
   (il crobots si trova piu' o meno nel centro dell'arena) si controlla che
   l'angolo in cui si sta per andare sia libero, in caso contrario si cambia
   la diagonale di attacco.

*/

int rng,orng,deg,odeg,dir,t,dam,max;

main()
{
/* Vai nell'angolo pi— vicino: */

    deg=30;
    if (loc_x()<500) sx(); else dx();
    if (loc_y()<500) dw(); else up();
    t+=6;
    while(1)
    {
        if (UpDown())
        {
	    dam=damage()+4; 
	    while ((!orng || orng>400) && (damage()<dam)) 
	    { 
        	if (t>20) { 
		    deg=-10; t=0; 
		    while((deg+=20)!=730) if (scan(deg,10)) ++t; 
		    if (t<3) { 
        	        max=1; 
			drive(dir=180+180*(500>loc_x())+atan(100000*(loc_y()-500)/(loc_x()-500)),100); 
                        while(1) {  
                                	while ((loc_x()<450) || (loc_x()>550)) {  
	                                        drive(dir,100);  
        	                                Fire();  
                	                }  
                         
                        	        if (scan(dir,10)) {  
                                	        if (scan(dir+270,10)) drive(dir+=90,100);  
                                        	else drive(dir+=270,100);  
	                                }  
					else if(t>20) drive(dir+=90,100);
                	                Fire();  
  
  
                        	        while ((loc_x()<800) && (loc_x()>200) && 
                                	  (loc_y()<800) && (loc_y()>200)) { 
                                        	drive(dir,100); 
	                                        Fire(); 
        	                        }  
                               		drive(dir+=180,100); 
	                } 
		    } 	
		    t=0;
                } 
        	Fire(1); 
	    } 
            if (UpDown()) if (loc_x()<500) dx(); else sx(); 

        }
    }
     
}

up() { dir=90;  while(loc_y()<900) { drive(90,100);  Fire(); } drive(270,0); }
dw() { dir=270; while(loc_y()>100) { drive(270,100); Fire(); } drive(90,0);  }
dx() { dir=0;   while(loc_x()<900) { drive(0,100);   Fire(); } drive(180,0); }
sx() { dir=180; while(loc_x()>100) { drive(180,100); Fire(); } drive(0,0);   }

UpDown()
{
    if (t>20) return 1;
    if (loc_y()<500) { if (scan(80,10)+scan(100,10)<150) { up(); return 0; } }
    else { if (scan(260,10)+scan(280,10)<150) { dw(); return 0; } }
    return 1;
}

Fire(flag) 
{ 
    if (orng=scan(deg,10)) 
    { 
        if (scan(deg+352,5)) deg+=352; 
        else if(scan(deg+8,5)) deg+=8; 
        if (orng>700) 
        { 
            if (!scan(deg+=357,3)) deg+=6; 
            cannon(deg,orng); 
            ++t; 
            if(!max) deg+=55; 
            return; 
        } 
 
            if(scan(deg-5,2)) deg-=5; 
            if(scan(deg+5,2)) deg+=5; 
            if(scan(deg-3,1)) deg-=3; 
            if(scan(deg+3,1)) deg+=3; 
            if(scan(deg-1,1)) deg-=1; 
            if(scan(deg+1,1)) deg+=1; 

        if (orng=scan(odeg=deg,7)) 
        { 
            if(scan(deg-5,2)) deg-=5; 
            if(scan(deg+5,2)) deg+=5; 
            if(scan(deg-3,1)) deg-=3; 
            if(scan(deg+3,1)) deg+=3; 
            if(scan(deg-1,1)) deg-=1; 
            if(scan(deg+1,1)) deg+=1; 
 
           if (rng=scan(deg,10)) 
            { 
                if (flag) 
                { 
                cannon(deg+(deg-odeg)*((1200+rng)>>9), 
                       rng*162/(162+orng-rng)); 
                } 
                else 
                { 
                cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12))); 
                } 
                t=0; 
            } 
 
        } 
        else search(); 
     } 
     else search(); 
} 
 
search() 
{ 
        if (!(orng=scan(deg+=340,10))){  
                if (!(orng=scan(deg+=40,10))) { 
                        if(!(orng=scan(deg+=20,10))) { 
                                deg+=38; 
                                return; 
                        } 
		} 
        } 
        else if (!scan(deg+=354,6)) deg+=11;  
        cannon(deg,orng); 
} 
 




/*

Storia di un overclock

- Mamma, mamma, voglio il COMPUTE'R nuovo, voglio il COMPUTE'R nuovo
- E perche' ?
- Il mio LENTERON 366 fa solo 95 frames a Quackke due!!!
  Invece il PENTATHLON ( (c) ing. A. Ciufo 1998 ) del mio amico arriva a 140!!!
- E che vo' ? Qua non c'e' una lira!

La soluzione.
Basta armarsi di:
1 Kg di pasta termoconduttiva siliconata,
n. 8 ventole da inserire ovunque nel case per creare una zona di bassa pressione (meglio se si riesce a 
provocare un po' di sana nebbiolina)
attrezzi vari da hobbista evoluto.


Il risultato.
Il LENTERON 366 si trasforma magicamente in SUPERLENTERON 456, capace di:
- ben 102 frames a Quackke due,
- 3 formattazioni di HD (fino a quando il malcapitato non cambio' il suo HD sammersung)
- 1 impiantamento ogni quarto d'ora
- assorbimento di corrente da media industria manifatturiera
- inquinamento sonoro modello base elicotteristica


Your love is on my mind


*/
