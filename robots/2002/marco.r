/*
CROBOT  : Marco
Versione: 0.0
Autori  : Marco Pranzo e Luca Pranzo

(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)
 /_\  /_\  /_\  /_\  /_\  /_\  /_\  /_\  /_\  /_\ 

M. Mi ha scritto una mail Alessandro Carlin.
L. Chi?
M. Un veterano dei CRobots, e voleva sapere se facevamo in tempo a partecipare con un robot.
L. Tempo? E chi ha tempo?
M. Già.
<pausa>
M. Beh potremmo fare un robot scarso...
L. Eheheh quella è la nostra specialtà!
M. ...ma in fondo quello che tutti vogliono è robot scarso e scheda tecnica divertente.
L. Vero, e non sono difficili da realizzare.
<breve pausa>
L. Ehi ma questo registatore è acceso! Perchè?
<M. sogghigna>
M. Abbiamo cominciato la scheda tecnica!

<M. e L. davanti al computer>
L. Inutile non funziona, non faremo mai in tempo.
M. Idea! Possiamo partecipare al torneo dei mini robot, dovrebbero essere più facili da realizzare.
L. Vero. Potremmo prendere le routine di Arale....
<pausa>
L. Niente da fare, fa schifo, comunque...
M. Facciamoci venire una idea sulla strategia.
L. Te che cosa faresti se fossi in una arena con altri tre robot corrazzati, pompati con mesi di calcoli e allenamenti...
M. Mhhh, beh me ne andrei al mio angolo, senza stare mai fermo e sparando precisamente ai nemici, e se posso potrei scappare ad un altro angolo.
L. Bravo, ma abbiamo poche istruzioni! Elimina qualche cosa.
M. Attacco o difesa?
L. Ti ripeto la situazione. ...arena... ...tre robot corrazzati... ...pompati con mesi di calcoli e allenamenti...
M. Difesa! Mi metteri a correre senza fermarmi mai, sparando mentre corro. 
L. Cominciamo a fare passi avanti.
M. E poi cercherei di muovermi nel mio angolo, senza sbattere al muro. 
L. Vai avanti...
M. E poi, se ancora non sono morto e se non sono troppo ferito, potrei correre nel centro dell'arena, magari se sono fortunato qualche partita la vinco...
L. Io non ci conterei troppo...

<L. e M. davanti all'arena del torneo>
<Luca ha un invoulcro coperto>
M. Finito il robot?
L. Certo! Sta qui sotto.
M. Bene, bene sono curioso, come si chiama?
L. Marco.
M. ?!
L. Emozionato?
M. Un pochino.
L. Ci credo devi entrare nell'arena!
M. Che?!?
<L. Scopre l'involucro>
L. Tieni! Ecco la tua armatura di cartoncino e la tua pistola ad acqua, entra nell'arena!!!



Scheda Tecnica: 
Descrive un quadrato nell'angolo più vicino (come Carletto), e per il resto è Arale.
Insomma niente di nuovo o di innovativo!
*/


int qy, qx, t, ang, d;
main()
{
  qy=loc_y(qx=loc_x()<500)<500;
  t = 80;
  while ((t-=1)||(damage()>80))
  {
    while(loc_y() < 910-qy*790) {fire( 90);} stop(270);
    while(loc_x() > 880-qx*790) {fire(180);} stop(360);
    while(loc_y() > 880-qy*790) {fire(270);} stop( 90);
    while(loc_x() < 910-qx*790) {fire(360);} stop(180);
  }
  
  if (qy) {while(loc_y() < 480) {fire(90);} stop(270);}
  else {while(loc_y() > 520) {fire(270);} stop( 90);}

  while(1)
  {
    drive(  0,100); while (loc_x() < 900 ) if (scan(ang,10)) 
      cannon(ang+=7*(!(scan(ang+356,7)))+353*(!(scan(ang+4,7))),scan(ang,10));
                                         else ang+=21;
    stop(180);
    drive(180,100); while (loc_x() > 100 ) if (scan(ang,10)) 
       cannon(ang+=7*(!(scan(ang+356,7)))+353*(!(scan(ang+4,7))),scan(ang,10));
                                         else ang+=21;
    stop(0);
  }
}

stop(dir)
{
  drive(dir,0);
  while (speed() > 49) if ((d=scan(ang,10))) cannon(ang,d); 
                       else ang+=21;
}

fire(dir)
{
  drive(dir,100);
  if ( (d=scan(ang,10)) && (d<770) ) 
  { 
   if (d=scan(ang+353,3)) cannon(ang+=353,d);
   else if (d=scan(ang,3)) cannon(ang,d);
   else if (d=scan(ang+7,3)) cannon(ang+=7,d); 
  }
  else
  {
   if ((d=scan(ang+21,10))&&(d<700)) {ang+=21;cannon(ang,d);}
   else if ((d=scan(ang+42,10))&&(d<700)) ang+=42;
        else ang+=63;
  }  
}

/*(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)(\o/)*/
/* /_\  /_\  /_\  /_\  /_\  /_\  /_\  /_\  /_\  /_\ */

