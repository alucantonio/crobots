/*
Nome            : Idefix
Versione        : 2.8
Autore		: Simone Ascheri


Commento
========

Idefix 'dovrebbe' essere un'evoluzione di Raistlin.
In realtà, dato che lo spazio era sfruttato al massimo gia' nel predecessore, si tratta di
un'implementazione che scende a compromessi diversi: accetta una forte penalizzazione in t9198 e 
in tmicro2k a favore di un miglioramento di prestazioni in tmicro2k1 (+6%), di T2k (+7%) e di 
t2k1(+6%).

Strategia
=========

La strategia e' sempre meno complicata...... anziche' andare avanti i miei robot regrediscono
costantemente di anno in anno.
All'inizio del match cerca un angolo libero e lo raggiunge. Dopo di che non si schioda piu' nemmeno
a pagarlo, a meno che non scopra di avere un solo avversario a stuzzicarlo.

Al volo, aggiungo che Idefix controlla subito che lo scontro non sia a due, mentre Raistlin aspettava
un certo numero di oscillazioni.

Inizia quindi ad oscillare in orizzontale in verticale o diagonale, controllando la distanza dei 
nemici e decidendo chi affrontare:

1- 	fino a quando non ha subito il 40% di danni attacca il nemico piu' vicino, andandogli incontro 
	per circa 250 unità;
2- 	dopo di che attacca il menico piu' lontano.
3- 	ogni oscillazione parallela agli assi è seguita da una lungo bisettrice del quadrante. 
	In questa situazione l'ampiezza del percorso di riduce a circa 100 unità.

Il ciclo continua fino a quando non scopre di essere rimasto a duellare con un unico nemico:
in questa situazione parte con l' attacco finale.
Si tratta effettivamente di una routine di attacco a sè stante, a differenza di quella dello scorso
anno, ma, dato che non si butta mai via nulla, indovinate un po' di che strategia si tratta?
Ovviamente dell'attacco Fiducioso, scandaloso pezzo di codice che mi vergogno di aver prodotto già
l'anno scorso. Ha solo dalla sua il vantaggio di essere cortissimo, e di potersi quindi incastrare
nel poco spazio libero rimasto in Idefix.

Note Tecniche
=============

Tecnicamente credo di aver ridotto leggermente la conusione presente in Raistlin, ma se vi aspettate
qualche cosa di leggibile e comprensibile temo andrete delusi.
Dal momento che 500 istruzioni sono comunque poche, per farci entrare un crobot

L'unica novità che credo di aver inserito e' il cambio di strategia al cambiare dei danni subiti.
Ovviamente la novità non sta nella strategia in sè, ma nell'implementazione.
In pratica viene usata la condizione !=(damage()<40) per validare l'equazione, invertendo il segno
della disuguaglianza quando i danni oltrepassano la soglia prefissata.
*/

int timmax, ang, dx, dy;
int dan, park, a, oang, r, or;
int h, mi, mx, my, nx, ny, ampiezza, flag, flag1;
int max, clock, v, m1;

main()                             
{

  ang=(loc_x()>(dx=(loc_x(timmax=16)>500)*960+20))*180+atan((((dy=(loc_y()>500)*960+20)-loc_y())*100000)/(dx-loc_x(m1=180*(dy>500)+90*(dx!=dy))));
  while (drive (ang,100))
      {


         
         while (((h=Dista(dx,dy))>4400))
              PallaDiFuoco(h<25000);

             if (((timmax+=Stop())%(flag1=17))||(damage(ang=m1)>85));
             else 
               {
                 while ((flag1+=20)<392) flag1-=(scan(flag1,10)>0);
		
                while (flag1>395)

                     {  /*Fiducioso Attack!!!*/

                        if ((scan(a,10))>700) max=ang=a;
                        else if ((speed()>65))
                             {
                               Stop();
                             } 
                        PallaDiFuoco();
                      }
		}
		
             if (clock=54000-clock)
		ang+=45;
             else
               max=ang+=90*(((scan(ang,10)>scan(ang+90,10))!=(damage()<40)));
      
             while ((Dista(dx,dy)<70000-clock))
                  PallaDiFuoco();
	     Stop();

      } 
}

Dista(nx,ny)
int nx, ny;
  {
    return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }
 
Stop()
{
         PallaDiFuoco(PallaDiFuoco(drive(ang+=180,0)));
}

PallaDiFuoco(meglio)
int meglio;
{
  if (meglio);
  else if (scan(a,10))
    {
      if ((or=Rivela(drive(ang,100)))<850)
        {
          if (r=Rivela())                
             return cannon((oang+(a-oang)*3-(sin(a-ang)/19500)),(r*200/(200+or-r-(cos(a-ang)/4200))));
        }
    }      
  if((r=scan(a,10))&&(r<850));
  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(max,10))) a=max;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}

Rivela()   
{
  if(scan((oang=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}
