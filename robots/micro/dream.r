/*************************
 *                       *
 *   D  R  E  A  M . r   *
 *                       *
 *************************

nome in codice: MINI S H O C K

 Michelangelo Messina


	Everything is free...



Dopo aver tenuto Shock a pane e acqua per mesi
il dimagrimento e' stato notevole ma...

NON BASTAVA !

Allora sono passato alle maniere forti:
NON HA PIU' MANGIATO.

Chissa' come mai alla fine e' DECEDUTO.

Forse ho sbagliato qualcosa...

Come disse il saggio:
appena si era tolto il vizio di mangiare, mori'!


*/


int     dam, /*percentuale di danni attuale*/
        pt, /*contatore parziale*/
        pos; /*quadrante attuale*/
        int ang,x;





main()
{
    /* 
       il crobot si muove lungo i bordi, e si ferma in ogni angolo, 
       oscillando lungo gli spigoli, fin quando non e' colpito.
       Se e' colpito si sposta.
       Se rimane un solo nemico lo attacca con un movimento oscillatorio.
    */

    pos=2*(loc_x()>500)+(loc_y()>500);	
    while (1) {
        if (pos&2) xmin(895); 
        else xmag(105); 
	dam=damage()+12;
        while ( damage() < dam ) { /*fino quando non e' colpito o limite di tempo*/
                if (pos&1) {
			ymag(830);
			ymin(915);
                }
                else {

			ymin(170);
			ymag(85);
                }
		drive();
		
		 /* se tutti sono lontani posso star fermo 
		 altrimenti oscillo intorno all'angolo attuale*/ 

                while (spara()) {
                        if(!(++pt%40)) {
			    ang=-10; 
			    while((ang+=20)!=730) x+=(!scan(ang,10));
			    if (x>33) {
				    ymin(450);ymag(550);
				    while(1) {xmin(800); xmag(200); }
			    }
			}
                }
        }

	/* ricerca di un angolo libero */
	++pos;

    }
}


spara()
{ 
        if (!(x=scan(ang, 10)) ) 
        if (!(x=scan(ang-=20,10))) { 
		if (!(x=scan(ang+=40,10))) { 
        		return(ang+=39); 
		}
	} 
        cannon (ang, 2*scan(ang,10)-x ); 
        if((x=x>710)) return(ang+=47); 
        return(0);
} 
  
/* spostamento */
xmag(y) { while(loc_x(m(180))>y); } 
xmin(y) { while(loc_x(m(360))<y); } 
ymag(y) { while(loc_y(m(270))>y); } 
ymin(y) { while(loc_y(m(90))<y); } 

m(dir)
{
     spara(drive(dir,100));
}


/* I had a dream last night */
