/*
	ROBOT2.R
	By Andrea Roncoroni
*/

/*
La strategia de robot e' molto semplice:
Il robot scanna l' area circostante fino a quando non trova un altro robot da
colpire. Quando lo trova cerca di seguirlo dirigendosi verso di lui (al massimo,
se il bersaglio e' fermo rimane circa alla distanza di 250 untia') , sparando
in continuazione.
*/

main()
{
int grad,range;

grad=0;
while(1)
	{
	while(range=scan(grad,5))
		{
		if (range<700)
			{
			cannon(grad,range);
			cannon(grad+2,range);
			cannon(grad-2,range);
			}
		if(range>250)
			drive(grad,100);
		else
			drive(grad-180,100);
		}
		grad+=10;
	}
}
