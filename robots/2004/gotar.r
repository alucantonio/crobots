/*

        רררררר  רררררר  ררררררר  רררררר  רררררר
        ר       ר    ר     ר     ר    ר  ר    ר
        ר  ררר  ר    ר     ר     רררררר  רררררר
        ר    ר  ר    ר     ר     ר    ר  ר  ר
        רררררר  רררררר     ר     ר    ר  ר   ר



        Autori:      Alessio Gosmar
                     Alessandro Savoiardo

        Robot:       Gotar

        Anno:        2004

        Categoria:   Micro (226 istruzioni)

        Commenti:    Presenti al torneo 2k4 con: ~ Gotar
                                                 ~ Rotar
                                                 ~ Gotar2
*/
int p, r, dir, v, ogr, gr;

main()
{
/* Si muove al centro dell'arena ed esegue un piccolo quadrato,
   + grande se ci sono crobots nelle vicinanze. */
  while(1)
  {
    while (loc_x()<500+p) Fuoco(0,100);
    Fuoco(90,0);  
    while (loc_y()<500) Fuoco(90,100);
    Fuoco(180,0); 
    while (loc_x()>499) Fuoco(180,100);
    Fuoco(270,0);     
    while (loc_y()>499) Fuoco(270,100);
    Fuoco(0,0*(p=350*(r<250))); 
  }
}
/* Routine di Fuoco (e spostamento). */
Fuoco(dir,v)
{
  drive(dir,v);
  if (r=scan(ogr=gr,10))  
  {    
    if (scan(gr+350,10)) gr-=5; else gr+=5;
    if (scan(gr+10,10)) gr+=3; else gr-=3; 
    cannon(gr+(gr-ogr),(scan(gr,10)<<1)-r);
  }
  else
  {
    if (r=scan(gr+=340,10)) return cannon(gr,r); 
    if (r=scan(gr+=40,10)) return cannon(gr,r);  
    while (!(r=scan(gr+=20,10))) ; 
    cannon(gr,r);
  }
}