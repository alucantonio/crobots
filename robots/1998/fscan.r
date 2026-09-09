/*

VIII Torneo di CRobots di MCmicrocomputer (1998)

CRobot: FScan.r

Autore:

Sbragion Denis

-----------------------------------------------------------------------------

La tattica di FScan si basa su alcuni semplici principi, utilizzati del
resto in quasi tutti i CRobot di mia conoscenza:

1) Movimento costante: FScan non e` mai fermo e, per quanto
possibile, viaggia alla velocita` massima.

2) Distanza dal nemico: FScan cerca sempre di mantenere una certa
distanza dal nemico in modo da essere piu` difficle da colpire.

3) Velocita` di tiro: la ricerca del nemico avviene attraverso una
scansione logaritmico/dicotomica ottimizzata per la funzione di
scansione a disposizione, il raggio di azione dei missili e la distanza
della rilevazione.

4) Continuita` di tiro: il cannoneggiamento e` costante, anche quando
FSCan e` in movimento.

Non viene adottata alcuna azione particolare di difesa a parte il
mantenimento della distanza e della velocita`.

FScan e` stato realizzato alcuni anni fa e non e` mai stato impegnato in
un torneo in quanto non sapevo che ne esistessero. Ha quindi il pregio di
non derivare codice da altri CRobots e se c'e` qualche somiglianza posso
assicurare che e` assolutamente casuale. Il suo principale difetto e`
l'assoluta mancanza di cooperazione con altri CRobots identici
eventualmente presenti sul campo di gioco, per cui risulta sicuramente
svantaggiato in competizioni del tipo 2 contro 2. Inoltre non fa
verifiche sulla distanza dalle pareti basandosi sul principio che il
nemico non puo` essere oltre una parete e quindi controllando la
distanza dal nemico si evitano collisioni. Questo principio in qualche
occasione puo` risultare fallimentare, con ovvie conseguenze, ma evita
di introdurre codice che diminuisca le capacita` di fuoco.

Dubito che questo CRobots possa ottenere grandi risultati in quanto e`
piuttosto generico e non sfrutta a fondo le caratteristiche del campo di
gioco e in particolare l'esistenza delle pareti, intrinseca forma di
difesa. Essendo pero` del tutto originale spero che almeno possa offrire
qualche spunto per sviluppi futuri.

*/
  
int Angle;
int Range;
int Head;

main()
  {
    drive(Angle = Head = rand(360),100);
    while(1)
      {
        FastScan();
        if (Range > 40)
          if (Range <= 700)
            {
              while(!cannon(Angle,scan(Angle,10)));
              if (Range > 150 + 3 * damage())
                MoveFwd();
              else
                MoveBwd();
            }
          else
            MoveFwd();
        else
          MoveBwd();
      }
  }

MoveFwd()
  {
    int Diff;

    if ((Diff = (Head - Angle)) < 0)
      Diff = -Diff;

    if (Diff > 10 || !speed())
      {
        drive(Head,49);
        while(speed() > 49);
        drive(Head = Angle,100);
      }
  }

MoveBwd()
  {
    int Diff;

    if ((Diff = (Head - 180 - Angle)) < 0)
      Diff = -Diff;

    if (Diff > 10 || !speed())
      {
        drive(Head,49);
        while(speed() > 49);
        drive(Head = 180 + Angle,100);
      }
  }

FastScan()
  {
    int Limit;

    Limit = (Angle -= 40) + 360;
    while (((Angle += 20) < Limit) && (!(Range = scan(Angle,10))));

    if (Range < 140 || Range > 700)
      return;

    Limit = (Angle -= 12) + 20;
    while (((Angle += 4) < Limit) && (!(Range = scan(Angle,2))));
  }

