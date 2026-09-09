/* 
Notte del 30 ottobre 2003
MAMMA : " Ma che ci fai ancora li vicino al pc che sono le 2 e domani devi svegliarti alle 6?
Peppe : "sto....(prende tempo)...emmmh...sto studiando...roba di calcolo numerico...non puoi capire"
MAMMA : (scuotendo la testa)...Bah"
Peppe : (tra se e se) ...devo far sparire altre 2 istruzioni...


Nome del robot  : tartaruga.r v2.0
Autore		: Cozzolino Giuseppe


Scheda tecnica:
Se considerate che 6 giorni fa non sapevo nemmeno delll'esistenza di crobots non potrete lamentarvi della scheda tecnica...
del robot invece potete lamentarvi e anche molto :-) fino a 10 minuti fa non sapevo se e quale mandare....tartaruga v 1.0 
faceva una circonferenza per fregare le interpolazioni,ma era troppo lento,questa versione tendenzialmente funziona cosi.

- Vai al angolo nord-est (all'inizio andava al proprio angolo ed era molto piu forte [teoricamente]  
  ma mi veniva 50 istruzioni troppo lungo e ho dovuto tagliare per mancanza di tempo)
- oscilla per un tot di tempo
- torna all'angolo
- ripeti quello sopra fino a che siete rimati in due
- Vai e uccidi :-)

*/

int dir,ang,lunghezza;
int fatto, grado, distanza,y,direzione,rlead; 

main()
{
 if(sei_solo()){
 vai_angolo(flag=t=10);

   while(flag){
      oscilla(lunghezza=50);
      if(!t--) flag=sei_solo(t=10);
   }  
  }
 prova(rlead=50);           
}

vai_angolo(){
if(loc_x() >= 500 && loc_y()>500){ vai(999,999,100); while(loc_x(dir=45)< 950);} /*nord-est*/
else if(loc_x() <= 500){ 
            if(loc_y()>500){ vai(0,999,100);dir=135;} /*nord-ovest*/ 
            else {vai(0,0,100);dir=225;}/*sud-ovest*/
            while(loc_x()>50);
            }
else { vai(999,0,100); while(loc_x(dir=315)< 950);} /*sud-est*/
drive(0,0);
}


vai(xx,yy,vel) 
{ 
drive(dir=180+180*(xx>loc_x())+atan(100000*(loc_y()-yy)/(loc_x()-xx)),vel); 
} 

oscilla(){
drive(180+dir,100);
while(lunghezza--);
drive(dir,0);
while(speed()>50);
vai_angolo();
}


sei_solo(){
while((angolo_nem+=20)<380) nemici+=(scan(angolo_nem,10)>0);
return nemici-1;
}


prova() {
  int x,orange,ox,dir,range;
  drive(180*(loc_x(x=336)>500),100);
  
  
  while(1)
  {
    x+=328;
    while(!(range=scan(x+=16,8)));
    cannon(x,range);
    if(range>200) drive(dir=x,100);
    while (range)  /* && range<700 */
    {
      if (range>200)
      {
        ox=x;
        orange=range;
        x+=4-(scan(x-4,4) != 0)*8;
        x+=2-(scan(x-2,2) != 0)*4;
        x+=1-(scan(x-1,1) != 0)*2;
        if (range=scan(x,10))
          cannon(x+(x-ox)*range/200,range+(range-orange+rlead)*range/275);
        if (speed(rlead=25)<51 || ((x-dir)*(x-dir)>400))
        {
          drive(dir=x,100);
        }
        else rlead=50;
      }
      else
{      x+=20;
while(range<300)
      {
        x+=320;
        while(!(range=scan(x+=20,10)));
        cannon(x,range);
        if(speed()<50 || range>200) drive(dir=x,100);
      } }
    }
  }
}



