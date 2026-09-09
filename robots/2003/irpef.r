/*
Robot programmato da Roberto Bevilacqua

Quanto può rendere un robot del 2000 messo di fronte agli avversari del 2003?
Per scoprirlo abbiamo preso Vegeth,l'abbiamo sgrossato e innestato con le routine di attacco di Obelix.r, ed ecco pronto
un nuovo robot, che si farà onore?

Per lo meno, il nome incute terrore!
*/

int park, ux, uy, dx, dy;                               /*Variabili posizionali*/
int flag, vang, ang, ang2;                              /*Variabili direzionali*/
int dan, timmax;                                        /*Variabili temporali*/
int dir, ango, oang, r, or;                     	/*Variabili balistiche*/
int dang, alfa, corr, anco, nrg, rg;
int max, clock, gira, time, klik, scn;
int a,oldr,rng,oa,ang_pref,dove,si,or,r;
main()                             
{
                                                        /*Calcola coordinate iniziali e agolo principale*/
Accertamento(dx=(loc_x()>500)*960+20,dy=(loc_y()>500)*960+20);
ang2=180*(dy>500)+90*(dx!=dy)+90;

Notifica(dx,dy);

while (timmax+=6)                                       /*Ciclo principale*/
  {
    if ((Addizionale(ang2+220,9))<2)                    /*Controlla quanti sono i sopravvissuti*/
      Multa();                     

    while (--timmax)                                    /*Movimento oscillatorio*/
       {                                              
                                                        /*Decide se e' il momento di
                                                          cambiare angolo, in base ai danni
                                                          e alla posizione del nemico*/

             if (or=Indaga(ang2+630))
               {
                 while (speed());
                 if ((or=Indaga(ang2+630))&&(Indaga(ang2+630)==or))
                   flag=630;
               }
             if (!flag)
               {
                 if (Indaga(ang2))
                   {
                    while (speed(flag=630));
                    if ((r=Indaga(ang2))&&(Indaga(ang2)==r))
                      flag=0;
                    else if (!or)
                           {
                             if (time>11) flag=0;
                           }
                    else if (r>or) flag=0;
                   }
                 else if ((or)&&(time>11)) flag=630;
               }

          drive (a=ang_pref=ang=(ang2+flag),100);       /*Si allontana dall' origine*/
          while ((Liquidazione(dx,dy)<95000))
               SuperSayian();
   
          Contesta();                                   /*Rallenta*/

          Notifica(dx,dy);                              /*Torna all' origine*/
   }

++time;

  }
}


/*Vai alla distanza minima dal punto*/

Notifica(fx,fy)
int fx, fy, h;
  {
     drive (ang,100);                 
     while (((h=Liquidazione(fx,fy))>5200)&&(speed()))
            SuperSayian(h<25000);
     return Contesta();
  }

Accertamento(mx,my)                                            /*Individua l' angolazione necessaria per raggiungere un punto dato*/
int mx, my;
  {
     return (ang=(360+((mx-=loc_x())<0)*180+atan(((my-loc_y())*100000)/(mx+(mx==loc_x())))));
  }

Liquidazione(nx,ny)                                            /*Calcola la distanza rispetto ad un punto dato*/
int nx, ny;
  {
     return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

Indaga(an)
int an;
  {
     return (scan(an+350,10))+(scan(an+10,10));
  }

Contesta()                                                     /*Procedura di rallentamento standard*/ 
  {
            SuperSayian(SuperSayian(drive(ang+=180,0)));
  }

Addizionale(dsiete,dand)                                       /*Conta i superstiti*/
int dsiete, dand, qsiete;
  {
     while (--dand)
          qsiete+=(scan(dsiete+=20,10)!=0);
     return (qsiete);
  }

Multa()
int z;
  {
	while (1)
	{	
			dx=1000-loc_x();
			while((loc_x()>dx)==(z=(dx<500))) 
			{
				
				if(loc_y()>500)
				{
					Fuoco(275-10*z);
				}
				else
				{
					Fuoco(85+10*z);
				}
			}
	}

  }

SuperSayian(si)
  {
  if (si);
  else if (scan(a,10))
    {
      if ((or=Rivela(drive(ang,100)))<850)
        {
          if (r=Rivela())                
             return cannon((oa+(a-oa)*3-(sin(a-ang)/19500)),(r*220/(220+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10))&&(r<850));
  else if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang_pref,10))){ a=ang_pref;}
        else
          return (a+=43);
  }

Rivela()   
{
  if(scan((oa=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

Fuoco(verso)
{
	drive (verso,100);
    if (or=scan(a,10)) {
           if (scan(a,2))		{if (cannon(a+0+0+0+0,3*scan(a,10)-2*or)) return;}
           else if (scan(a-=7,6))	{if (cannon(a-6,2*scan(a,10)-or)) return;}
           else if (scan(a+=14,6))	{if (cannon(a+6,2*scan(a,10)-or)) return;}
	   else a+=10;
	   return Fuoco(verso);
    } 
    else {
        if (or=scan(a+=339,10))		cannon(a,or);
        else if (or=scan(a+=42,10))	cannon(a,or);
        else if (or=scan(a+=297,10))	cannon(a,or);
        else if (or=scan(a+=84,10))	cannon(a,or);
        else {a+=65;return Fuoco(verso);}
    }
}





