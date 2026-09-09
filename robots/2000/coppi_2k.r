/*

 =================   COPPI_2K.R  - by L.Cimini 28-11-2000  =================



ROBOT: COPPI_2K.R
------


Derivato dal mio xq2b8w2a.r

Efficienza xq2b8w2a.r 35%  (scontri con i primi 12 1999)



AUTORE:
-------

 Luigi Cimini


PROLOGO:
-------


- I PRIMI NON SARANNO ULTIMI


Sono stati disputati 6650 incontri su 6650  pari al 100% del totale
I punteggi sono stati assegnati con il sistema Standard
Punti per la vittoria   :  3    Premio per la vittoria sotto i 100000 cicli :  0
Punti per pari a 2      :  1    Punti per pari a 3                          :  1
Punti per pari a 4      :  1    Penalita' per paria a 4 sotto il 40% danni  :  0

    Nome  robot  - Partite - Partite - Partite - Partite - Punteggio - Perc
    Combattente    giocate    vinte     patte     perse    ottenuto      %

 1      xm100b6       950       25       850        75         925     32.46
 2        xq2k1      6650      266      5626       758        6424     32.20
 3      xm100c6       950       23       848        79         917     32.18
 4       sz15e1       950       16       851        83         899     31.54
 5         xmc7       950       15       852        83         897     31.47
 6       cyborg       950       10       857        83         887     31.12
 7        panic       950        5       871        74         886     31.09
 8     xq2b8w2a       950       30       795       125         885     31.05
 9      omega99       950        2       874        74         880     30.88
10        shock       950       12       842        96         878     30.81
11         xq2k       950       24       797       129         869     30.49
12     rudolf_4       950        3       855        92         864     30.32
13        dav46       950       11       821       118         854     29.96
14       cancer       950       11       803       136         836     29.33
15      stealth       950       28       747       175         831     29.16
16     kakakatz       950       11       785       154         818     28.70
17        dario       950       13       779       158         818     28.70
18     defender       950        8       764       178         788     27.65
19        marko       950        6       766       178         784     27.51
20     ilbestio       950       23       697       230         766     26.88
21     rudolf_3       950       12       715       223         751     26.35
22     songohan       950       97       438       415         729     25.58



- MA L`ULTIMO SARA` PRIMO.


Sono stati disputati 6650 incontri su 6650  pari al 100% del totale
I punteggi sono stati assegnati con il sistema Pranzo
Punti per la vittoria   : 12    Premio per la vittoria sotto i 100000 cicli :  0
Punti per pari a 2      :  3    Punti per pari a 3                          :  2
Punti per pari a 4      :  1    Penalita' per paria a 4 sotto il 40% danni  :  0

    Nome  robot  - Partite - Partite - Partite - Partite - Punteggio - Perc    - Vittorie - Patte - Patte - Patte - Patte a 4
    Combattente    giocate    vinte     patte     perse    ottenuto      %       <100000     a 2     a 3     a 4    danni<40%

 1     songohan       950       97       438       415        1904     16.70       33         11     280     147     128
 2        xq2k1      6650      266      5626       758       10139     12.71       85         49    1223    4354    4133
 3     xq2b8w2a       950       30       795       125        1361     11.94        7          6     194     595     511
 4      xm100b6       950       25       850        75        1317     11.55        9          2     163     685     653
 5         xq2k       950       24       797       129        1297     11.38        4          7     198     592     529
 6       sz15e1       950       16       851        83        1279     11.22        2          8     220     623     607
 7      xm100c6       950       23       848        79        1274     11.18        5          1     148     699     683
 8     ilbestio       950       23       697       230        1256     11.02        9          3     277     417     391
 9      stealth       950       28       747       175        1253     10.99        1         10     150     587     562
10       cyborg       950       10       857        83        1155     10.13        4          1     176     680     672
11         xmc7       950       15       852        83        1146     10.05        2          3     108     741     718
12        shock       950       12       842        96        1125      9.87        3         30      79     733     722
13        panic       950        5       871        74        1091      9.57        2          2     156     713     705
14        dario       950       13       779       158        1079      9.46        4          4     136     639     631
15        dav46       950       11       821       118        1079      9.46        3          5     116     700     625
16     kakakatz       950       11       785       154        1076      9.44        5          4     151     630     626
17      omega99       950        2       874        74        1071      9.39        0          1     171     702     699
18       cancer       950       11       803       136        1054      9.25        3          0     119     684     622
19     rudolf_4       950        3       855        92        1048      9.19        3          4     149     702     691
20     defender       950        8       764       178        1026      9.00        1          4     158     602     529
21     rudolf_3       950       12       715       223        1005      8.82        2          5     136     574     494
22        marko       950        6       766       178         991      8.69        3          4     145     617     605



=============================  COPPI_2K.R  ==================================



SCHEDA TECNICA: COPPI_2K.R
--------------------------


La prima cosa che il crobot fa` e di controllare se lo scontro e` a 2.
In seguito cerca con oculatezza un angolo in cui ripararsi per un po`.
Dopo circa 100000 cicli, o se ha subito un danno superiore all`8%
comincia a roteare vorticosamente nell`angolo in cui si trova, dove
resta fino a che non ha subito un danno superiore al 15% o non sia rimasto
nell`arena un solo avversario.


La parte migliore del crobots, raffazzonato nel pomeriggio del 28/10/2000,
dovrebbero essere le routine di fuoco e attacco finale da me portate ad un
ottimo livello. Se il crobots riuscira` ad arrivare alla fase F2F avrete 
modo di valutare la loro qualita`.


COSIDERAZIONI:
--------------

Avrei preferito la sola correzione dei bachi di crobots.exe e non l`aumento
del numero delle istruzioni, a riprova di questa mia tesi, basta osservare
il comportamento nel test sopra riportato del mio mini crobot SZ15E1.R che
con meno di 300 istruzioni macchina, riesce a fare la sua bella figura
(a prescindere dal sistema dei punteggi applicato) anche contro avversari
di categoria superiore.


*/



int a,d,danno,n,r,o,oa,t,tt,xx,yy;

main()
{
   finale();
   if (loc_x()<500)
   {
      if (libero(180)) sx(5);
      else if (libero(0)) dx(995);
      else sx(5);
   }
   else
   {
      if (libero(0)) dx(995);
      else if (libero( 180)) sx(5);
      else dx(995);
   }
   
   if (loc_y()>500)
   {
      if (libero( 90)) up(995);
      else if (libero(270)) dn(5);
      else up(995);
   }
   else
   {
      if (libero(270)) dn(5);
      else if (libero( 90)) up(995);
      else dn(5);
   }
   
   tt=150;
   danno=damage()+8;
   while(((--tt)>0) && (damage()<danno))
   {
      t=5; while(((--t)>0) && (damage()<danno)) fuocof();
      finale();
   }
   while(1)
   {
      danno=damage()+15;
      if (loc_x(xx=92)<500); else xx=908;
      if (loc_y(yy=92)<500); else yy=908;
      
      while(damage()<danno)
      {
         t=5;
         while(--t)
         {
            d=180; while(loc_x()>xx) fire();
            d=90;  while(loc_y()<yy) fire();
            d=0;   while(loc_x()<xx) fire();
            d=270; while(loc_y()>yy) fire();
         }
         drive(d,0);
         finale();
      }
      if (loc_y()<500) { if (libero(90)) up(915); else movex(); }
      else { if (libero(270)) dn(85); else movex(); }
   }
}

libero(deg)
{
   return((scan(deg+710,10)+scan(deg+370,10))<167);
}

movex()
{
   if (loc_x()<500) {if (libero(1)) dx(915);} else {if (libero(180)) sx(85);}
}

sx(x) {d=180; while(loc_x()>x) fire(); drive(d,0); }
dx(x) {d=0;   while(loc_x()<x) fire(); drive(d,0); }
dn(y) {d=270; while(loc_y()>y) fire(); drive(d,0); }
up(y) {d=90;  while(loc_y()<y) fire(); drive(d,0); }

finale()
int deg;
{
   n=0; deg=350; while(deg<710) if (scan(deg+=20,10)) ++n;
   if ((n<2) && (damage()<88))
   {
      while(1)
      {
         d=180; while(loc_x()>666) {drive(d,100); fuoco();}
         d=0;   while(loc_x()<666) {drive(d,100); fuoco();}
         d=90;  while(loc_y()<500) {drive(d,100); fuoco();}
         d=270; while(loc_y()>500) {drive(d,100); fuoco();}
      }
   }
}

fire()
{
   drive(d,100);
   if((r=scan(a,10))&&(r<833))
   return(cannon(a+=5+350*(scan(a+355,5)>0),(scan(a,10)<<1)-r));
   else
   {
      if (r=scan(a+=339,10));
      else
      {
         if (r=scan(a+=42, 10));
         else
         {
            if (r=scan(a+=21, 10)); else return(a+=42);
         }
      }
      return(cannon(a,(scan(a,10)<<1)-r));
   }
}

scan14()
{
   if(scan(a+353,3)) a+=353; if(scan(a+7,3)) a+=7;
   if(scan(a+356,2)) a+=356; if(scan(a+4,2)) a+=4;
   if(scan(a+358,1)) a+=358; if(scan(a+2,1)) a+=2;
}

fuoco()
{
   if((r=scan(a,10))&&(r<833))
   {
      if (scan(a+=355,5)); else a+=10;
      if (r<200)
      {
         return(cannon(a,(scan(a,10)<<1)-r));
      }
      else
      {
         scan14();
         if (o=scan(oa=a,7))
         {
            scan14();
            if (r=scan(a,10))
            {
               return(cannon(a+(a-oa)*((1100+r)>>9)-(sin(a-d)>>14), r*179/(179+o-r-(cos(a-d)>>12))));
            }
            else
            {
               if (r=scan(a+=339, 10));
               else
               {
                  if (r=scan(a+=42, 10)); else return(a+=42);
               }
               return(cannon(a,(scan(a,10)<<1)-r));
            }
         }
         else
         {
            if (r=scan(a+=339, 10));
            else
            {
               if (r=scan(a+=42, 10)); else return(a+=42);
            }
            return(cannon(a,(scan(a,10)<<1)-r));
         }
      }
   }
   else
   {
      if (r=scan(a+=340,10));
      else
      {
         if (r=scan(a+=40, 10));
         else
         {
            if (r=scan(a+=300,10));
            else
            {
               if (r=scan(a+=80, 10));
               else
               {
                  if (r=scan(a+=260,10));
                  else
                  {
                     if (r=scan(a+=120,10));
                     else
                     {
                        if (r=scan(a+=220,10));
                        else
                        {
                           if (r=scan(a+=160,10)); else return(a+=100);
                        }
                     }
                  }
               }
            }
         }
      }
      return(cannon(a,(scan(a,10)<<1)-r));
   }
}

fuocof()
{
   if((r=scan(a,10))&&(r<833))
   {
      if (scan(a+=355,5)); else a+=10;
      if (r<200)
      {
         return(cannon(a,(scan(a,10)<<1)-r));
      }
      else
      {
         scan14();
         if (o=scan(oa=a,7))
         {
            scan14();
            if (r=scan(a,10))
            {
               return(cannon(a+(a-oa)*((1100+r)>>9), r*179/(179+o-r)));
            }
            else
            {
               if (r=scan(a+=339, 10));
               else
               {
                  if (r=scan(a+=42, 10)); else return(a+=42);
               }
               return(cannon(a,(scan(a,10)<<1)-r));
            }
         }
         else
         {
            if (r=scan(a+=339, 10));
            else
            {
               if (r=scan(a+=42, 10)); else return(a+=42);
            }
            return(cannon(a,(scan(a,10)<<1)-r));
         }
      }
   }
   else
   {
      if (r=scan(a+=340,10));
      else
      {
         if (r=scan(a+=40, 10));
         else
         {
            if (r=scan(a+=300,10));
            else
            {
               if (r=scan(a+=80, 10));
               else
               {
                  if (r=scan(a+=260,10));
                  else
                  {
                     if (r=scan(a+=120,10));
                     else
                     {
                        if (r=scan(a+=220,10));
                        else
                        {
                           if (r=scan(a+=160,10)); else return(a+=100);
                        }
                     }
                  }
               }
            }
         }
      }
      return(cannon(a,(scan(a,10)<<1)-r));
   }
}
