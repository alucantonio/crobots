/*
torneo di Crobots2k3
 
nome robot: VALeVAN 
categoria : fino a 500 istruzioni
autore    : BARDELOTTO VALENTINO
*/


int c;                        /* variabili di main      */
int a,b,ango;                 /* variabili di difendi() */
int r,r0,r1,r2,r4,r8,rx;      /* variabili di difendi() */
int range,k,rk,indrk;         /* variabili di D3()      */

main()
{
 c=0;
 if (loc_x()>500) {while(loc_x()<950) drive(0,100); c+=90;}
 else {while(loc_x()>50)  drive(180,100);}
 while(speed(drive(0,0))>50);
 if (loc_y()>500) {while(loc_y()<950) drive(90,100); if (c==0) c=270; else c=180;}
 else {while(loc_y()>50)  drive(270,100);}
 while(speed(drive(0,0))>50);
 
 while(1) 
 {
   /* e' prevista solo la difesa della propria posizione        */
   difendi(c);
 }

}

difendi(a)
{
 b=-10;
 /* variabili di comodo per impostare un massimo virtuale       */
 rx=9999;
 ango=9999;
 /* effettua lo scan (90 gradi) e rileva il crob piu' vicino    */
 while((b+=16)<90)
 {
  if (r=scan(a+b,8)) 
  {
   /* il crob e' piu' vicino del precedente?                    */
   if (r<rx) 
   {
    /* salva la distanza e l'angolo del crob piu' vicino        */
    rx=r; 
    ango=a+b;
   }
  }
 }

 /* se e' stato rilevato un crob                                */
 if (ango!=9999)
 {
  /* effettua scansioni successive riducendo l'ampiezza         */
  /* dell'angolo e salvando la distanza misurata                */
  if (r8=scan(ango,8)){
   if (r4=scan(ango+=4,4)){
    if (r2=scan(ango+=2,2)){
    /* al termine delle 4 scansioni posso chiamare              */
    /* la routine di fuoco, passando i dati necessari           */
     if (r1=scan(ango+=1,1)) {D3(80,r1,3);}
     else {ango-=2; D3(80,r2,2);}}
    else {
     if (r1=scan(ango-=3,1)) {D3(80,r1,3);}
     else {ango-=2; D3(80,r4,1);}}}
   else {
    if (r2=scan(ango-=6,2)) {
     if (r1=scan(ango+=1,1)) {D3(80,r1,3);}
     else {ango-=2; D3(80,r2,2);}}
    else {
     if (r1=scan(ango-=3,1)) {D3(80,r1,3);}
     else { r0=scan(ango-=2,1); D3(90,r0,4);}}}} 
 cannon(ango,range);
 }
}

/* calcolo della distanza a cui sparare                         */
D3(k,rk,indrk)
{
 range=33*((((10*indrk)-k)*r8)+(k*rk))/(((33*indrk)+r8-rk)*10);
} 