/*
Nome del robot  : Another Droid of Small Lenght
Nome del file   : Adsl.r
Autore          : Gianni Ino

Il robot e' una rielaborazione di Risc.r, che ha partecipato al torneo dello
scorso anno.
E' stato scrito in mezz'ora, e l'unica cosa a cui mi sono dedicato con perseveranza è stata
la ricerca di un nome.
Adsl non si sosta piu' dal suo angolo, e non usa nemmeno piu' le toxiche. In compenso ora ha
un vero attacco finale.
Se ha un solo avversario, infatti, si piaxìzza in mezzo all'arena e oscilla parallelamente alla
bisettrice del quadrante di origine.
*/

int scn, angolo, oscn, oangolo;   
int z,dir,tempo,dove,quanto,lim,ang;
int py,px,dor,danni,x,y,v;

main()
{
    x=40+920*(loc_x((y=40+920*(loc_y()>500)))>500);
lim=850;
    while (++tempo)
    {

       dir=(360-((px=(x-loc_x()))<0)*180+atan(((y-loc_y())*100000)/px));

       while ((((px=x-loc_x())*px+(py=y-loc_y())*py))>10000) fuoco();
       drive(dir+180,0);

       dir=45+90*((x>500)+(1+2*(x<500))*(y>500));
	if ((tempo%10)==1) 
        {
          dove=0;
          quanto=0;
          while ((dove+=20)<380) quanto+=(scan(dove,10)>0);
        
  if (quanto<2) {lim=3000;
 ang=dir+180*(loc_x()>500);

	while (1)
	{
		if (loc_x()<500) fuoco(dir=ang);
		else fuoco(dir=ang+180);	
}}
        }
       while ((loc_x()%850)<150) fuoco();
       drive(dir+180,0);
    }        
}

free (gradi)
{
    return (!(scan(gradi+350,10)+scan(gradi+10,10)));
}

fuoco()
  {
     drive (dir,100);
     if((oscn=scan(angolo,10))&&(oscn<lim))
        {
           if (scn=scan(angolo,3))return cannon (angolo,2*scn-oscn);
           else if (scn=scan(angolo-=7,3))return cannon (angolo-7,2*scn-oscn);
           else if (scn=scan(angolo+=14,3))return cannon (angolo+7,2*scn-oscn);
           else return;
	   
        }
     else
       if(scan(angolo+=21,10));
       else
         if(scan(angolo-=42,10));
         else
             return (angolo+=84);
  }  
