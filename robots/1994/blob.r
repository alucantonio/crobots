/*  
    Blob  Versione 1.0
    Creato da Daniele Nuzzo
*/

int deg, dist, dam=damage(); /* deg = angolo di tiro            */
                             /* dist = distanza del bersaglio   */
                             /* dam = danno subito              */
main()
{      
/*        
   Si reca nella parte alta dello schermo e inizializza l'angolo di tiro. 
*/
        drive(90,100);                    
        while (loc_y()<960) spara1();        
        drive(0,0);                          
        while (speed()>49) spara1();         
        deg=360;       

/* 
   Corre a destra e a sinistra nella parte alta dello schermo sparando a        
   tutto ci• che incontra fino a quando non subisce un danno superiore
   al 39% .
*/
        while (damage()<40)
        {
                drive(180,100);
                while (loc_x()>80) spara1();
                drive(0,0);
                while (speed()>49) spara1();
                drive(0,100);
                while (loc_x()<920) spara1();
                drive(180,0);
                while (speed()>49) spara1();
        }

/*        
   Aggiusta l'angolo di tiro e si reca nell'angolo in basso a sinistra
   dello schermo.
*/
        deg=94;
        drive(plot_course(0,0),100);
        while (loc_y()>40) if (scan(deg,10)) cannon(deg,scan(deg,10));
        drive(180,0);
/*        
   Spara a tutto ci• che Š a portata di tiro finchŠ subisce un danno
   superiore al 84%.
*/
        while (damage()<85)
        {     
              while (dist=scan(deg,10)) 
                {
                    cannon(deg,dist);
                    while (dist=scan(deg,3)) cannon(deg,dist);
                    while (dist=scan(deg+7,3)) cannon(deg+7,dist);                         
                    while (dist=scan(deg-7,3)) cannon(deg-7,dist);     
                }
              deg-=21;
              if (deg<0 || deg>90) deg=94;
        }
        
/*
   Si sposta in maniera casuale nello schermo sparando nella direzione
   di moto in un angolo di 60ø, se viene colpito cambia velocit…, direzione.
*/
        deg=200;
        dam=damage();
        while(1)
        {
             drive(deg,49);
             if (dist=scan(deg,10)) cannon(deg,dist);
             local(deg);
             if (dam<damage() && dist==0) scappa();
             if (loc_x()<70) deg=rand(180)+270;
             if (loc_x()>930) deg=rand(180)+90;
             if (loc_y()<70) deg=rand(180);
             if (loc_y()>930) deg=rand(180)+180;
             if (loc_x()<70 && loc_y()<70) deg=rand(90);
             if (loc_x()<70 && loc_y()>930) deg=rand(90)+270;
             if (loc_x()>930 && loc_y()<70) deg=rand(90)+90;
             if (loc_x()>930 && loc_y()>930) deg=rand(90)+180;
             dam=damage();

        }
}

/*
   Visualizza la zona di fuoco.
*/
local(d)
int d;
{
        if (scan(d+21,10)) spara2(d+21);
        if (scan(d,10)) spara2(d);
        if (scan(d-21,10)) spara2(d-21);
}

/*
   Spara con discreta precisione, utilizzando a caso approssimazioni 
   di 7/8, 8/7 e 8/8(bersaglio fisso).
*/
spara1()
{
        if (dist=scan(deg,5))
        {
                cannon(deg,(7+(rand(1)))*dist/(7+rand(1))); 
        } else
          {     deg-=10;
                if (deg<=170) deg=360;
          }
}

/*
   Spara con buona precisione, operando anche delle approssimazioni sia
   sull'angolo che sulla distanza di tiro.
*/
spara2(a)
int a;
{
        while (dist=scan(a,3))  {  cannon(a,dist);  
                                   cannon(a-3+rand(6),dist-1+rand(2));  }
        while (dist=scan(a-7,3))  {  cannon(a-7,dist);  
                                   cannon(a-10+rand(6),dist-1+rand(2));  }
        while (dist=scan(a+7,3))  {  cannon(a+7,dist);  
                                   cannon(a+10+rand(6),dist-1+rand(2));  }
}

/*
    Spara in senso contrario, cambia direzione e velocit….
*/
scappa()
{
        if (loc_x()<500 && loc_y()<500) deg=30+rand(30);
        if (loc_x()<500 && loc_y()>500) deg=300+rand(30);
        if (loc_x()>500 && loc_y()<500) deg=120+rand(30);
        if (loc_x()>500 && loc_y()>500) deg=210+rand(30);
        while ((loc_x()>40) && (loc_x()<960) && (loc_y()>40) && (loc_y()<960)) 
              drive(deg,100);
        drive(deg,0);
}

/*
   Routine fornita dall'autore di CRobots.
   Individua l'angolo per recarsi nel punto di coordinate (xx,yy).
*/
plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;          
  curx = loc_x(); 
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  if (x == 0) {       
    if (yy > cury)
      
      d = 90;        
    else
      d = 270;       
  } else {
    if (yy < cury) {
      if (xx > curx)
        d = 360 + atan((scale * y) / x);  
      else
        d = 180 + atan((scale * y) / x);   
    } else {
      if (xx > curx)
        d = atan((scale * y) / x);        
      else
        d = 180 + atan((scale * y) / x);  
    }
  }
  return (d);
}
