/*
Nome del robot  : Groucho.r
Autore		: Alessandro Tassara

Il robot, come al solito, cerca di non farsi massacrare dai nemici descrivendo un quadrato nel luogo
dove ha deciso di soggiornare.
Come da ultima moda stagione 2001, non si schioda da li' nemmeno se arriva Claudia Schiffer a tentarlo, a meno
che non conti un unico avversario superstite, nel quel caso lo attacca con, novita' delle novita'.....

Un quadrato!!!!!!!!!!!!!!!!!!!1

Il nome del robot e' tutto un programma.... infatti vi fara' molto ridere durante tutto il torneo.

In ogni caso, Gruocho e' un ragazzo fortunato, perche' puo' dire:
'Mai avuto Toxiche in vita mia'

*/

int r, or,a,oa,z,k,a,r,t,d,anni,last;

main()
{
	z=loc_y(k=loc_x(t-=8)<500)<500;
	while (t+=last=anni=10)
	{
		while(--t)					/*Percorre un quadrilatero in uno dei 4 diroli*/
		{
                                while(loc_y() <910-z*790) {fire(90);}
                                while(loc_x() >880-k*790) {fire(180);}
                                while(loc_y() >880-z*790) {fire(270);}
                                while(loc_x() <910-k*790) {fire(0);}
                                drive (0,0);
		}

		while ((anni+=20)<390) last+=(scan(anni,10)>0);

		while(last<12)					/*Attacco finale: un altro quadrato*/
		{
                                while(loc_y() <510) {fireII(90);}
                                while(loc_x() >490) {fireII(180);}
                                while(loc_y() >490) {fireII(270);}
                                while(loc_x() <510) {fireII(0);}
		}
	}
}

fire(dor)
int dor;
{
  drive (dor,100);
  if((r=scan(a,10))&&(r<770)) cannon (a,r);
  else
    if((scan(a+=339,10)));
    else
      if((scan(a+=42,10)));
      else
      return (a+=40);
}

fireII(dor)
int dor;
{
  drive (dor,100);
  if(r=scan(oa=a,10)) 
  {
	if (scan(a+=5,5));else a-=10;
	if (scan(a+=3,3));else a-=6;
	cannon (2*a-oa,2*scan(a,10)-r);
  }
  else
    if((r=scan(a+=339,10))) cannon (a,r);
    else
      if((r=scan(a+=42,10))) cannon (a,r);
      else
      return (a+=40);
}

