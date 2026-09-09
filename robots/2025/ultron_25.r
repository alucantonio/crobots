/*

Torneo 2025
Nome:ultron_25.r(499 istruzioni - midi)
Autore:Franco Cartieri

Descrizione robot:
Non avendo più idee, ho chiesto aiuto all'I.A., che ha generato questo robot.
Io ho effettuato i test e proposto modifiche in base ai risultati ottenuti.
Potrebbe essere una rivoluzione o un flop incredibile.

*/

/* === Stato Globale === */
int angle, oangle, range;							 /* Per il cannone: angolo di scansione, angolo precedente (per predizione), distanza rilevata */
int dir, change, dam, heading, posx, posy, xy, turn; /* Per il movimento: direzione attuale, cambio angolo (90/270), danno base, orientamento (0-3), posizioni d'angolo (x>500/y>500), coordinata da controllare (X o Y), contatore/limite di svolta */
int x, y, ang, ne, b;								 /* Variabili per la scansione iniziale e la seconda fase: coordinate attuali, angolo di scansione iniziale, contatore nemici, flag binario (per alternanza) */

/* === Funzione FONDAMENTALE di Fuoco e Movimento === */
/* Implementa la routine di scansione affinata e la formula predittiva (ang*2 - oang) */
/* Questa funzione presuppone l'esistenza delle funzioni: drive(dir, vel), scan(angle, width), cannon(angle, range). */
int fire_and_drive(d, v)
{
	/* 0. Movimento: imposta la direzione e velocità */
	drive(d, v);

	/* 1. Scansione Iniziale: esegue la scan principale e assegna il risultato (distanza) a 'range'. */
	/* L'angolo vecchio (oangle) è salvato prima dell'aggiornamento. */
	if (range = scan(oangle = angle, 10))
	{
		/* 2. Affinamento dell'angolo (ottimizzato e granulare) */
		/* Cerca l'angolo più preciso con larghezza di scansione ridotta */
		if (scan(angle - 8, 5))
		{
			/* Bersaglio a sinistra, affina a sinistra con due passi per massima precisione */
			if (scan(angle -= 5, 2))
				; /* Se rileva a -5, è l'angolo finale */
			else
				angle -= 4;
			/* Altrimenti, è leggermente a destra di -5 (quindi -4) */
		}
		else if (scan(angle + 8, 5))
		{
			/* Bersaglio a destra, affina a destra con due passi */
			if (scan(angle += 5, 2))
				; /* Se rileva a +5, è l'angolo finale */
			else
				angle += 4;
			/* Altrimenti, è leggermente a sinistra di +5 (quindi +4) */
		}
		else
		{
			/* Bersaglio centrale o molto lontano, cerca attorno al centro (tre passi) */
			if (scan(angle, 1))
				;
			else if (scan(angle -= 3, 2))
				; /* Prova un piccolo spostamento a sinistra */
			else
				angle += 6;
			/* Se fallisce, sposta a destra (totale +3) */
		}

		/* 3. Predizione Balistica: Angolo = (2 * Angolo Finale) - Angolo Iniziale */
		/* Distanza = (2 * Range Finale) - Range Iniziale (aggiornato da scan(angle, 10)) */
		return (cannon((angle << 1) - oangle, (scan(angle, 10) << 1) - range));
	}
	else
	{
		/* 4. Scansione a ricerca rapida (se il nemico è perso) */
		/* Esegue ampi salti angolari per ritrovare il bersaglio rapidamente */
		if (range = scan(angle += 20, 10))
			cannon(angle, range);
		else if (range = scan(angle -= 40, 10))
			cannon(angle, range);
		else if (range = scan(angle += 60, 10))
			cannon(angle, range);
		else if (range = scan(angle -= 80, 10))
			cannon(angle, range);
		else
			angle += 120; /* Procede nella rotazione di ricerca */
	}
	return 0;
}

/* === Logica di Movimento (Pattugliamento Muri e Reazione) === */
main()
{
	/* PRIMA FASE: SCANSIONE INIZIALE (Cerca nemici per stabilire l'orientamento iniziale) */
	while (ang < 360)
	{
		if (scan(ang += 21, 10)) /* Scansione in circolo per trovare il primo bersaglio */
		{
			if ((++ne) > 1) /* Rileva almeno 2 bersagli per avviare il combattimento (evita match 1-vs-1 in questa fase) */
			{
				/* Inizializzazione della Logica di Pattugliamento (Wall-Hugging) */

				/* Calcolo della posizione iniziale (posx=1 se X>500, posy=1 se Y>500) */
				posy = loc_y(posx = loc_x() > 500) > 500;

				/* Imposta la direzione iniziale (dir) basandosi sull'angolo del quadrante. */
				/* heading = 0 (alto-sinistra), 1 (alto-destra), 2 (basso-destra), 3 (basso-sinistra) */
				dir = 90 * (heading = (posy << 1) | (posx ^ posy));
				change = 90;
				/* Cambiamento di 90 gradi ad ogni angolo */

				/* Inizia il movimento e fuoco */
				fire_and_drive(dir, 100);

				/* SECONDA FASE: LOOP PRINCIPALE DI MOVIMENTO E COMBATTIMENTO */
				while (1)
				{
					dir %= 360; /* Normalizza la direzione */

					/* Determina la coordinata da controllare (X se heading è pari, Y se dispari) e il limite di Turn */
					if (heading & 1)
						xy = loc_y();
					else
						xy = loc_x();
					/* turn = 1 se la coordinata è fuori dal limite (110 o 890), indica che è ora di svoltare */
					if (heading & 2)
						turn = xy < 110;
					else
						turn = xy > 890;

					/* 1. RILEVAMENTO MURO: Esegui STOP-CHANGE-GO (solo se necessario) */
					if (turn)
					{
						fire_and_drive(dir += change, 0);
						/* Gira l'angolo di 90 gradi e frena */
						heading += (change % 360) / 90; /* Aggiorna l'orientamento (0->1, 1->2, ecc.) */
						/* Attesa critica per l'azzeramento della velocità (evita danni da schianto) */
						while (speed() > 49)
							fire_and_drive(dir, 0);
					}

					/* 2. REAZIONE AI DANNI (Evasione immediata) */
					if (damage() > dam + 7)
					{
						fire_and_drive(dir += 180, 0);
						/* Inverte la direzione e frena */
						heading += 2; /* Inverte l'orientamento (es. 0->2, 1->3) */
						/* Attesa per l'azzeramento della velocità prima di ripartire */
						while (speed() > 49)
							;

						/* Controlla se il danno è critico (esce dal loop) e imposta il contatore 'turn' per l'oscillazione */
						if (damage(turn = 10) > 75)
						{
							break; /* Entra nella fase F2F */
						}
						change = 270; /* Imposta un'oscillazione aggressiva temporanea (cambio 270/-90) */
					}
					else if ((--turn) == 0)
					{
						change = 90; /* Resetta l'oscillazione al cambio standard (90 gradi) */
					}

					dam = damage(); /* Aggiorna il danno per il prossimo ciclo */

					/* 3. Movimento Continuo (la maggior parte del tempo) */
					fire_and_drive(dir, 100);
				}
			}
		}
	}

	/* TERZA FASE: F2F (Face-to-Face) / Lotta Disperata */
	while (1)
	{
		/* Logica di evasione: si sposta verso il centro dell'area non-muro e alterna la direzione */
		/* Se è vicino a un muro X (<120 dal bordo, usando modulo 880) */
		if (((x = loc_x(y = loc_y())) % 880) < 120)
			dir = 330 + 180 * (x > 500) + 60 * (y < 500);
		/* Se è vicino a un muro Y (<120 dal bordo) */
		else if ((y % 880) < 120)
			dir = 60 + 180 * (y > 500) + 60 * (x > 500);
		/* Se il nemico è vicino (range<224), punta appena dietro di lui (175 gradi) */
		else if (range < 224)
			dir = angle + 175;
		/* Altrimenti, si muove attorno al bersaglio, alternando il verso di 175 gradi per evasione */
		else
			dir = angle + 175 * (b ^= 1);

		/* Esegue 3 movimenti e fuochi nello stesso ciclo per aumentare la frequenza di fuoco e il momentum */
		fire_and_drive(dir, 100);
		fire_and_drive(dir, 100);
		fire_and_drive(dir, 100);
	}
}
