/*
Name		: Brexit
Type		: Micro
Version		: 1.0
Author		: Maurizio Camangi
Begin		: 29-03-2017
Revision	: 29-03-2017

Brexit e' (manco a dirlo) un'involuzione di British (thanks to Marco Pizzocaro).
Brexit odia tutti, per questo e' puro F2F (l'F2F di British... per l'appunto).
*/


int range, dir, oang, ang;
int b, posy, posx;

main() {
		int b=0;
			while(1) {

				if ((posx=loc_x())>880 ) dir=180;
				else if (posx<120 ) dir=0;
				else if ((posy=loc_y())>880 ) dir=270;
				else if (posy<120) dir=90;
				else if (range>600) dir=ang+25+(b^=1)*335;
				else if (range<150) dir=ang+170+(b^=1)*10;
				else dir=ang+180*(b^=1);


				farage(dir);
				farage(dir);
				farage(dir);

				drive(dir,60);
	   }
}

farage(d)
{
	drive(d,100);
	if ((range=scan(oang=ang,10))) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon((ang<<1)-oang,(scan(ang,10)<<1)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon((ang<<1)-oang,(scan(ang,10)<<1)-range)); }
		if (scan(ang,10))     { if (scan(ang-=3,3)) ; else ang+=6; return(cannon(ang,(scan(ang,10)<<1)-range)); }

	}
	else {
		if (range=scan(ang+=340,10)) return boris();
		if (range=scan(ang+=40,10)) return boris();
		if (range=scan(ang+=300,10)) return boris();
		if (range=scan(ang+=80,10)) return boris();
		if (range=scan(ang+=260,10)) return boris();
		if (range=scan(ang+=120,10)) return boris();
		ang+=80;
	}
}


boris(){cannon(ang, (scan(ang,10)<<1)-range);}
