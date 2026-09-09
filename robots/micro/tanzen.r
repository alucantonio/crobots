/*************************
 *                       *
 *    T A N Z E N .r     *
 *                       *
 *************************


 Michelangelo Messina


	Everything is free...


the_master:
come distruggere un masterizzatore.



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
        if (pos&2) dx(); 
        else sx(); 
        if (pos&1) ymin(915);
        else ymag(85);
        drive();
	dam=damage()+12;
        while ( damage() < dam ) { /*fino quando non e' colpito */

                while (spara()) {
                        if(!(++pt%40)) {
			    ang=-10; 
			    while((ang+=20)!=730) x+=(!scan(ang,10));
			    if (x>33) {
				    ymin(450);ymag(550);
                                    while(1) dx(sx());
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
        if ((x=scan(ang, 10)) ) { 
                if (!scan(ang-=5,5)) ang+=5; 
	}  else if (!(x=scan(ang-=20,10))) { 
		if (!(x=scan(ang+=40,10))) { 
        		return(ang+=39); 
		}
	} 
        cannon (ang, 2*scan(ang,10)-x ); 
        if((x=x>710)) return(ang+=47); 
        return(0);
} 
  
/* spostamento */
sx() { while(loc_x(m(180))>150); } 
dx() { while(loc_x(m(360))<850); } 
ymag(y) { while(loc_y(m(270))>y); } 
ymin(y) { while(loc_y(m(90))<y); } 

m(dir)
{
     spara(drive(dir,100));
}

