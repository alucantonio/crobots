/* **********************************VAIOLO*****************************
questo robot è dedicato alla pazienza infinita di Alessandro Carlin, mio maestro nei Crobots che spero di fregare!!*/

/* crobot di :

QUESTO HA 386 ISTRUZIONI E GAREGGIA NEI 500

LUCA STRINGHER

COME SI COMPORTA:

vaiolo va all'angolo più vicino e fa un quadrato come gli altri virus. piccolo. da implementare

*/

int x,y,a,b,ang,xi,yi,anga,d0,d3,d4,d1,d2,i,angm,r,dq,q,angq,d,D,ang2,ang3,ang4;
main()
{
inoculazione();
r=40;
incubazione();}

inoculazione()
{
x=loc_x();y=loc_y();
if(x>500){i=2;}else{;i=1;}
if(y>500){i+=1;if(i==2){i=4;}}
trasmissione();
}

incubazione()
{

while(1)
{
x=rand(r)+xi;a=0;
while(speed()>49);{epidemia();}
while(loc_x()<x){drive(a,100);epidemia();}drive(a,0);
y=rand(r)+yi;a=90;
while(speed()>49);{epidemia();}
while(loc_y()<y){drive(a,100);epidemia();}drive(a,0);
x=rand(r)+xi;a=180;
while(speed()>49);{epidemia();}
while(loc_x()>x){drive(a,100);epidemia();}drive(a,0);
y=rand(r)+yi;a=270;
while(speed()>49);{epidemia();}
while(loc_y()>y){drive(a,100);epidemia();}drive(a,0);
/*linfociti();*/
/*r=r-10;
if(r<10){r=40;}*/
}
}

epidemia()
{
d0=scan(anga,10);
if(d0>0)
	{
	cannon(anga,d0);

	/*D=5;
	while(D>1)
		{anga=anga+D;	
		d1=scan(anga,D);
		if(d1==0){anga=anga-2*D;d1=scan(anga,D);}
		d4=d3;ang4=ang3;
		d3=d2;ang3=ang2;
		d2=d1;ang2=anga;
		D=D-2;
		}
	anga=anga+(ang2-ang4)/2;
	d=d1+(d2-d4)/2;
	cannon(anga,d);*/
	}
else{anga+=20;}
if(anga>angm){anga=angm-90;}
	
	
}

trasmissione()
{
if(i==1){xi=80 ;yi=80;angm=90;}
if(i==4){xi=80; yi=870;angm=360;}
if(i==2){xi=870;yi=80;angm=180;}
if(i==3){xi=870;yi=870;angm=270;}
anga=angm-90;
}
/*
linfociti()
{
q=0;
angq=angm-90;
while(angq>angm)
	{dq=scan(angq,10);
	angq=angq+20;
	if(dq>0){q+=1;}
	}
}*/
