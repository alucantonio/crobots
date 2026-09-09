/*

	---------------------------------------
	***** * *****   **   *     *****   **
	   *  * *   *  *  *  *     *      *  *
	  *   * *   *  ****  *     ***    ****
	 *    * *   * *    * *     *     *    *
	***** * ***** *    * ***** *     *    *
	---------------------------------------

	Zioalfa 30/03/00
        di Giovanni Calderone


	Strategia:
	Zioalfa si accosta (o quasi...) alla parete Sud,
        poi comincia ad oscillare da destra a sinistra
	sparando in maniera molto vaga se vede qualcuno.
	
	Mi scuso per le davvero poche parole spese per
	commentare questo robot, per non parlare del 
	codice...... (che comunque reputo piu' che 
	leggibile).
	 
*/


int deg,dis;

main() {

while (loc_y()>150) { drive(270,100); }
drive(0,0);


Oscilla();

}




Oscilla() {

while(1) {
drive(0,100);
while(loc_x()<700) { HotDog(); }

drive(180,100);
while(loc_x()>300) { HotDog(); }

}

}



HotDog() {
while(1){
if (loc_x()>800 | loc_x()<200) Oscilla();
deg+=20;
if (deg>200 && deg<240) deg=349;
if (scan(deg,20)) BananaSplit();
}
}





BananaSplit() {

if(scan(deg-5,1)) deg-=5;
if(scan(deg+5,1)) deg+=5;
if(scan(deg-3,1)) deg-=3;
if(scan(deg+3,1)) deg+=3;
if(dis=scan(deg-1,1)) {deg-=1; cannon(deg,dis);}
if(dis=scan(deg+1,1)) {deg+=1; cannon(deg,dis);}

Oscilla();

}




