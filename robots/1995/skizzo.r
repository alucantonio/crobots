/* NOME DEL ROBOT: SKIZZO */

/* REALIZZATO DA: SANTANTONIO BRUNO */

/* STRATEGIA: IL ROBOT SKIZZO ESEGUE UN MOVIMENTO CHE DESCRIVE UN PICCOLO
   TRIANGOLO A PARTIRE DALL'ANGOLO BASSO A DESTRA MENANDO MAZZATE A TUTTI
   TRAMITE UNA SEMPLICE ROUTINE DI SPARO. QUANDO IL ROBOT SUBISCE UN DANNO
   SUPERIORE AL 75% SI RIPARA NASCONDENDOSI NELL'ANGOLO BASSO A DESTRA,
   CONTINUANDO COMUNQUE A SPARARE, SPERANDO DI ESSERE COLPITO
   IL MENO POSSIBILE */

int    gradi, d;
main()
{
      while (d=damage() <= 75) {   /* CICLO CHE CONTROLLA IL DANNO SUBITO DAL ROBOT */
                while (loc_x() <= 900) {
                        spara();         /* CICLO CHE SPOSTA IL ROBOT A DESTRA */
                        drive(0, 100);
                        spara();
                }
                while (loc_y() >= 150) {
                        spara();         /* CICLO CHE SPOSTA IL ROBOT IN BASSO */
                        drive(270, 100);
                        spara();
                }
                while ((loc_x() >= 220) && (loc_y() <= 450)) {
                        spara();
                        drive(135, 100);  /* CICLO CHE CHIUDE IL TRIANGOLO */
                        spara();
                 }
      }
      VaiInAngolo();
      while (1) spara();
}

spara() /* ROUTINE DI SPARO DEL ROBOT */
{
	int	result;
        if (result = scan(gradi, 10)) {
                cannon(gradi, (7 * result) / 8);
                gradi -= 35;
        } else gradi += 20;
}

VaiInAngolo()  /* ROUTINE CHE SPOSTA IL ROBOT IN BASSO A DESTRA */
{                
  while (loc_y() > 120)
	{
                spara();
                drive(270, 100);
                spara();
	}
  while (loc_y() > 1)
	{
                spara();
                drive(270, 10);
                spara();
         }
  drive(0,0);

  while (loc_x() < 900)
         {
                spara();
                drive(0, 100);
                spara ();
          }
  while (loc_x() < 999)
          {
                 spara();
                 drive(0, 10);
                 spara();
           }
  drive(0,0);
}
