/*
    CROB I             di   Francesco Pagani


  CROB I  insegue l'avversario  ruotando  il  mirino in  senso  orario
  od antiorario  a seconda di dove prevede si sposterà il robot nemico.
  La gittata del colpo viene modificata  se il bersaglio si sta
  avvicinando o allontanando.

*/



main()

{
 int targ,vtarg,cor,ang,vang,k,c,t,vel;

 ang=90;vang=90;k=270;vtarg=250;
 c=1;t=3;

 while(1)
 {
 targ=0;vel=49;

/***************************  il bersaglio ‚ alle spalle ? *****************/
 if(vtarg<100)
    if((targ=scan(k,10))&& (targ<250))
	{vel=95; ang=k;}

/********************* metodo standard di ricerca del bersaglio ************/
 if(vel=49)
   {
   if(targ=scan(ang,5)) {vel=95;k=(ang+180)%360;}
   else  if(targ=scan(ang+360+c*10,10)) {ang=(ang+360+c*10)%360;}
   else  if(targ=scan(ang+360-c*10,10)) {ang=(ang+360-c*10)%360;}
   }

/**************************** correzione della gittata *********************/
 if (targ)
   {
   t=0;cor =0;
   if(vtarg<targ) cor= 40;

   cannon(ang,cor+targ*targ/vtarg);
   vtarg=targ;

/************** rispetto a CROB I il bersaglio si sta spostando ************
		       in senso orario od antiorario ?                     */
   if(vang!=ang)
    {
    if(vang<90 && ang>270)      c=-1;
    else if(ang<90 && vang>270) c= 1;
    else if(vang>ang) c=-1;
    else if(vang<ang) c= 1;
    vang=ang;
    }
  }
 else {ang=(ang+360+c*30)%360;  t+=1;}
 drive(ang,vel);

/*************** se non trova il bersaglio con la ricerca standard *********
		    allora effettua una ricerca rapida a 360 gradi         */
 if(t >2)
  {
  ang=(ang+360-c*20)%360;
  while (targ==0 ) {
		    ang=(ang+360+c*20)%360;
		    targ=scan(ang,10);
		    drive (ang,49);
		   }
  cannon(ang,targ);
  t=0;
  }
 }
}



