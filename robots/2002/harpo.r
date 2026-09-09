/*
Nome del robot  : Harpo.r
Autore          : Alessandro Tassara

Ennesima involuzione di un mio robotto precedente, Harpo discende direttamente da quel prode combattente 
che fu BigKarl: è stato sottoposto, pero', a dieta forzata, per farlo rientrare al di sotto 
del limite delle 1000 istruzioni.
Per prima cosa Harpo si porta nell'angolino piu' vicino, per stare un attimo in pace mentre conta i rivali.
Se scopre di averne uno solo lo attacca.
Altrimenti inizia a percorrere un quadrato (o un rettangolo, non l'ho ben
capito) in uno qualsiasi degli angoli dell'arena, in modo da sfuggire il piu
possibile ai colpi degli avversari.
La strategia difensiva si basa sul movimento e sul continuo cambiamento di direzione.
Ogni 10 mini-perimetri BigKarl conta i nemici:
se ne è rimasto solo uno, o sono due e il tempo trascorso dall'inizio del
match è lungo, attacca con una routine finale nuova dizecca, che sfrutta il movimento quadrangolare 
implementato in Groucho, unito allo sparo di Disco.r, di Michelangelo messina, collezione 2001.

Riassumendo le specifiche sono:

- il movimento  : Quadrato disegnato in tutti e quattro gli angoli.
- lo sparo      : quando si allontana dai bordi spara preciso, quando si avvicina invece spara rapido.
- l' attacco    : forse e' mio, ma potrebbe anche discendere da quello di Beholder.r (2000) o da quello di
		  MicroDna.r (2001).

*/

int tempo,dir,a,oang,o,r,primo;
int p1,p2,k,z;
int att,dam,i,d,b,y,t;
int dx,dy,deg,sx,dw,x,y;

main()
{
        p2=z=loc_y(p1=k=loc_x()<500)<500;
        while (tempo=10)
	{
                attacco();
                while(--tempo)                                      /*Percorre un quadrilatero in uno dei 4 angoli*/
		{
                                while(loc_y() <910-z*790) {if(z) spara(drive(dir=90,100));else cerca(drive(dir=90,100));}
                                while(loc_x() >880-k*790) {if(!k) spara(drive(dir=180,100));else cerca(drive(dir=180,100));}
                                while(loc_y() >880-z*790) {if(!z) spara(drive(dir=270,100));else cerca(drive(dir=270,100));}
                                while(loc_x() <910-k*790) {if(k) spara(drive(dir=0,100));else cerca(drive(dir=0,100));}
		}
	        drive (0,0);
	}
}

cerca()								/*questa e' piu' o meno quella di Cerlo97*/
{
        if ((o=scan(a,10))&&(o<850))
	{
		if (scan(a+5,5)) a+=5; else a-=5;
                if (scan(a+3,3)) a+=3; else a-=3;
		cannon(a,2*scan(a,10)-o);
	}
        else if (r=scan(a+=340,10)) cannon (a,r);
        else if (r=scan(a+=40,10)) cannon (a,r);
        else if (r=scan(dir,10))  cannon (a=dir,r);
        else return a+=40;
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
                                if(!att) {o=0;return a+=41;}
                                return; 
                        } 
                } else { 
                        if (!(scan(a+=21,10))) return a+=40; 
                        return; 
                } 
	} 
        if (r=scan(a,10)){  
                cannon (a, r*165/(165+o-r) ); 
                if(r>720) if(!att) if(r>o || r>900) {
                                a+=41;
                                return o=0;
                        }

        }  else if(scan(a-20,10)) a-=20; 
        else if(!scan(a+=21,10)) a+=41; 
} 

attacco()
{
/* conta il nr dei nemici */
    destination();
    b=330;
    i=0;
    while((b+=20)!=710) if (scan(b,10)) ++i;
    if (i>4) return;
    if (i<2) {
	ring();
    } else if (t>1460) {
        if (i<3) att=80;
        else att=50;
    } else return 0;
    if(damage()<att) {
        if(att<90) ring();
        r=1;
    } else t=0;
    att=(att>90);
    return 1;
}

ring()
{
	while (1)
	{
                                while(loc_y() <510) spara(drive(dir=90,100));
                                while(loc_x() >490) spara(drive(dir=180,100));
                                while(loc_y() >490) spara(drive(dir=270,100));
                                while(loc_x() <510) spara(drive(dir=0,100));
	}
}

destination()
{
  dx=980-960*(sx=((x=loc_x(dy=980-960*(dw=((y=loc_y())<500))))<500));

  if (x-=dx) deg=540+180*(x>0)+atan(((y-dy)*100000)/x);
  else deg=630-180*dw;

  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) cerca(drive(dir=deg+180,100));
  cerca(cerca(cerca(drive(dir,0))));
}

