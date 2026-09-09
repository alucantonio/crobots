/****************
 *    CORNER    *
 ****************

Version  : 5
Revision : 28 Ottobre 2002
Author   : Fabio Luciano

COMMENTO
A causa del tempo limitato da dedicare (come faranno gli altri ?!?!) non ho potuto progettare 
un c-robot completamente nuovo, ma ho evoluto i miei vecchissimi Corner (anche se oramai è una tattica
molto comune), confontandomi con gli ultimi ritrovati della C-Robotica!!!

Il robot si posiziona nell'angolo basso-sx e comincia un pellegrinaggio in tutti gli angoli
in senso orario, spostandosi ogni volta che subisce un danneggiamento superiore al 7%.
Ad ogni spostamento verifica se c'è un solo antagonista, ed in quel caso parte all'inseguimento,
se lo stato di danneggiamento non è troppo alto.  
La routine offensiva viene da Vampire, con qualche modifica in base alla velocità e sull'affinamento.

Concludendo, quest'anno dopo 8 anni volevo riprovare, anche solo per dire c'ero. Non penso che questa
mia creatura conquisterà una buona posizione (non è scaramanzia), ma potrebbe essere un'inizio,
...a volte tornano!
*/

int rng, orng, deg, odeg, dir, vel, n, t;

main()
int a, dam;
{
  muovi(vel=100, n=4);
  
  while (n > 1 || dam > 90) {        
    muovi(vel=100);

    a=n=0;                                       
    while(a<361) n+=(scan(a+=20,10) > 0);

    if (n > 1) {
      dam=damage(vel=0);
      while (damage(fire(dir))-dam < 7);
    }
  }  
  
  while(1) fire(deg);                            
}

/*============================================================================================*/

muovi()
{
  while (distbordo(fire(dir)));
  drive((dir-=90-360*(dir==0)),0);
}

distbordo()
{
       if (dir==  0) return (loc_x()<900); 
  else if (dir==270) return (loc_y()>100); 
  else if (dir==180) return (loc_x()>100); 
  else if (dir== 90) return (loc_y()<900); 
}

fire(dir)   
{
  drive(dir,vel);
  if (orng=scan(deg,10))
  {
    if (orng<200)  
    {
      if (orng<80) return cannon(deg,50);
      if (scan(deg-10,6)) deg-=10;
      else if (scan(deg+10,6)) deg+=10;
            
      return cannon(deg,(scan(deg,10)<<1)-orng);   
    } 
        
    if (!scan(deg-=6,6)) deg+=12; 

    affina();
    if (orng=scan(odeg=deg,5))
    {
      if (speed(affina())>30)
        cannon(deg+(deg-odeg)*((1200+(rng=scan(deg,10)))>>9)-(sin(deg-dir)>>14), rng*250/(250+orng-rng-(cos(deg-dir)>>12)));                    
      else
        cannon(deg+(deg-odeg)*((1200+(rng=scan(deg,10)))>>9), rng*300/(300+orng-rng));
    } 
  }
  else
  {
    if (scan(deg-=20,10))  return;
    if (scan(deg+=40,10))  return;
    if (scan(deg+=160,10)) return;
    deg-=120;  
  }
}

affina()
{
  if(scan(deg-7,3)) deg-=5;
  if(scan(deg+7,3)) deg+=5;
  if(scan(deg-4,2)) deg-=3;
  if(scan(deg+4,2)) deg+=3;
  if(scan(deg-2,1)) deg-=1;
  if(scan(deg+2,1)) deg+=1;
}

