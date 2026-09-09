/*
Nome del robot  : Carlo2k.r
Autore          : Alessandro Tassara

BigKarl Š il frutto di un paziente ed accurato lavoro di sviluppo di Carlo2k.r,
durato l'intero arco di una notte.
Per prima cosa BigKarl si porta nell'angolino piu' vicino, per stare un attimo
in pace mentre conta i rivali.
Se scopre di averne uno solo lo attacca.
Altrimenti inizia a percorrere un quadrato (o un rettangolo, non l'ho ben
capito) in uno qualsiasi degli angoli dell'arena, in modo da sfuggire il piu
possibile ai colpi degli avversari.
Per implementare questa tattica ho rispolverato il buon vecchio Carletto.r,
che mi pare riuscito assai meglio della piu' nuova incarnazione che ho proposto
con Carlo2k.r
Quando subisce un certo ammontare di danni controlla gli angoli adiacenti: se
uno dei due e' libero lo raggiunge, altrimenti rimane al suo posto.
La strategia difensiva si basa sul movimento e sul continuo cambiamento di direzione.
Ogni 10 mini-perimetri BigKarl conta i nemici:
se ne Š rimasto solo uno, o sono due e il tempo trascorso dall'inizio del
match Š lungo, attacca con la routine finale di Boom, trionfatrice nello scorso
torneo f2f.

Riassumendo le specifiche sono:

- il movimento  : Quadrato disegnato in tutti e quattro gli angoli.
- lo sparo      : quando si allontana dai bordi spara preciso, quando si
                  avvicina invece spara rapido.
- l' attacco    : Boom di Michelangelo Messina.

*/

int tempo,dir,a,oa,o,r,primo;
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
                        if (dam>damage()-26)
			{
                                while(loc_y() <910-z*790) {if(z) spara(drive(dir=90,100));else cerca(drive(dir=90,100));}
                                while(loc_x() >880-k*790) {if(!k) spara(drive(dir=180,100));else cerca(drive(dir=180,100));}
                                while(loc_y() >880-z*790) {if(!z) spara(drive(dir=270,100));else cerca(drive(dir=270,100));}
                                while(loc_x() <910-k*790) {if(k) spara(drive(dir=0,100));else cerca(drive(dir=0,100));}
			}
			else
			{
                                destination();
                                if (scan(80+z*180,10)||scan(100+z*180,10))
                                if (scan(10+k*180,10)||scan(k*180-10,10)); else k^=1;
				else  z^=1;
                                dam=damage();
			}
	                drive (0,0);
		}
	}
}

cerca()								/*questa e' piu' o meno quella di Cerlo97*/
{
        if ((o=scan(a,10))&&(o<770))
	{
		if (scan(a+6,6)) a+=6; else a-=6;
                if (scan(a+3,3)) a+=3; else a-=3;
		cannon(a,2*scan(a,10)-o);
	}
        else trova();
}

trova()
{
        if (r=scan(a+=340,10)) cannon (a,r);
        else if (r=scan(a+=40,10)) cannon (a,r);
        else if (r=scan(dir,10))  cannon (a=dir,r);
        else if (r=scan(a+=300,10)) cannon (a,r);
        else if (r=scan(a+=80,10)) cannon (a,r);
        else return a+=40;
}

fire()                                                          /*qui invece siamo su Jedi*/
  {
	if(o=scan(a,10))
	{
		if (o>700)
                        return cerca();

                if (!scan(a-=5,10)) a+=10;

		if(scan(a+354,1)) a+=354;
		if(scan(a+6,  1)) a+=6;
		if(scan(a+356,1)) a+=356;
		if(scan(a+4,  1)) a+=4;
		if(scan(a+358,1)) a+=358;
		if(scan(a+2,  1)) a+=2;

		if (o=scan(oa=a,5))
		{

			if(scan(a+355,1)) a+=355;
			if(scan(a+5,  1)) a+=5;
			if(scan(a+357,1)) a+=357;
			if(scan(a+3,  1)) a+=3;
			if(scan(a+359,1)) a+=359;
			if(scan(a+1,  1)) a+=1;

			if (r=scan(a,10))
			{
                             cannon((oa+(a-oa)*3-(sin(a-dir)/19500)),(r*200/(200+o-r-(cos(a-dir)/4167))));
			}
		}
                else trova();
	}
        else trova();
  }

stop()                                                /*classica fermata da Arale*/
{
        drive(dir,0);
	while(speed() > 49)
             cerca();
}

spara() 
{ 
        ++t; 
        if ((r=scan(a, 10)) ) { 

                if (scan(a-8,4)) { 
                        if (scan(a-=8+3,2)) { 
                                if(scan(a+=3-2,1)) a-=2;
                        }  else if (scan(a-3,2)) a-=3;
                } else if(scan(a+8,4)) { 
                        if (scan(a+=8+3,2)) a+=3;
                        else --a;
                }  else if(scan(a+3,2)) a+=3; 
                else --a;

        }  else if ((r=scan(a-=20,10))) { 
                if (scan(a-8,4)) { 
                        if (scan(a-=8-3,2)) a-=3;
                        else ++a;
                } else if(scan(a+7,4)) a+=7; 
        }  else if ((r=scan(a+=40,10))) { 
                if (scan(a+7,4)) a+=7;
        }  else if (!(r=scan(a+=20,10))) { 
                if ((r=scan(a+=21,10))) { 
                        if (r>800) { 
                                cannon(a,700); 
                                if(!att) a+=57; 
                                return; 
                        } 
                } else { 
                        if (!(scan(a+=21,10))) a+=40; 
                        return; 
                } 
	} 
        if (o=scan(a,10)){  
                cannon (a, o*165/(165+r-o) ); 
                if(o>720) if(!att) if(o>r || o>800) {
                                a+=57;
                                r=0;
                        }

        }  else if(scan(a-20,10)) a-=20; 
        else if(!scan(a+=21,10)) a+=57; 
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
            b=330;
            i=0;
            while((b+=20)!=710) if (scan(b,10)) ++i;
            if (i<2) {
                att=91;
                t=1;
                if(damage()<91) boom();
                else return;
            } else return 0;
    } else if (t>1460) {
        if (i<3) att=80;
        else att=50;
    } else return 0;
    if(damage()<att) {
        if(att<90) seek();
        r=1;
    } else t=0;
    att=(att>90);
    return 1;
}

seek() {
        i=320;
        while(!(b=scan(i+=20, 10)));
        a=i;
        while (i<700) {
                if ((d=scan(i+=20, 10)) ) {
                        if (d<b) {
                                b=d;
                                a=i;
                        }
                }
        }
        drive(dir=a,100);
        b=0;
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((y=loc_x())>940 ) dir=180;
                        else if (y<60 ) dir=360;
                        else if ((y=loc_y())>940 ) dir=270;
                        else if (y<60) dir=90;
                        else dir=a+80+(b^=1)*215;/*65*/
                }
        }
        drive((dir+180),100);
}
boom()
{
            b=0;
            while(1) {
                if(t%2) {
                        if ((y=loc_x())>910 ) dir=180;
                        else if (y<90 ) dir=360;
                        else if ((y=loc_y())>910 ) dir=270;
                        else if (y<90) dir=90;
                        else dir=a+65+(b^=1)*205;/*65*/
                        spara(drive(dir,100));
                } else {
                        if(r>480) fire(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}

destination()
{
  dx=980-960*(sx=((x=loc_x(dy=980-960*(dw=((y=loc_y())<500))))<500));

  if (x-=dx) deg=540+180*(x>0)+atan(((y-dy)*100000)/x);
  else deg=630-180*dw;

  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) cerca(drive(dir=deg+180,100));
  while (speed()) cerca(drive(dir,0));
}
