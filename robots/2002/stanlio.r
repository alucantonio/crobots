/*
Nome del robot  : Stanlio.r
Autore		: Alessandro Tassara

Il robot, come al solito, cerca di non farsi massacrare dai nemici standosene buono buono in un angolo.
Se lo infastidiscono salta sulla sua Peugeot106 e scappa in altro loco.
A grande richiesta tornano le TOxiche, nella versione di Raistlin.r

Ogni quando gli va conta i superstiti e, se ne trova solo uno, lo attacca, 

In che modo, vi chiederete voi, miei piccoli lettori?
Con un Un quadrato!!!!!!!!!!!!!!!!!!!
Questa volta, pero', l'implementazione e' assai diversa da Groucho.

Si tratta dell'ennesimo robot capocomico... vi fara' molto sganasciare dalle risate.

*/

int t,z,vdist;
int a,ang,oang,r,or,dor,dan,anni,last,flag4;

main()
  {
        Peugeot(180*(loc_x(Peugeot(90+180*(loc_y()<500)))<500));
        while (t=last=anni=20)
	{

                while ((anni+=20)<400) last+=(scan(anni,10)>0);
                while (last<22)
                {
                        Peugeot(90+180*(loc_y(z=300)>500));
                        Peugeot(180*(loc_x()>500));
                        Raist_fire(0);
                }
                while(--t)                                                   /*inizia il loop, nel quale, con una routine copiata da goblin, calcola l' angolo*/
                {
                        if(dan<damage()-8)
                        {
                                if (Scan(dor=180*(loc_x(dan=damage())>500)))    /*controlla se l' angolo precedente e' libero*/
                                {
                                        Peugeot(dor);
                                }
                                else if ((Scan(dor=90+180*(loc_y()>500))))              /*controlla se l' angolo seguente e' libero*/
                                {
                                        Peugeot(dor);
                                }
                        }
                        Raist_fire(0);
                }
        }
  }

Peugeot(k)  /*Si sposta verso le coordinate date*/
int k;
  {
        if ((ang=k)>180)
                while (loc_y()>100+z) Raist_fire(1);
        else if (ang>90)
                while (loc_x()>100+z) Raist_fire(1);
        else if (ang>0)
                while (loc_y()<900-z) Raist_fire(1);
        else
                while (loc_x()<900-z) Raist_fire(1);
                        Raist_fire(0);
   }
                                          /* Utilities per raccogliere il codice */

Scan(y)
int y;
  {
        return ((scan(y+350,10)+(scan(y+10,10)))==0);                       /*effettua una scansione allargata di 14 gradi*/
  }


Raist_fire(flag)
int flag;
{
drive(ang,flag*100);
   if (scan(a,10))
    {
      if ((or=Rivela())<(850+2000*(last<22)))
        {
          if (r=Rivela())                
             return cannon((oang+(a-oang)*3-flag*(sin(a-ang)/19500)),(r*200/(200+or-r-flag*(cos(a-ang)/4167))));
        }
    }      
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang,10))) a=ang;
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

