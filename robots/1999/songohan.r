/*
                 SSSSSSSSSSS       OOOOOOOOOOO    NN       NN
                SSSSSSSSSSSSS     OOOOOOOOOOOOO   NNNN     NN
                SS         SS     OO         OO   NN NN    NN
                SS                OO         OO   NN  NN   NN
                 SSSSSSSSSSS      OO         OO   NN   NN  NN
                   SSSSSSSSSS     OO         OO   NN    NN NN
                SS         SS     OO         OO   NN     NNNN
                SSSSSSSSSSSSS     OOOOOOOOOOOOO   NN      NNN
                 GSSSSSSSSSS       OOOOOOOOOOO    NN       NN

    GGGGGGGGGGG     OOOOOOOOOOO    HH       HH    AAAAAAAAA    NN       NN
   GGGGGGGGGGGGG   OOOOOOOOOOOOO   HH       HH   AAAAAAAAAAA   NNNN     NN
   GG         GG   OO         OO   HH       HH   AA       AA   NN NN    NN
   GG         GG   OO         OO   HH       HH   AA       AA   NN  NN   NN
   GG              OO         OO   HHHHHHHHHHH   AAAAAAAAAAA   NN   NN  NN
   GG       GGGG   OO         OO   HH       HH   AA       AA   NN    NN NN
   GG         GG   OO         OO   HH       HH   AA       AA   NN     NNNN
   GGGGGGGGGGGGG   OOOOOOOOOOOOO   HH       HH   AA       AA   NN      NNN
    GGGGGGGGGGG     OOOOOOOOOOO    HH       HH   AA       AA   NN       NN

   Nome      : Son-Gohan.r  (23-10-99)

   Allenatore: Il Nameccano Junior

   Autore    : Simone Ascheri

   Scopo     : Aiutare Ka'aroth a difendere la Terra

LA STORIA
=========

E' passato ormai un anno dalla morte del padre, e Son-Gohan si e' allenato insieme al
Nameccano Junior per prepararsi all' arrivo dei Sayian sulla Terra.
Il suo scopo e' dare man forte a Son-Goku (resuscitato grazie alle sfere del drago dopo
un intenso allenamento insieme a Re Caio) nella difesa del pianeta.

COMPORTAMENTO
=============

Fase Iniziale
-------------
All' inizio del Match Gohan cerca un angolo libero, cominciando da quello
piu' vicino, e (non troppo) prontamente lo raggiunge.
Inizia quindi a muoversi parallelamente ad un lato e a sparare.
La scelta della direzione in cui oscillare dipende da alcuni fattori:

Se i danno subiti sono inferiori al 60%:
========================================

-Gohan cerca innanzitutto se ha un nemico statico nell' angolo seguente, e in caso
 affermativo lo attacca...
-Altrimenti guarda se un avversario statico e' nell' angolo precedente e lo attacca...
-Nel caso nessuna delle due condizioni prececenti sia verificata si dirige verso
 l' angolo libero...
-Se nemmeno questo e' possibile si muove verso l' angolo seguente.

Se invece i danni sno piu' elevati si comporta come Ka'aroth:
=============================================================

-Se l' angolo precedente e' libero oscilla in quella direzione...
-Altrimenti va verso l' angolo seguente senza altri controlli.

Tale tattica si basa su questa considerazione:
lo scopo principale di un robot e' non farsi colpire, per cui l' ideale sarebbe oscillare
in una direzione ove non siano presenti nemici. Purtoroppo questo fatto e'
estremamente improbabile, almeno nelle prime fasi di gioco. Quindi la cosa migliore e'
dirigersi verso un nemico fermo, arrivare al max a 700 unita' da esso, sparare e tornare
indietro. Dal momento che un robot statico passa la maggior parte del suo tempo a
cambiare angolo di scansione, e' assolutamente possibile che non ci consideri nemmeno
(in quanto troppo lontani) fino a quando non e' ormai troppo tardi.
Inoltre tale tattica serve a cercare di colpire (in caso di scontro in famiglia con il
paparino Ka'aroth) innanzitutto gli avversari.
Se subisce troppi danni o ha un nemico troppo vicino cambia posizione.

Fase Finale
-----------
Dopo circa 110000 cicli Gohan conta gli avversari:

 1 * Se c' e' piu' di un superstite continua il movimento cambiando angolo se ha subito
     troppi danni.
 2 * Se invece si accorge di avere solo piu' un avversario adotta un movimento
     ispirato a (copiato da) quello di Paranoid.r: si porta al centro dello schermo e
     inizia a percorrere l' arena orizzontalemnte avanti e indietro.

Routine di Movimento
--------------------
La routine e' unica per tutte le posizioni dello schermo.
Calcola la distanza (al quadrato, evitando cosi' una radice) rispetto ad un
punto dato [(20,20)(980,20)(980,980)(20,980)], trova l' angolo necessario per
raggiungerlo e infine inizia a muoversi in quella direzione. Quando arriva a
destinazione si ferma.
Sceglie una direzione parallela ad uno dei lati con il sistema visto precedentemente
e si avvia, camminando fino a quando non si trova alla massima distanza stabilita dal
punto.
Inverte quindi il movimento e riinizia dal principio.

CONSIDERAZIONI
==============

Ho cercato di costruire il crobot in modo da fargli aiutare Ka'aroth, ma la tecnica che
ho utilizzato si e' rivelata piu' efficace della strategia del papi.
Per la spiegazione delle routine di fuoco rimando ai crobot citati, o ai loro
eventuali ispiratori.

RINGRAZIAMENTI
==============

Un sentito grazie a:
- Tom Poindexter (per averci donato Crobots[pero' .... questi sorgenti....])
- Maurizio 'JOSHUA' Camangi per:
   * le sue indispensabili utilities
   * la pazienza dimostrata nel 'guidarmi' alla scoperta di Linux
   * le tonnellate di e-mail che ci siamo scambiati
- Michelangelo Messina per aver gentilmente assecondato tutte le mie richieste di
  modifica al suo Torneo99, aver trovato i bugs di Count e averlo poi convertito
  in C.
- Tutti coloro con i quali ho scambiato pareri in questi mesi, che mi hanno spinto a
  continuare lo sviluppo. In particolare, senza Alessandro Carlin e Daniele Nuzzo
  Son-Gohan non sarebbe mai nato.
- Alessandro Tassara, per aver finalmente accettato di partecipare al torneo.

Un enorme ringraziamento ad AKIRA TORIYAMA per aver creato DragonBall e
DragonBall Z.
*/

int timmax, ang, ang2, dx, dy;
int dan, park, ango, oang, range, orange;
int dis, corg, quad, flag3, flag2, flag1, flag;

main()                             
{
                                                      /*Calcola coordinate iniziali e agolo principale*/
ang2=(Trova((dy=980-(loc_x(dis=160)>500)*960),
     (1000-(dx=(loc_y(corg=1150)>500)*960+20)))/90*90);

Go(timmax=65);                                        /*Trova un angolo libero e lo raggiunge*/
                                        
while (timmax+=6)                                     /*Ciclo principale*/
   {
    while ((--timmax))                                /*Movimento oscillatorio*/
       {                                              
                                                      /*Decide se e' il momento di
                                                        cambiare angolo, in base ai danni
                                                        e alla posizione del nemico*/
          if ((dan<damage(flag=0)-15)||((orange)&&(orange<400)))
            {
               if (!Ricerca(ang=ang2))                /*La scelta e' effettuata in maniera
                                                        leggermente diversa dal solito*/
                 {
                   ang2+=270;
                   park=dy;
                   dy=1000-dx;
                   Arrivo(dx=park,dy);
                  }
               else
               if (!Ricerca(ang=ang2+630))
                 Arrivo(OooHoo(ang2+=90),dy=park);
               else Go();
               dan=damage();
            }
          if ((damage()<60))                          /*Se i danni sono minori del 60%
                                                        oscilla verso un nemico...*/
            {
             if (Ricerca(ang2+630))
               {
                 while (speed());
                 if ((orange=Ricerca(ang2+630))&&(Ricerca(ang2+630)==orange))
                   flag=630;
               }
             if (!flag)
               {
                 if (Ricerca(ang2))
                   {
                    while (speed(flag=630));
                    if ((range=Ricerca(ang2))&&(Ricerca(ang2)==range))
                      flag=0;
                   }
               }
            }
          else if (Ricerca(ang2)) flag=630;           /*...altrimenti cerca di evitarlo*/
          drive (ang=(ang2+flag),100);                /*Si allontana dall' origine*/
          while ((Dista(dx,dy)<57000)&&(speed()))
               SuperSayian();
   
          KameAmeA();                                 /*Rallenta*/
          ang+=180;
          Arrivo(dx,dy);                              /*Torna all' origine*/
        }

if (Reeft(ang2+205,7)<2)                              /*Controlla quanti sono i sopravvissuti*/
   {          
     NuvolaSpeedy(500,500);
     corg=1050;                                       /*Cambia i parametri della Toxica per l' attacco finale*/
     dis=195;
     while (1)                                        /*Attacco finale a meta' schermo*/
          {
            ang=180*(dx>500);
            Arrivo(dx=1000-dx,500);
          }
   }
else if (dan<damage()-10) Go();
  }
}

/*Operazioni di servizio*/

/*Routine di spostamento verso coordinate date*/

NuvolaSpeedy(tx,ty)
int tx, ty;
   {
    Trova(tx,ty);
    return Arrivo(tx,ty);
   }

/*Vai alla distanza minima dal punto*/

Arrivo(fx,fy)
int fx, fy, h;
   {
     drive (ang,100);                 
     while (((h=Dista(fx,fy))>5200)&&(speed()))
          if (h<25000)
            KaiOKen();
          else
            SuperSayian();
     return KameAmeA();
   }

/*Individua l' angolazione necessaria per raggiungere un punto dato*/

Trova(mx,my)
int mx, my;
  {
    return (ang=(360+((mx-=loc_x())<0)*180+atan(((my-loc_y())*100000)/mx)));
  }

/*Calcola la distanza rispetto ad un punto dato*/

Dista(nx,ny)
int nx, ny;
  {
    return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

/*Valuta se un angolo e' libero*/

Go()
  {
    while (Ricerca(Trova(OooHoo(ang2+=90),dy=park))>400);
    return(NuvolaSpeedy(dx,dy));
  }
    
/*Effettua la rotazione degli angoli da controllare*/
               
OooHoo()
  {
     park=dx;
     return(dx=(1000-dy));
  }

Ricerca(an)
int an;
{
 return (scan(an+350,10))+(scan(an+10,10));
}

/*Conta i superstiti*/

Reeft(dsiete,dand)
int dsiete, dand, qsiete;
  {
    while (--dand)
         qsiete+=(Ricerca(dsiete+=40)!=0);
    return (qsiete);
  }

/*Procedure di fuoco (spudoratamente copiate)*/

/*Spara con media precisione*/

KaiOKen()
{
  if((orange=scan(ango,10))&&(orange<770))
  {
   if (range=scan(ango+353,4))  
     cannon(ango+=353,range);
   else if (range=scan(ango,3))
          cannon(ango,range);
   else if (range=scan(ango+7,4)) 
          cannon(ango+=7,range);
   }
  else
    if((range=scan(ango+=339,10)))
      cannon(ango,range);
    else
      if((range=scan(ango+=42,10)))
        cannon(ango,range);
      else
            return (ango+=40);
}                            

/*Spara mentre decelera*/ 

KameAmeA()
   {
     drive(ang,0);
     while (speed()>49)
          if ((range=scan(ango,10))&&(range<770))
            cannon (ango,range);
          else
            Ceck();
   }

Ceck()
   {  
          if (range=scan(ango+=340,10));
          else if (range=scan(ango+=40,10));
          else if (range=scan(ang,10))
            ango=ang;
          else
             return (ango+=40);
          return cannon(ango,2*scan(ango,10)-range);
    }     
 
/*Spara con buona precisione sia da fermo che in movimento*/

SuperSayian()
{
    if (orange=scan(ango,10))
      {
        if ((orange>700))
          return KaiOKen();
        else
        {
        if (scan(ango-=5,5));else ango+=10;
        ObaBa();
        if (orange=scan(oang=ango,5))
          {
            ObaBa();
            if (range=scan(ango,10))                
              return cannon((ango+(ango-oang)*((corg+range)>>9)-(sin(ango-ang)>>14)),(range*dis/(dis+orange-range-(cos(ango-ang)>>12))));
          }
        else
          return KaiOKen();
        }
      }      
    else
      return Ceck();
}   
                  
ObaBa()   
{
  if(scan(ango+354,1)) ango+=354;
  if(scan(ango+6,  1)) ango+=6;
  if(scan(ango+356,1)) ango+=356;
  if(scan(ango+4,  1)) ango+=4;
  if(scan(ango+358,1)) ango+=358;
  if(scan(ango+2,  1)) ango+=2;
}

