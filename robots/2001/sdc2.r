/* SDC2 versione -9.45 */
/* Questo microrobottino è praticamente uno stupido patentato che trascorre                     */
/* la sua breve esistenza oscillando in fondo al campo di battaglia cercando                    */
/* i nemici e tentando di colpirli (risibile ipotesi).                                          */
/* A tale scopo utilizza due differenti algoritmi di fuoco uno dei quali spudoratamente copiato,*/
/* l'altro spudoratamente inventato. Il primo è quello classico che tutti usano                 */
/* (ma quanti lo hanno capito?) l'altro (forse interessante) localizza l'avversario (forse)     */
/* con buona risoluzione con una tecnica di sovrapposizione dei fasci di localizzazione.        */
/* Il breve tempo a mia disposizione non mi ha concesso di sviluppare al meglio l'idea,         */
/* e forse è un bene perchè potrebbe essere un fiasco colossale.                                */
/* Se dovessi raggiungere la metà della classifica considererei il fatto una vittoria.          */

/* Per informazioni io sono Salvatore Ferraro                                                   */
/* Si accettano: soldi, proposte indecenti (da parte di sole donne sotto i 40), elemosina       */
/* zoccoli nuovi, conottiere usate...                                                           */
/* A parte gli scherzi un saluto a tutti e complimenti!!!!!!                                    */
/* P.S: vinca il migliore!!!!!                                                                  */

/* Variabili globali...*/
int angx,angy,course,ang,oang,range,orange,spd;

main()
{
   ang=1;
   angy=20;
   while(1){ /* ho provato con for(;;) ma il compilatore ha pernacchiato!*/
       angx=30;
       Vai();
       angx=970;
       Vai(); /*Spostamento e fuoco...*/
   }
}
 
/* Solita...inutile descriverla...*/  
Direzione (xx,yy)
int xx,yy;
{
  int d;
  int x,y;
  int curx, cury;  
  curx=loc_x();  
  cury=loc_y();
  x=curx-xx;
  y=cury-yy;
  if (!x)       
    d=90+(180*(yy<cury));     
  else {
    if (yy<cury) 
      d=atan((100000*y)/x)+180+180*(xx>curx);
    else 
      d=atan((100000*y)/x)+180*(xx<curx);
  }
  return (d);
}

/* Solita...inutile descriverla...*/
Distanza (x1,y1,x2,y2)
int x1,y1,x2,y2;
{
  int x,y,d;
  x = x1-x2;
  y = y1-y2;
  d = sqrt((x*x)+(y*y));
  return(d);
}


Vai ()
{
  course=Direzione(angx,angy); 
  while(Distanza(loc_x(),loc_y(),angx,angy)>270){
        drive(course,100);
        ang%=180; /* per effettuare la scansione sempre tra 0 e 180 gradi...*/ 
        Fuoco();
  }
}

/* Questa procedura ricerca un bersaglio con due fasci parzialmente sovrapposti      */
/* quindi se la ricerca è positiva probabilmente il bersaglio si trova nella zona di */
/* scansione comune che è molto ristretta. In realtà così non funziona bene          */
/* perchè in effetti ci sono alcune situazioni che andrebbero considerate...vedremo! */
Combatti()
{
  int r1,r2,r;
  if(((r1=scan(ang,5))>50)&&((r2=scan(ang+6,5))>50))
  {
    if(((r=scan(ang+3,2))>50))
    {
      if(r<350)                           cannon(ang+3,r+(r-r2));
      else
      {
         if(((r=scan(ang+2,1))>50))       cannon(ang+2,r+(r-r2));
         else
           if(((r=scan(ang+4,1))>50))     cannon(ang+4,r+(r-r2));
      }
    } 
  }
ang+=20; 
}
 

/* Cerca l'avversario con buona risoluzione...*/
scan_()
{
        if(scan(ang+354,1)) ang+=354;
        if(scan(ang+6,  1)) ang+=6;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+358,1)) ang+=358;
        if(scan(ang+2,  1)) ang+=2;
}


/* solita routine di fuoco...*/
Fuoco()	
{
  if (orange=scan(ang,10)){
    if(orange>850) return; 
    else {
	 scan_();
	 if (orange=scan(oang=ang,6))
	 {
	    scan_();
	    if (range=scan(ang,10))
	    {
	      spd=speed()>0;
	      return cannon(ang=ang+(ang-oang)*((1200+range)>>9)-(spd*sin(ang-course)>>14),
		            range*172/(172+orange-range-(spd*cos(ang-course)>>12)));
            }
	 } 
     }
  }
Combatti();
}