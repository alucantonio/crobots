/****************************************************************************/
/*									*/               
/*  			             Torneo di CRobots 2004                         */
/*                                                                          */
/*   		                        GERIBA                                  */
/*                                                                          */
/*  			           Categoria: 2000 istruzioni                       */ 
/*                       Versione: 0.4 - built 30.11.2004                   */                                                                     	           
/*                         Autore: Michele Prati                            */
/*                                                                          */
/****************************************************************************/


/*
L'idea alla base del progetto Geriba e' il movimento temporizzato a zig a zag che dovrebbe
eludere le toxiche. Il robot senza continuare a controllare la propria posizione spara e 
cerca gli avversari con funzioni a tempo cicli costante.
Le funzioni di moto sono implementate in modo parametrico in modo da permettere a Geriba di
variare continuamente l'angolo e la lunghezza (chiamando 1 o 2 volte la funzione fuoco) del 
movimento a zig-zag, e lo spazio percorso in orizzontale o verticale.
Pensavo fosse un'idea interessante e nuova. 
Interessante sicuramente, ho imparato a programmare considerando anche il tempo!!
Nuova, probabilmente perche' a fronte delle difficoltà di sviluppo ha portato Geriba a un
 gran bel movimento, ma assolutamente inefficace.
Il problema maggiore infatti è che il movimento ottenuto limita le capacità di fuoco, ma 
soprattutto non permette di far spostamenti corti o cortissimi nell'angolo.
Avendo avuto poco tempo da dedicare a CRobot ed avendo fatto il primo test di torneo, deludente, 
solo oggi, piuttosto di rinunciare, ho pensato in questa ora che rimane di innestare a Geriba 
parte di un micro che se la cava bene negli angoli, Danica di Daniele Nuzzo.
Il risultato non è esaltante, il movimento originariamente punto di forza, ora mostra qualche pecca
e alcune funzione sono da ritarare. 
Mancan 10' alle 24:00, invio crobot avendolo testato solo contro dei "target.r".

Ringraziamenti:
Ringrazio tutti i sostenitori, i giocatori e soprattutto gli organizzatori di questo divertente
ed interessante torneo a colpi di "C".
IN BOCCA AL LUPO A TUTTI!!!

Bibliografia:
Ho tratto qualche idea e riga di codice da Rudolf_6 di Alessandro Carlin e
 Vegeth di Simone Ascheri.
*/

 



int d_deg,d_rng,d_odeg,d_xs,d_ys,d_en,d_rd,d_ren,d_timer,d_sc1,d_sc2,d_ff,d_xd,d_yd,d_xp,d_yp, d_dmax,d_dmin,d_zd;




int i, limit1, zig, delta, z, nrepeat, btrovato, oldr, rng, deg, psx, pup, nrg, orng, ango, oang, dir, tmp1, tmp2;
int rg, bcarico, en, ren, rd, blungo, daa, deltang, cuscino, loop, b, distmove;



 
up(limt) {while(loc_y()<limt) {drive(90,100);Fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);Fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(360,100);Fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);Fire();}drive(180,0);}





main()
{


  d_xp=60+(d_xs=loc_x(d_yp=60+(d_ys=(loc_y(d_en=3))>499)*880)>499)*880;
  drive(d_xd=180*d_xs,100); 
  d_sc1=d_sc2=1;  

  d_dmax=(d_dmin=(d_zd=(d_yd=90+180*d_ys)-45+90*(d_xs^d_ys))-60)+100;

  while(d_en>1) {
    Run(d_xd,d_xp,2-d_xs);	
    Run(d_yd,d_yp,6-d_ys);	
  }


zig=60;
cuscino=350; 
blungo=0;

 while(1)
 {


 Move();

 
 daa=damage();
 loop=1;

 while (loop)
	 {


	if (b<1) {psx=-1;sx2(distmove); while (speed()>59);}
	if (b<2) {b=0; pup=1;up2(distmove); while (speed()>59);}
	if (b<3) {b=0; psx=1;sx2(cuscino); while (speed()>59);}
	if (b<4) {b=0; pup=-1;up2(cuscino); while (speed()>59);}

				

			

		   if (((damage()-daa)>15)) {
									loop=0; 
									if (zig>31) zig-=15;
										else zig=45;
									cuscino=150;
									} 


	 }
 }




}



Fuego(dir,v)
{
  drive(dir,v);
  if (d_rng=scan(d_odeg=d_deg,10))  
  {    
    if (scan(d_deg+350,10)) d_deg-=d_sc1; else d_deg+=d_sc1;
    if (scan(d_deg+10,10)) d_deg+=d_sc2; else d_deg-=d_sc2; 
    cannon(d_deg+(d_deg-d_odeg)*d_ff,(scan(d_deg,10)<<1)-d_rng);
  } else {
      if (d_rng=scan(d_deg+=340,10)) return cannon(d_deg,d_rng); 
      if (d_rng=scan(d_deg+=40,10))  return cannon(d_deg,d_rng);  
      while (!(d_rng=scan(d_deg+=20,10))) ; 
      cannon(d_deg,d_rng);
  }
}



Run(d,l,m) { 
  int r;
  if (d_timer%12==2) {
    d_en=0;
    while (d_dmin<=d_dmax) d_en+=(scan(d_dmin+=20,10)>0);
    d_dmin=d_zd-60; 
  }
  
  while(r<2) {
  drive(d,100);
  
  ++r;
  if (++d_timer>440+damage()) d_en=1;  
  
  if (scan(d,10)) { d_deg=d; while (scan(d,10)>840) ; } else while(Controlla(l,m)) ;
    
   
  Fuego(d,0);  
  while(speed()>59) ;
  ++m;  
  d+=180;
  } 
}

Controlla(l,m) {
  int c1;
  if (m<5) c1=loc_x(); else c1=loc_y();
  if (m%2) return (c1>l); else return (c1<l);	
}




	
Fuoco()
  {
	 z=3;
     

	 btrovato=0;
     while (--z) Cerca(oang=ango);

	 

	 if (btrovato==2)

	 {     
    


          if (rg=scan(ango,10)) 
			return cannon(ango+(ango-oang)*((1200+rg)>>9)-(sin(ango-dir)>>14),rg*192/(192+nrg-rg-(cos(ango-dir)>>12)));
		  else 
			if(Check(0)) return cannon(ango,2*scan(ango,10)-rg);
				else return 0;
				


		}
	 if(Check(40)) return cannon(ango,2*scan(ango,10)-rg);
}


sx2(limt) 
{
	 	
	if ((delta=(loc_x()-limt)*psx)<40) return 0; 

	/* delta=(loc_x()-limt)*psx;*/
	limit1=loc_y()-1;


    nrepeat=delta*450/cos(zig);


	i=0;
	bcarico=1;

	while (i<nrepeat)
	{
		if (psx==1) dir=zig+180; 
			else dir=360-zig;

		while(loc_y()>limit1) { 
							
								drive(dir,100); 
								

								if (i)  
									{
									if (bcarico) {Fuoco(); bcarico^=1;}
									if (blungo);
									}

								    else 
									
										Radar(5);  
								
		
								} 
		drive(dir,40); 

		if (psx==1) dir=180-zig;
			else dir=360+zig;
		
		bcarico=1;
		while (speed()>59); 
	
		while(loc_y()<limit1) { 
								
								drive(dir,100); 

							   if (i)  
									{
									if (bcarico) {Fuoco(); bcarico^=1;}
									if (blungo); /*Fuoco()*/
									}

								    else 
									{
										Radar(6);
										if (rg=scan(ango,10)) cannon(ango, rg);
									}

									
								} 

	
		bcarico=1;
		drive(dir,40);
		while (speed()>59); 
	
	++i;
	}

	if (psx==1) {

		while (loc_x()>limt) drive(180,49);
		tmp1=180;
		}
		else
		{
		while (loc_x()<limt) drive(0,49);
		tmp1=0;
		}

		Fuocoaprox();
		
}



up2(limt) 
{
	 	
    if ((delta=(limt-loc_y())*pup)<40) return 0; 

	/* delta=(limt-loc_y())*pup; */
	limit1=loc_x()-1;


    nrepeat=delta*450/cos(zig); 


	i=0;
	bcarico=1;

	while (i<nrepeat)
	{
		if (pup==1) dir=90+zig; 
			else dir=270-zig;
		while(loc_x()>limit1) { 
								drive(dir,100); 
								
								if (i)  
									{
								    if (bcarico) {Fuoco(); bcarico^=1;}
									if (blungo);
									}

								    else 
									
										Radar(5);   
		
							
								} 
		drive(dir,40); 
		if (pup==1) dir=90-zig; 
			else dir=270+zig;

		bcarico=1;

		while (speed()>59); 
	
		while(loc_x()<limit1) { 
								drive(dir,100); 

							   if (i)  
									{
									if (bcarico) {Fuoco(); bcarico^=1;}
									if (blungo);
									}

								    else 
									{
										Radar(6);
										if (rg=scan(ango,10)) cannon(ango, rg);
									}

								} 

		bcarico=1;
		drive(dir,40);
		while (speed()>59); 
	
	++i;
	}

  

	if (pup==1) {

		while (loc_y()<limt) drive(90,49);
		tmp1=90;
		}
		else
		{
		while (loc_y()>limt) drive(270,49);
		tmp1=270;
		}
	
		Fuocoaprox();

}

Fuocoaprox()
{

		drive(tmp1,0);

		if (rng=scan(ango,10)) return cannon(ango,rng);
		if (rng=scan(ango+20,10)) {ango+=20; return cannon(ango,rng); }
/*		if (rng=scan(ango-20,10)) {ango-=20; return cannon(ango,rng); } */
		if (rng=scan(tmp1,10)) cannon(tmp1,rng);

}



Cerca()
  {
    if (TrovaB()) return (++btrovato);
    if (TrovaB(ango-=19)) return (++btrovato);
    if (TrovaB(ango+=38)) return (++btrovato);
    return (btrovato=0);
  }


TrovaB()
{

if ( nrg=scan(ango,10) )  
 { if ( scan(ango+6,5) )
   {  if ( scan(ango+2,2) )
      {  if ( scan(ango+4,1) ) 
         {  if ( scan(ango+3,0) ) 
             ango+=3; 
	    else
             ango+=4;
	 }
	 else
            if ( scan(ango+2,0) )
             ango+=2; 
	    else
             ango+=1; 
      }
      else
      {  if ( scan(ango+8,1) ) 
         {  if ( scan(ango+7,0) ) 
             ango+=7; 
	    else
             ango+=9;
	 }
      else
         if ( scan(ango+6,0) )
            ango+=6; 
	 else
            ango+=5; 
      }
   }
   else
   {  if ( scan (ango-1,2) )
      {  if ( scan(ango-3,1) )
         {  if ( scan(ango-2,0) ) 
             ango-=2;
	    else
             ango-=3;        
	 }
	 else
           if ( scan(ango-1,0) )
            ango-=1;
	   else
            ango-=0;        
      }
      else
      {  if ( scan(ango-4,1) )
         {  if ( scan(ango-5,0) ) 
             ango-=5;
	    else
             ango-=4;        
	 }
	 else
           if ( scan(ango-6,1) )
            ango-=6;
	   else
            ango-=8;        
      }
   }
 return 1;
 }
return 0;
}



Fire() 
{
  if (oldr=scan(deg,10)) Pesta();
  else if (oldr=scan(deg-=20,10)) Pesta();
  else if (oldr=scan(deg+=40,10)) Pesta();
  else return deg+=40;
}


Pesta()
{
         if (rng=scan(deg,1))   return cannon(deg,rng+(rng-oldr)/3);
    else if (rng=scan(deg-5,4)) return cannon(deg-=3,rng+(rng-oldr)/3);
    else if (rng=scan(deg+5,4)) return cannon(deg+=3,rng+(rng-oldr)/3);
}




Check(deltang) 
  {  
     if (rg=scan((ango-=(20+deltang)),10));
		else if (rg=scan((ango+=(40+deltang)),10));
			else if (rg=scan((ango-=(60+deltang)),10));
				else if (rg=scan((ango+=(80+deltang)),10));
					else return 0;
     return rg;
  } 
  


/* Radar: funzione utile in origine per contare avversari e come temporizzatore di Fuoco()
Ora svolge non molto bene solo la seconda funziona, e non ho tempo per ritarla */
Radar(volte) 

{
	tmp2=0; 
while (--volte) 
	{
	if (tmp1=scan(rd+=20,10)) {++ren; tmp2=tmp1; tmp1=rd;} 
/*	if (rd>710) {en=ren; rd=ren=0;} */
	}

}

Move()
{

distmove=1000-cuscino;

if ((tmp2=loc_y())>500) if (tmp2>distmove) dn(distmove);
							else up(distmove); 
			else dn(cuscino);

if ((tmp1=loc_x())>500) if (tmp1>distmove) sx(distmove);
							else dx(distmove); 
			else sx(cuscino);

b=(tmp2>500)*2+(tmp1>500);
 if (b==2) b=3;
 else if (b==3) b=2;

 ango=deg;
}