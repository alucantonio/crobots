/* KLR2 versione (no comment)                                 */
/* Questo microrobottino è praticamente identico ad sdc2.r    */
/* con la sola differenza che oscilla in alto e non tenta di  */
/* tracciare in continuazione l'avversario.                   */
/* Se doveste escludere uno dei due robot                     */
/* vorrei partecipare con sdc2.r                              */
/* Tanti saluti a tutti!                                      */
/* Ferraro Salvatore                                          */ 

/* Non sto a ricommentare il codice!                          */


int angx,angy,course,ang,oang,range,orange,spd;
main()
{
   ang=180;
   angy=980;
   while(1){
       angx=30;
       Vai();
       angx=970;
       Vai();
   }
}
   
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
        ang%=180;
        ang+=180;  
        Fuoco();
  }
}

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



scan_()
{
        if(scan(ang+354,1)) ang+=354;
        if(scan(ang+6,  1)) ang+=6;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+358,1)) ang+=358;
        if(scan(ang+2,  1)) ang+=2;
}



Fuoco()	
{
  if (orange=scan(ang,10)) {
    if (orange>850) return;
    else {
	 scan_();
	 if (orange=scan(oang=ang,5))
	 {
	    scan_();
	    if (range=scan(ang,10))
	    {
	      spd=speed()>0;
	      return cannon(ang+(ang-oang)*((1200+range)>>9)-(spd*sin(ang-course)>>14),
		                 range*172/(172+orange-range-(spd*cos(ang-course)>>12)));
            }
	 } 
      }
   }
Combatti(); 
}