/* Robot HEAVENS.R
   Creato nel Settembre 1994 da Massimo Paradisi per il Torneo di MC

   Il Robot gira in senso antiorario i quattro angoli del campo da gioco 
   eseguendo uno scan verso il robot avversario e sparandogli addosso
   ad ogni ciclo */

int deg;                /* gradi dove fa lo scan*/
int range;              /* distanza del target */
int olddeg;             /* ultimi gradi del target */
int incdeg;             /* incremento da dare ai gradi ad ogni ciclo di scan*/
int oldrange;           /* ultima distanza del target */
int ang;
main()
{
  /* parte dirigendosi a Nord poi cerca il nemico e spara */
  drive(90,100);
  incdeg=10;
  scanna_e_spara();

  /* all'interno dello while principale ci sono 8 cicli ognuno dei quali
     serve per mantenere una delle direzioni che gli consentono
     di girare in senso antiorario nell'arena e poi cerca il nemico e spara*/
  
  while(1)
        {
        ang=45;
        while( loc_y() < 600 ) /*va fino a meta' andando verso nord*/
                {
                        if (speed()<50)
                                drive(90,100);
                        scanna_e_spara();
                }
        drive(135,0);
        while( loc_y() < 800 ) /* va fino a meta' andando a nordovest*/
                {
                        if (speed()<50)
                                drive(135,100);
                        scanna_e_spara();
                }
        drive(180,0);
        while( loc_x() > 400 ) /*va fino a meta' andando a ovest*/
                {
                        if (speed()<50)
                                drive(180,100);
                        scanna_e_spara();
                }
        drive(225,0);
        while( loc_x() > 200 ) /*va fino a meta' andando a sudovest*/
                {
                        if (speed()<50)
                                drive(225,100);
                        scanna_e_spara();
                }
        drive(270,0);
        while( loc_y() > 400 )/* va fino a meta' andano a sud*/
                {
                        if (speed()<50)
                                drive(270,100);
                        scanna_e_spara();
                }
        drive(315,0);
        while(loc_y() > 200 )/* va fino a meta' andano a sudest*/
                {
                        if (speed()<50)
                                drive(315,100);
                        scanna_e_spara();
                }
        drive(0,0);
        while(loc_x() < 600 ) /* va fino a meta' andando ad est*/
                {                  
                        if(speed()<50)
                                drive(0,100);
                        scanna_e_spara();
                } 
        drive(45,0);
        while(loc_x() < 800 ) /* va fino a meta' andando ad nordest*/
                {                  
                        if(speed()<50)
                                drive(45,100);
                        scanna_e_spara();
                } 
        drive(45,0);
        }

}

/* ricerca un nemico a partire dall'angolo precedente 
   e gli spara calcolando una posizione presunta*/
scanna_e_spara()
{
int angolo_nemico;
int range_nemico;

ang=(ang+45)%360;

/*assegna i valori attuali dei gradi e distanza alle variabili old*/
oldrange=range;
olddeg=deg;

/*ne ricerca uno ed assegna a range la distanza*/
while(!(range=scan(deg,10)))
        deg=(deg+incdeg)%360;

/*spara nella posizione presunta
  calcolata aggiungendo la differenza tra l'angolo e distanza nelle
  vecchie posizioni del nemico*/

/* i gradi sono quelli dell scan piu' la differenza con la vecchia posizione
   del robot nemico, mentre il range e' raddoppiato per compensare 
   eventuali spostamenti del mio robot*/

angolo_nemico=deg+(deg-olddeg);
range_nemico=range+(range-oldrange);

if(angolo_nemico-angle>5)
        angolo_nemico+=10;

if(range<800)     /* se e' piu' vicino di 800 metri*/
{
        cannon(angolo_nemico,range_nemico);
}    

/* memorizza l'incremento da dare nel prossimo ciclo a seconda se i gradi
   della posizione del nemico si sono spostati in senso orario od antiorario*/
if(deg>olddeg)
        incdeg=10; /*senso antiorario*/
else
        incdeg=-10; /*senso orario*/
}

