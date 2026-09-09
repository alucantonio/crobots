/*
  B4 v2 by Emanuele Marsigliani

  B4b è il bugfix della versione originale (B4)
  presente nel pacchetto dei robot "internazionali".
  Il fatto che la versione originale abbia un bug che lo fa
  schiantare contro i muri mi ha sempre dato
  fastidio, per cui ho voluto porre rimedio: B4b è ...
  B4 come sarebbe dovuto essere in origine.
*/

main()
int x,range,orange,dir,change,dam,heading,posx,posy,xy,turn;
{
posy=loc_y(posx=loc_x()>500)>500;
dir=90*(heading=(posy<<1)|(posx^posy));
drive(dir,100);
change=90;
while(1)
{
dir%=360;

if (heading&1) xy=loc_y();  else xy=loc_x();
if (heading&2) turn=xy<110; else turn=xy>890;

if(turn)
  { drive(dir+=change,0); heading+=(change%360)/90;
    while(speed()>49);
    drive(dir,100);
  }
if(speed()<50) drive(dir,100);
if(damage()>dam+7)
  { drive(dir+=180,0); heading+=2;
    while(speed()>49) dam=damage();
    drive(dir,100);
    change+=180;
   }
if(range && range<701)
  {
   x+=5-(scan(x-5,5) != 0)*10;
   x+=3-(scan(x-3,3) != 0)*6;
   orange=range;
   if ((range=scan(x,10))>40)
 cannon(x,range+(range-orange+cos(x-dir)/2000)*range/325);
		 else cannon(x,50);
    }
 else
if (!(range=scan(x=dir-10,10)))
     if(!(range=scan(x=dir+190,10)))
       range=scan(x=rand(180)+dir,10);
} }

