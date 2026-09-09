/*-------------------------------------------------------------------------- 


   CROBOT:  yoyo.r 
   
   AUTORE:  MARCO BORSARI


 COMPORTAMENTO IDENTICO A JAJA, ESCLUSIVA 
OTTIMIZZAZIONE.


 --------------------------------------------------------------------------*/



int ang,rg,dir,verso,dam,rev; 
int oang,dang,nrg,drg;
int alfa,corr,anco;



/***---                      main()                       ---***/


main()
{
ang=rev=0;
while(!scan(ang,10)) ang+=20;
while(1)
       {
       verso=180;
       while(loc_x()>250) colpire(50);
       dam=damage();
       while(dam==damage()) colpire(90);
       verso=90;
       while(loc_y()<750) colpire(50);
       dam=damage();
       while(dam==damage()) colpire(90);
       verso=0;
       while(loc_x()<750) colpire(50);
       dam=damage();
       while(dam==damage()) colpire(90);
       verso=270;
       while(loc_y()>250) colpire(50);
       dam=damage();
       while(dam==damage()) colpire(90);
       }
}



/***---                      routines                     ---***/


colpire(orza)
int orza;
{
if(rev) dir=verso+orza;
else dir=verso-orza;
while(speed()>40);
fuoco();
drive(dir,40);
rev^=1;
}


/***--- find() - routine di ricerca del bersaglio         ---***/


find()
{
if (nrg=scan(ang,10))
 {  if(scan(ang+6,5))
   {  if(scan(ang+2,2))
      {  if(scan(ang+4,1))
         {  if(scan(ang+3,0))
             ang+=3;
            else
             ang+=4;
         }
         else
            if(scan(ang+2,0))
             ang+=2;
            else
             ang+=1;
      }
      else
      {  if(scan(ang+8,1))
         {  if(scan(ang+7,0))
             ang+=7;
            else
             ang+=9;
         }
      else
         if(scan(ang+6,0))
            ang+=6;
         else
            ang+=5;
      }
   }
   else
   {  if(scan(ang-1,2))
      {  if(scan(ang-3,1))
         {  if(scan(ang-2,0))
             ang-=2;
            else
             ang-=3;
         }
         else
           if(scan(ang-1,0))
            ang-=1;
           else
            /* ang-=0 */;
      }
      else
      {  if(scan(ang-4,1))
         {  if(scan(ang-5,0))
             ang-=5;
            else
             ang-=4;
         }
         else
           if(scan(ang-6,1))
            ang-=6;
           else
            ang-=8;
      }
   }
 return 1;
 }
else
 {  if(nrg=scan(ang+15,5))
   {  if(scan(ang+12,2))
      {  if(scan(ang+14,1))
         {  if(scan(ang+13,0))
             ang+=13;
            else
             ang+=14;
         }
         else
            if(scan(ang+12,0))
             ang+=12;
            else
             ang+=11;
      }
      else
      {  if(scan(ang+18,1))
         {  if(scan(ang+17,0))
             ang+=17;
            else
             ang+=19;
         }
      else
         if(scan(ang+16,0))
            ang+=16;
         else
            ang+=15;
      }
   }
   else
   {  if(nrg=scan(ang-13,2))
      {  if(scan(ang-11,1))
         {  if(scan(ang-11,0))
             ang-=11;
            else
             ang-=12;
         }
         else
           if(scan(ang-13,0))
            ang-=13;
           else
            ang-=14;
      }
      else
      {  if(nrg=scan(ang-17,1))
         {  if(scan(ang-16,0))
             ang-=16;
            else
             ang-=17;
         }
         else
           if(scan(ang-18,1))
            ang-=18;
           else
            return 0;
      }
   }
 return 1;
 }
}


/***--- fuoco() - routine di gestione del tiro            ---***/


fuoco()         
{
drive(dir,100);
if(find())
   {
   spara();
   }
else    
   { 
   ang+=30;
   while(!scan(ang,10)) ang+=20;
   }
}


/***--- spara() - routine di tiro                         ---***/


spara()
{
oang=ang;
if(find())
 {    
 alfa=(ang-dir)%360;
 corr=cos(alfa);
 anco=-sin(alfa);
 dang=ang+(ang-oang)*3+anco/17000;
 if(rg=scan(ang,10)) 
   {
   drg=rg*350/(350+nrg-rg-corr/3000); 
   while(!cannon(dang,drg));
   }
 else   
   {
   drg=nrg;
   cannon(dang,drg);
   }
 }
}
