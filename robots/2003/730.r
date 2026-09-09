/*
Robot programmato da Roberto Bevilacqua

Si tratta di un microbo basato su Regis dello scorso torneo.
E' il secondo tentativo, quindi ho provato un'innesto mirabile con l'attacco di Obelix.... chissà che esce fuori.
*/
int deg,rng,odeg,t,xs,ys,en,timer,sc1,sc2,ff,f,si,or,r,a,oa;

main()
{

  while ((loc_x(ys=(loc_y())>499)%936)>64) Misura_stanza(a=((loc_x()<500)*180)); Stop(a+=180);
  
  while(en!=1) {

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
      while (loc_x(Esenzione())<500);
      while (loc_y(Esenzione(90))<500) ;
      while (loc_x(Esenzione(180))>500) ;
      while (loc_y(Esenzione(270))>500) ;
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

Esenzione(verso)
{
	drive (verso,100);
    if (or=scan(a,10)) {
           if (scan(a,2))		{if (cannon(a+0+0+0+0,3*scan(a,10)-2*or)) return;}
           else if (scan(a-=7,6))	{if (cannon(a-6,2*scan(a,10)-or)) return;}
           else if (scan(a+=14,6))	{if (cannon(a+6,2*scan(a,10)-or)) return;}

    } 
    else {
        if (or=scan(a+=339,10))		return cannon(a,or);
        else if (or=scan(a+=42,10))	return cannon(a,or);
        else {a+=21;}return Esenzione(verso);
    }
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

Misura_stanza(mq) { Aliquota(drive(mq,100)); }





