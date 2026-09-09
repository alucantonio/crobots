/* **********************************PESTE***************************** */

/* crobot di :

QUESTO HA 744 ISTRUZIONI E GAREGGIA NEI 1000

LUCA STRINGHER

COME SI COMPORTA:

Peste va all'angolo più vicino e incomincia a fare un quadrato random ( vedi colera) sempre più piccolo, ogni tanto controlla quanti sono rimasti. Se restano in due il quadrato lo fa in centro all'arena.

*/
int	xi,yi,q,dir,i,ang,angm,dq,angq,r,a,x,y,d,d0,d1,d2,k,c,A,B,R;

main()
	{
	inoculazione();
	while(distanza(xi,yi)>30){drive(direzione(xi,yi),70);epidemia(0);}
	drive(direzione(xi,yi),0);
	linfociti();
	r=10;
	c=0;
	while(1)
		{R=rand(r);
		incubazione(xi,yi);
		c+=1;
		if(c>10){linfociti();c=0;}
		r-=1;
		if(r<1){r=10;}
		}
	
	}

inoculazione()
	{
	if(loc_x()>500){i=2;}else{i=1;}
	if(loc_y()>500){i+=1;if(i==2){i=4;}}
	trasmissione(i);
	}

trasmissione(I)
	{
	if(I==0){I=4;}
	if(I==1){xi=40 ;yi=40;angm=95;A=B=1;}
	if(I==4){xi=40; yi=960;angm=365;A=1;B=-1;}
	if(I==2){xi=960;yi=40;angm=185;A=-1;B=1;}
	if(I==3){xi=960;yi=960;angm=275;A=B=-1;}
	ang=angm-95;
	}


linfociti()
	{
	q=0;
	angq=angm-100;
		while(angq<angm)
		{
		dq=scan(angq,10);
		angq+=20;
		if(dq>0){q+=1;}
		}
	if(q==1){xi=490;yi=490;ang=rand(360);r=20;A=B=1;}
	}


distanza(X,Y)
	{
	return(sqrt((loc_x()-X)*(loc_x()-X)+(loc_y()-Y)*(loc_y()-Y)));
	}

direzione(X,Y)
	{
	if(X>loc_x()){dir=atan(100000*(loc_y()-Y)/(loc_x()-X));}
	else{dir=atan(100000*(loc_y()-Y)/(loc_x()-X))+180;}
	return(dir);

	}

incubazione(X,Y)
	{
	x=A*R+X;a=0;
	while(speed()>49)
		{epidemia(q);}
	while(loc_x()<x){drive(a,70);epidemia(q);}
	drive(a,0);
	y=B*R+Y;a=90;
	while(speed()>49);
		{epidemia(q);}
	while(loc_y()<y){drive(a,70);epidemia(q);}
	drive(a,0);
	x=A*R+X;a=180;
	while(speed()>49);
		{epidemia(q);}
	while(loc_x()>x){drive(a,70);epidemia(q);}
	drive(a,0);
	y=B*R+Y;a=270;
	while(speed()>49);
		{epidemia(q);}
	while(loc_y()>y){drive(a,70);epidemia(q);}
	drive(a,0);
	}


epidemia(K)
	{
	d0=scan(ang,10);
	if(d0>0)
		{
                if (!(d1=scan(ang+=5,5))) ang-=10;
                if (!(d2=scan(ang+=3,3))) ang-=6;
                d2=scan(ang,3);
		d=2*d2-d0; 
		if(d>20)
			{cannon(ang,d);}
		}
        else{if (scan(ang+=20,10));
             else if (scan(ang-=40));
               else ang+=80; }
	if(K>1 && ang>angm){ang=angm-100;}
	}


