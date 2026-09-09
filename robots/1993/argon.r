/* ------------------------------------------------------------ */
/*  Robot:           Argon                                      */
/*  Ultima release:  30/09/93                                   */
/*  Autore:          Massimiliano Tretene                       */
/* ------------------------------------------------------------ */


int Deg, Range, ORange, dam;

main()
{   
  Deg = 270; ORange = 100; dam = 0;

  drive (180,100);                  /* Direzione OVEST */
  while (loc_x() > 60) shoot();    
  drive (270,0);                                                 
  while (speed() > 49)  shoot();
 
  drive (270,100);                  /* Direzione SUD */
  while (loc_y() > 60) shoot();    
  drive (45,0);                                                 
  while (speed() > 49)  shoot();


  while (1) {
    drive (45,100); dam = damage();        /* Direzione NORD-EST */
    while ( (loc_y() < 940) && (damage() < dam+15) ) shoot();         
    drive (225,0);                        
    while (speed() > 49)  shoot();        
	
    drive (225,100); dam = damage();       /* Direzione SUD-OVEST */            
    while ( (loc_y() > 60)  && (damage() < dam+15) ) shoot();      
    drive (45,0);                        
    while (speed() > 49)  shoot();      
  }
}

shoot ()
{
  if (Range = scan (Deg, 8)) {  
    if (Range < 50) cannon ( Deg, 50 );
    else if (Range > ORange) cannon ( Deg, 8*Range/7 );
         else                cannon ( Deg, 7*Range/8 );    
  }
  else {
    Deg -= 40;                            
    while (!(Range = scan (Deg += 15, 8))); 
    if (Range < 50) cannon ( Deg, 50 );
    else if (Range > ORange) cannon ( Deg, 8*Range/7 );
         else                cannon ( Deg, 7*Range/8 );    
   
  }                                                        
  ORange = Range;
}
