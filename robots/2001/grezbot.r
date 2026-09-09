/*
Nome del robot	: Grezbot.r
Tipo Robot		: Micro
Autore		: Antonio Iervolino


Il robot si porta in fondo allo schermo e da li inizia a oscillare e a sparare.
Esegue prima uno scan grossolano , dopo aver trovato il nemico lo spara e cerca di raffinare il tiro
diminuendo l'ampiezza dello scan.


*/


int ang,dist,x,y,trovato,limite,dir;

main()
{
y=loc_y();                      /* in queste prime righe viene imposto al robot */
x=loc_x();				  /* di spostarsi in fondo allo schermo           */
while (y>100)
{
        drive(270,100);
        y=loc_y();
}

drive(270,0);
if (x<500) drive(0,100); else drive(180,100);
while(1)							/* Da qui in poi inizia ad oscillare */
{
        
        dist=scan(ang,8);
        if (dist==0) ang+=15;				/* Se ha trovato il nemico spara */
        else 
        {
        cannon(ang,dist);
        if (dist=scan(ang,2)) cannon(ang,dist);     /* Se è ancora a tiro rispara */
           else if (dist=scan(ang,8)) 		    	
                {
                   ang=ang-10;
                   limite=ang+20;
                   while(ang<=limite)
                   {
                   if (dist=scan(ang,2)) cannon(ang,dist); else ang=ang+4;
                   if (speed()==0) muovi();                
                   }
                }

        }
        muovi();
}

}

muovi()      /* Questo blocco di codice controlla solo se è fermo e lo fa rimettere in movimento */
{
        x=loc_x();      
        if (x<260) dir=0;
        if (x>750) dir=180;
        drive(dir,100);
}
