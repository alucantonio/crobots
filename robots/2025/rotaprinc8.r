/*    
ROBOT CHE HA VINTO LEDIZIONE DI CROBOTS 24/25 ALLA SCUOLA MOLINARI AFFRONTANDO 
60 AVVERSARSI MA QUESTO PRINCIPE NON SI ARRENDERA COSI FACILMENTE NEANCHE ORA.



Questo è rotaprinc. Ora è un piccolo principino, ma lanno prossimo diventerà il RE dellarena!
Rotaprinc entra nellarena dando unocchiata alla sua posizione e regolando il movimento per sistemarsi 
in un angolo comodo.
Poi, con  il radar individua  cosa cè intorno e inizia a muoversi, 
sparare e adattarsi continuamente alla situazione. Se subisce qualche colpo 
o trova pochi nemici, cambia direzione per cercare la posizione migliore per attaccare e difendersi.

 */             


int rng/*distanzaBersaglio*/, orng/*distanzaOggetto*/, angolo, odeg/*angoloPrecedente*/, dir, dam/*danno*/, avv, timer, angoloAggiustato, portataAggiustata;

main() {
    /* Se il robot è troppo a sinistra, lo facciamo andare a destra, altrimenti va a sinistra */
    if (loc_x() < 500) move_left(100); else move_right(900);
     /* Se il robot è troppo in basso, lo facciamo salire, altrimenti scende */
    if (loc_y() < 500) move_down(100); else move_up(900);
    /* chiamiamo la funzione  radar per vedere cosa cè intorno */
    Radar();
    timer = 170000;
    /* questo ciclo gestice gli angoli e decidere cosa fare */
    while (1) {
        process_angle();
    }
}
/* Muove il robot verso lalto */
move_up(d) {
    dir = 90;
    while (loc_y() < d) { 
        drive(90, 100); 
        Fire(); 
    }
    stop();
}
/*  il robot si muove verso il basso   */
move_down(d) {
    dir = 270;
    while (loc_y() > d) { 
        drive(270, 100); 
        Fire(); 
    }
    stop();
}
/* Muove il robot verso destra*/
move_right(d) {
    dir = 0;
    while (loc_x() < d) { 
        drive(0, 100); 
        Fire(); 
    }
    stop();
}
/*  il robot si muove verso sinistra */
move_left(d) {
    dir = 180;
    while (loc_x() > d) { 
        drive(180, 100); 
        Fire(); 
    }
    stop();
}
/* Elabora langolo e decide cosa fare in base ai danni e alla situazione.
   Se il danno è troppo alto, il robot cerca di spostarsi per cambiare posizione. */
process_angle() {
    dam = damage();
    while ((!orng || orng > 740) && (damage() < dam + 4)) {
        dam = damage();
        Fire();
        timer -= 190;
        if (timer < 0) {
            Radar();     
            if (damage() < 50) {
                if (loc_x() < 500) { 
                    move_right(420); 
                    move_left(100); 
                } else { 
                    move_left(580); 
                    move_right(900); 
                }
            }
            if (avv == 2) timer = 2000; else timer = 10000;
        }
    }
    /* Se laltezza  è troppo bassa, vuol dire che il robot è troppo in basso.
       quindi introduciamo un  movimento strategico per spostarlo in una posizione migliore,
       così da avere un angolo migliore per attaccare e non rimanere troppo esposto ai nemici. */
    if (loc_y() < 500) {
        if (Look(90)) 
            move_up(280); /* Se non ci sono ostacoli, il robot si muove verso lalto */
        else { 
            move_up(880); 
            timer -= 2000; 
            return; 
        }
        /* Se incontriamo degli ostacoli, il robot si dirige verso il basso */
        if (Look(90)) {
            if (Look(270)) { 
                perform_move(); /* Chiamiamo la funzione perform_move 
                                per eseguire il movimento strategico */
                return; 
            } else move_down(120);
        } else move_up(880);
    } else {
        if (Look(270)) 
            move_down(720); /* Se non ci sono ostacoli, il robot va giù */
        else { 
            move_down(120); 
            timer -= 2000; 
            return; 
        }
        /* Se ci sono ostacoli, il robot sale */
        if (Look(270)) {
            if (Look(90)) { 
                perform_move(); 
                return; 
            } else move_up(880);
        } else move_down(120);
    }
    timer -= 2000;
}
/* Questa funzione esegue un movimento strategico.
 cioè Se il robot è a sinistra, si sposta a destra, se è a destra si sposta a sinistra. */
perform_move() {
    if (loc_x() < 500) 
        move_right(900); 
    else 
        move_left(100); 
    timer -= 3000;
}
/* Scansiona larena con il radar per vedere se ci sono dei nemici */
Radar() {
    angolo = 330; 
    avv = 0;
    /* Scansione del radar a intervalli di 20 gradi */
    while ((angolo+= 20) != 710) {
        if (scan(angolo, 10)) 
            ++avv;/* se troviamo un nemico aumentiamo la variabile avv che indica il numero di avversari*/
    }
    /* Se ci sono meno di 2 nemici, il robot fa un attacco */
    if (avv < 2) {
        if (damage() < 80) 
            attack();
    }
}
/* Esegue un attacco combinando movimenti su e giù . 
   Se il danno aumenta, cambia rapidamente posizione per confondere il nemico. */
attack() {
    move_up(450); 
    move_down(550);
    dam = damage();
    while (damage() <= dam + 20) {
        dam = damage();
        move_right(850);
        move_left(150);
    }
    while (1) {
        move_right(650);
        move_left(350);
    }
}
/* Scansiona larea intorno al robot a sinistra e a destra dellangolo specificato. */
Look(d) { 
    return scan(d - 10, 10) + scan(d + 10, 10); 
}
/* Funzione di scansione avanzata che esplora diverse angolazioni per ottenere
   una visuale più dettagliata dellarena. */
scan_advanced() {
    if (scan(angolo + 353, 1)) angolo+= 353;
    if (scan(angolo+ 7, 1)) angolo += 7;
    if (scan(angolo+ 355, 1)) angolo += 355;
    if (scan(angolo+ 5, 1)) angolo += 5;
    if (scan(angolo+ 357, 1)) angolo += 357;
    if (scan(angolo+ 3, 1)) angolo+= 3;
}
/* Scansione a basso raggio per cercare nemici vicini. 
   Il robot prova a colpire i bersagli trovati in diverse angolazioni. */
scan_low() {
    if (orng = scan(angolo + 340, 10)) 
        cannon(angolo += 340, (scan(angolo, 10) << 1) - orng);
    else if (orng = scan(angolo+ 20, 10)) 
        cannon(angolo += 20, (scan(angolo, 10) << 1) - orng);
    else if (orng = scan(angolo + 320, 10)) 
        cannon(angolo += 320, (scan(angolo, 10) << 1) - orng);
    else if (orng = scan(angolo + 40, 10)) 
        cannon(angolo += 40, (scan(angolo, 10) << 1) - orng);
    else if (orng = scan(angolo+ 300, 10)) 
        cannon(angolo += 300, orng);
    else if (orng = scan(angolo + 60, 10)) 
        cannon(angolo += 60, orng);
    else angolo += 140;
}
/* Funzione che fa sparare il cannone prendendo in considerazione angolo e distanza.
   Calcola la traiettoria e la velocità del colpo per colpire il bersaglio. */
Fire() {
    if (!scan(angolo, 7)) 
        if (!scan(angolo+= 345, 7)) 
            if (!scan(angolo += 30, 7)) { 
                scan_low(); 
                return; 
            }
    scan_advanced();
    /* Se il bersaglio è entro la portata, calcoliamo langolo e la distanza per sparare */
    if ((orng = scan(angolo, 7)) && (orng < 755)) {
        odeg = angolo;
        scan_advanced();
        if (rng = scan(angolo, 10)) {
            if (speed()) {
                 angoloAggiustato = (angolo + (angolo - odeg) * ((1200 + rng) >> 9) - (sin(angolo - dir) >> 14));
                 portataAggiustata= (rng * 160 / (160 + orng - rng - (cos(angolo - dir) >> 12)));
            } else {
                 angoloAggiustato = (angolo + (angolo - odeg) * ((1200 + rng) >> 9));
                portataAggiustata = (rng * 165 / (165 + orng - rng));
            }
            while (!cannon( angoloAggiustato, portataAggiustata));
        } else scan_low();/* Se il bersaglio non è raggiungibile, si fa una scansione per cercare nemici vicini */
    } else scan_low();/* anche in questo caso Se il bersaglio è fuori portata, si fa una scansione per cercare nemici vicini */
}
/* Ferma il movimento del robot. */
stop() {
    drive(dir, 0);
}
