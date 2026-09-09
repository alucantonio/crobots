/*
Nome del robot  : Ollio.r
Autore          : Alessandro Tassara

Degno compare di Stanlio, Ollio avrebbe dovuto essere un grassone da almeno 2000 istruzioni,
da cacciare nell'arena del torneo per eccelelnza.
Purtroppo, essendo le prestazioni assai scadenti, questa evoluzione di AltroZai è stato messo a
dieta liquida forzata, onde farlo rientrare nella categoria delle mille istruzioni, ove, si spera,
farà miglior figura.
Rileggendo meglio il regolamento, pero', noto ora che posso iscrivere un solo robot a questa categoria,
avendo già saturato quella da 500 istruzioni con due combattenti, quindi Ollio gradirei fosse iscritto
nel torneo da 2000 istruzioni.
Per prima cosa all'inizio della partita, raggiunto l'angolo piu' vicino, conta i nemici e, se ne
ha solo uno, attacca.
Non sta mai fermo, dal momento che tale compotamento non e' assolutamente
raccomandabile, vista la brutta aria che tira ultimamente nell'universo
crobotico: pare infatti che tutti abbiano inspiegabili tendenze maniaco persecutorie
verso gli altri amici che giocherellano nell'arena (questa parte di commento è spudoratamente uguale
a quella dallo scorso anno). 
Oscilla alternativamente in direzione di un nemico (inclinato di 15 gradi, come Daryl)
o brevemente lungo la diagonale (in stile dav46).
L'ampiezza dell'oscillazione lunga viene calcolata al volo, prestando attenzione a non arrivare mai
a meno di 600 metri dal nemico.
Come una pecora chse segue il gregge, Ollio si allinea alla tendenza dominante, e non si schioda 
mai dal suo angoletto.
La routine finale e', una volta di piu', quella quadrangolare che contraddistingue l'intero
mio quartetto di quest'anno.
*/

int oa,r,o;
int a,dir,curx,cury,dan,anni,last,flag4;
int h,l,conta,att;
int da, alfa, cor, anco;
int va, gira,t,diag,odeg,count,three;

main()
  {

        curx=(980*(loc_x(cury=(980*(loc_y(anni=20)>500)+10))>500)+10);
        while(1)                                /*inizia il loop*/
	  {
 	        dir=(360+((curx-loc_x())<0)*180+atan(((cury-loc_y())*100000)/(curx-loc_x())));
                Vai(Peugeot());

                if ((diag^=1)||(damage()>80))
                {
                        spara(spara(spara(spara(drive (dir+=315,100)))));
                }
                else
		{
		        if ((o=scan(dir,10))>(r=scan(dir+270,10))) {a=dir-10;dir+=280;l=r-700;}
                        else {a=(dir-=10);l=o-700;}
                        if ((l=l*l+12000)>65000) l=65000;
                        while (Loin(curx,cury)<l) fire(drive (dir,100));
		}
		spara(spara(drive(dir,0)));
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

          while (count>=14)
		{
                                while(loc_y() <510) spara(drive(dir=90,100));
                                while(loc_x() >490) spara(drive(dir=180,100));
                                while(loc_y() >490) spara(drive(dir=270,100));
                                while(loc_x() <510) spara(drive(dir=0,100));
		}
          anni=0;
   }

}

Peugeot()  /*Si sposta verso le coodinate date*/
  {
	drive(dir,100);
	while(((h=Loin(curx,cury))>3500)&&(speed()))
                if (h>27000) fire();
		else if (h>11000) spara();

        spara(drive (dir=180*(cury>500)+90*(curx==cury),0));

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

fire()    
  {
  if (scan(a,10))
    {
      if ((o=Rivela())<850)
        {
          if (r=Rivela())                
             return cannon((oa+(a-oa)*3-(sin(a-dir)/19500)),(r*200/(200+o-r-(cos(a-dir)/4167))));
        }
    }      
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(dir,10))) a=dir;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}

Rivela()   
{
  if(scan((oa=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

spara()
/* routine di sparo*/ 
{ 
        ++t; 
        if ((o=scan(a, 10)) ) { 

                if (scan(a-8,4)) { 
                        if (scan(a-=8+3,2)) { 
                                if(scan(a+=3-2,1)) a-=2; 
                        }  else if (scan(a-3,2)) a-=3;
                } else if(scan(a+8,4)) { 
                        if (scan(a+=8+3,2)) a+=3;
                        else --a;
                }  else if(scan(a+2,2)) a+=2; 
                else --a;

        }  else if ((o=scan(a-=20,10))) { 
                if (scan(a-8,4)) { 
                        if (scan(a-=8-3,2)) a-=3;
                        else ++a;
                } else if(scan(a+7,4)) a+=7; 
        }  else if ((o=scan(a+=40,10))) { 
                if (scan(a+7,4)) a+=7;
        }  else if (!(o=scan(a+=20,10))) { 
                if ((o=scan(a+=21,10))) { 
                        if (o>900) { 
                                cannon(a,700); 
                                o=0;return a+=41;
                        } 
                } else { 
                        if (!(scan(a+=21,10))) return a+=40; 
                        return; 
                } 
	} 
        if (r=scan(a,10)){  
                cannon (a, r*165/(165+o-r) ); 
                if(r>720) if(r>o || r>900) {
                                a+=41;
                                return o=0;
                        }

        }  else if(scan(a-20,10)) a-=20; 
        else if(!scan(a+=21,10)) a+=41; 
} 


