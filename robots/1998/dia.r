/*                         Torneo di C-Robots 1998                      */
/*                                                                      */
/*   Nome   :  DIA.R                                                    */
/*   Autore :  Apuzzo Danilo                                            */
/*   E-Mail :  mc4838@mclink.it                                         */
/*                                                                      */
/*                         Descrizione                                  */
/*                                                                      */
/*   Si colloca nell'angolo Sud-Est e inizia ad oscillare in diagonale; */
/*   se colpito ripetutamente, controlla l'angolo opposto e vi si       */
/*   trasferisce. Nella fase finale, se ancora in buone condizioni,     */
/*   aumenta l'oscillazione fino al centro del campo di battaglia.      */
/*                                                                      */
/*   Se puo' partecipare un solo c-robot preferisco che sia scelto      */
/*   l'ALTRO mio c-robot di nome AI2.R                                  */





int orange,range,angle,oangle,direz;
int d,timer;
int d1,d2;
int xy1,xy2;

main()
{
   
   go();
   timer=140;
   d1=135;d2=315;
   xy1=850;xy2=150;

   while(1)
 {

  

   d=damage();
   while(check1()) 
   {
     drive(direz=d1,100);angle=direz;
     while(!((loc_x()<xy1)||(loc_y()>xy2))) {spara();}
     drive(direz=d2,100);angle=direz;
     while(!((loc_x()>920)||(loc_y()<80))) {spara();}
   timer=timer-1;
   if ((timer<=0) && (damage()<90)) { xy1=600;xy2=400; }  
   }
     drive(direz=d1,100);angle=direz;
     while(!((loc_x()<80)||(loc_y()>920))) {spara();}
   
   d=damage();
   while(check2()) 
   {
     drive(direz=d2,100);angle=direz;
     while(!((loc_x()>xy2)||(loc_y()<xy1))) {spara();}
     drive(direz=d1,100);angle=direz;
     while(!((loc_x()<80)||(loc_y()>920))) {spara();}
   timer=timer-1;
   if ((timer<=0) && (damage()<90)) { xy1=600;xy2=400; }  
   }
     drive(direz=d2,100);angle=direz;
     while(!((loc_x()<920)||(loc_y()>80))) {spara();}
 }
}



spara()
{
  if((range=scan(angle,8))&&range<770)          
  {
        
        oangle=angle;
        
        if(scan(angle-6,4))
         angle-=6;
        else
         if(scan(angle+6,4))
          angle+=6;             
            
            cannon(2*angle-oangle,range*300/(300+orange-range));
        
        }
  else
    if((range=scan(angle-18,10))&&range<850)                
      cannon(angle-=18,range);
    else
      if((range=scan(angle+18,10))&&range<850)
        cannon(angle+=18,range);
      else
        if((range=scan(angle-35,10))&&range<950)
          cannon(angle-=35,range);
        else
          if((range=scan(angle+35,10))&&range<900)
            cannon(angle+=35,range);
              else
                angle+=90;
  orange=range;
  oangle=angle;
  drive (direz,100);
  }  




go()
{
        direz=0;
        drive(direz,100);
        while(loc_x()<920) {spara();} 
     drive(direz,0); while (speed()>50);   
        direz=270;
        drive(direz,100);
        while(loc_y()>80) {spara();} 
     drive(direz,0); while (speed()>50);       
}

check1()
{
if ( ((damage()-d)>7) && (!(scan(135,10))) && (!(scan(115,10))) && (!(scan(155,10))) )
        return(0);
else return(1);
}

check2()
{
if ( ((damage()-d)>7) && (!(scan(315,10))) && (!(scan(335,10))) && (!(scan(295,10)))  )
        return(0);
else return(1);
}


