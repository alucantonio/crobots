/* *************************** TIFO ******************* */
/* crobot di :

QUETSO HA 648 ISTRUZIONI E GAREGGIA NEI 1000

LUCA STRINGHER

COME SI COMPORTA:

TIFO va all'angolo più vicino e vibra in diagonale, ogni dieci vibrazioni controlla quanta gente c'è. Quando rimangono in due incomincia a vibrare in diagonale al centro dell'area

*/
int 	dir,xi,yi,i,ang,angm,d,d0,d1,d2,a,b,v,dq,angq,q,c,q1,q2,r,x,y,k,e;

main()
	{c=0;r=20;k=0;
	inoculazione();
	avvicinamento();
	
	while(1)
		{
		tremore();
		c+=1;r-=5; if(r<5) r=20;
		if(c>10)
			{
			c=0;
			linfociti(5);q1=q;			
			linfociti(3);q2=q;
			}
		if(q1==1 && q2==1){k=1;febbre();}

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
	if(I==1){xi=70 ;yi=70;angm=90;e=45;}
	if(I==4){xi=70; yi=930;angm=360;e=315;}
	if(I==2){xi=930;yi=70;angm=180;e=315;}
	if(I==3){xi=930;yi=930;angm=270;e=45;}
	ang=angm-90;
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

epidemia(K)
	{
	d0=scan(ang,10);
	if(d0>0 && d0<750)
		{
                if (!(d1=scan(ang+=5,5))) ang-=10;
                if (!(d2=scan(ang+=3,3))) ang-=6;
                d2=scan(ang,3);
		d=2*d2-d0; 
		/*if(d>20)
			{*/cannon(ang,d);/*}*/
		}
        else {if (scan(ang+=20,10));
             else if (scan(ang-=40));
               else ang+=80; }
	if(K==0 && ang>angm){ang=angm-90;}
	}


avvicinameto()
	{
	a=100;v=100;
	while(a>10)
		{
		while(distanza(xi,yi)>a)
			{drive(direzione(xi,yi),v);epidemia(k);}
		a-=30;v-=30;
		}
	drive(direzione(xi,yi),0);
	}

linfociti(F)
	{
	q=0;
	angq=angm-90-F;
		while(angq<angm+10)
		{
		dq=scan(angq,10);
		angq+=20;
		if(dq>0){q+=1;}
		}
	}

febbre()
	{xi=500;yi=500;
	avvicinamento;
	while(1) tremore();
				
		
	}

tremore()
	{
	while(loc_x()<(xi+rand(10)))
		{drive(e,100);epidemia(k);}
	drive(e,0);while(speed()>49) epidemia(k);
	while(loc_x()>(xi-rand(10)))
		{drive(e+180,100);epidemia(k);}
	drive(e+180,0);while(speed()>49) epidemia(k);
	}
