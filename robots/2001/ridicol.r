/*

Autore : Antonio Patalano.
Nome robot: Ridicol.r
Tipo Robot: Micro.


Questo è il primo robot creato, si limita a oscillare a 45 gradi, 
facendo uno scan e sparando al primo che si trova davanti.
Queste sue peculiarita' gli hanno destinato il nome di Ridicol.r

*/

int distanza,angolo,fine,x,y;

main()
{
        drive(0,100);
        t();
}


t()
{
while(1)
{
  while (distanza==0)
  {
        distanza=scan(angolo,10);
        angolo=angolo+20;
  }
  distanza=0;
  angolo=angolo-30;
  fine=angolo+21;
  while ((angolo!=fine) && (distanza==0))
  {
        distanza=scan(angolo,0);
        angolo=angolo+3;
  }
    if (distanza>50)
  cannon(angolo-1,distanza);
  x=loc_x();
  y=loc_y();  
  if((x>=550)||(y>=550)) drive(225,90);
  if((x<=350)||(y<=300)) drive(45,80);
  
  

}
}



