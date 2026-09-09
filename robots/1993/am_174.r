/*************************************************************************/
/**   NOME ROBOT: AM_174             ** AM_174   si muove roteando      **/
/**   DATA      : 01 - 09 - 1993     ** sul   recinto  del    campo di  **/
/**   AUTORE    : Igor Infante       ** battaglia, e durante il cammino **/
/**                                  ** spara.   La   funzione   di     **/
/**               (Cadetto AM)       ** sparo, fuoco1(),  è utilizzata  **/
/**                                  ** durante tale roteazione. Nel    **/
/**                                  ** caso in cui i nemici si riducano**/
/**                                  ** a uno solo, AM_174 lo insegue   **/
/**                                  ** sparando con il fuoco2()        **/
/*************************************************************************/

int Ang,Num_Rob,Num_Giri, Radar;
int Old_Range,Old_Ang,Dir,Range,Jump;
main()
{
	Ang=-19;  
	drive(270,100);  /* Posizionamento iniziale */
	Dir=270;
	Num_Rob=0;
	while(1)        /* Ciclo principale */
	{
		if((Dir==90 && loc_y()>870) || (Dir==270 && loc_y()<130)
		|| (Dir==360 && loc_x()>900) || (Dir==180 && loc_x()<100))
		{   
			drive(Dir+=90,0);
			while(speed()>48);
			drive(Dir,100);
			if(Dir==450)
			{
				Dir=90;
				Radar=70;
				while(Radar<280) 
					Num_Rob+=(scan(Radar+=19,10)!=0);
				if(Num_Rob<2) Attacca();
				Num_Giri=0;
				Num_Rob=0;
			}
		}
		if(speed()<50) drive(Dir,100); /* Se si ferma si riavvia */
		fuoco1();     
	}
}

Attacca()       /* attacco dinamico */
{
	Range=0;
	Jump=50;
 
	while(1)
	{
		Ang+=344;  
		while(! Range)
		{
			if (Range=scan(Ang,8)) /* Se trova un nemico... */
			{
				cannon(Ang,Range); /* ...lo spara... */
				drive(Dir=Ang,100); /* ... e lo insegue */
				fuoco2();
				Range=0;  
				Ang=Dir+155*(Old_Range<200);  
			}
			else Ang+=14; 
		}
	}
}

fuoco1()
{
	if(Range && Range<701)  /* Sparo statico */
	{
		Ang+=5-(scan(Ang-5,5) != 0)*10;  
		Ang+=3-(scan(Ang-3,3) != 0)*6;
		Old_Range=Range;  
		if ((Range=scan(Ang,10))>40)  
			cannon(Ang,Range+(Range-Old_Range+cos(Ang-Dir)/2000)*Range/325);
		else cannon(Ang,50); 
	}
	else
		if (!(Range=scan(Ang=Dir-10,10)))    
			if(!(Range=scan(Ang=Dir+190,10)))  
				Range=scan(Ang=rand(180)+Dir,10); 
}

fuoco2()
{
	while (Range && Range<700)  /* Sparo dinamico */
	{
		Old_Ang=Ang; 
		Old_Range=Range; 
		Ang+=4-(scan(Ang-4,4) != 0)*8; 
		Ang+=2-(scan(Ang-2,2) != 0)*4;
		if ((Range=scan(Ang,10))>150) 
		{          
			Ang+=1-(scan(Ang-1,1) != 0)*2; 
			cannon(Ang+(Ang-Old_Ang)*Range/200,Range+(Range-Old_Range+Jump)*Range/275);
		}
		else 
		{  
			if (Range<60 && Range) Range=60;  
			if (Range) cannon(Ang,Range);   
		}
		if (speed()<51 || (Ang-Dir)*(Ang-Dir)>400)
		{
			drive(Ang,100);
			Dir=Ang;
			Jump=25;   
		}
		else Jump=50;
	}
}

