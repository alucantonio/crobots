/*
 * SGORBIO.R
 * 
 * Sgorbio e' un robot veramente stupido, realizzato all'ultimo 
 * momento per il Torneo 2025. L'autore conosce Crobots da
 * pochi anni e non aveva mai scritto un robot prima d'ora. :P
 *
 *
 * Caratteristiche:
 * - si muove in continuazione a croce nel campo
 * - spara sui nemici rilevati mentre si muove
 *
 *
 * Federico Dal Pio Luogo ~ Torneo 2025
 */

int dir, rng, phi;

go(x,y) {
  int curx, dx, dy;

  dx = (curx=loc_x()) - x;
  dy = (loc_y() - y) * 100000;
  if (x > curx) dir = 360 + atan(dy / dx);
  else dir = 180 + atan(dy / dx);

  drive(dir, 100);
  while(speed() > 0 && dist(loc_x()-x, loc_y()-y) > 500) {
    if ((rng = scan(phi-5, 5)) || (rng = scan(phi+5, 5))) {
      cannon(phi-10, rng);
      cannon(phi+10, rng);
    }
    else phi+=10;
  };
  drive(dir,0);
}

dist(dx, dy) {
  return dx*dx + dy*dy;
}

main() {
  while(1) {
    go(500,500);
    go(900,900);
    go(500,500);
    go(900,100);
    go(500,500);
    go(100,100);
    go(500,500);
    go(100,900);
  }
}
