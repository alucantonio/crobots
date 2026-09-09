/*
Robot programmato da Roberto Bevilacqua

Si tratta di un microbo basato su Regis dello scorso torneo.
E' il primo tentativo, quindi nulla di originale o innovativo.
Probabilmente è persino meno forte di Regis.
*/
int deg,rng,odeg,t,xs,ys,en,timer,sc1,sc2,ff,f;

main()
{
  xs=loc_x(ys=(loc_y(en=3))>499)>499;
  
  while(en>1) {
    if (xs) {
      while (loc_x()>900) Misura_stanza(180); 
      while (loc_x()<936) Misura_stanza(); Stop(180);
    } else {
      while (loc_x()<100) Misura_stanza(); 
      while (loc_x()>64) Misura_stanza(180); Stop(0);
    } 
    if (ys) {
      while (loc_y()>900) Misura_stanza(270);
      while (loc_y()<936) Misura_stanza(90); Stop(270);
    } else {
      while (loc_y()<100) Misura_stanza(90);
      while (loc_y()>64) Misura_stanza(270); Stop(90);
    }
    en=Radar();
  }

 while(1) {
      while (loc_x()<500) Esenzione();
      while (loc_y()<500) Esenzione(90);
      while (loc_x()>500) Esenzione(180);
      while (loc_y()>500) Esenzione(270);
  }


}


Aliquota()
{
  if ((rng=scan(odeg=deg,10))&&(rng<850))
  {    
    if (scan(deg+354,6)) deg-=3; else deg+=3;
    if (scan(deg+358,2)) deg-=2; else deg+=2; 
    return cannon(deg,(scan(deg,10)<<1)-rng); 
  } 
  if (rng=scan(deg+=340,10)) return cannon(deg,rng);
  if (rng=scan(deg+=40,10))  return cannon(deg,rng);
  if (rng=scan(f+=90,10)) return cannon(deg=f,rng);
  return deg+=40;  
}

Esenzione(la)
{
	drive(la,100);
  if (rng=scan(odeg=deg,10))
  {    
    if (scan(deg+350,10)) deg-=5; else deg+=5;
    if (scan(deg+357,3)) deg-=3; else deg+=3; 
    return cannon(deg+(deg-odeg),(scan(deg,10)<<1)-rng); 
  } 
  if (rng=scan(deg+=340,10)) return;
  if (rng=scan(deg+=40,10))  return;
  return deg+=40;  
}
Radar() 
int ren,rd;
{
  while(rd<380) ren+=(scan(rd+=20,10)>0);
  return ren;
}

Stop(d) { 
  Aliquota(drive(d,0));
}

Misura_stanza(rosso) { Aliquota(drive(rosso,100)); }





