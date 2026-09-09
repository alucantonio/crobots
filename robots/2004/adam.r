/*ADAM*/
/*created by [MAIONE MIKY]*/
/*Maione Michele*/


int ABSAng; /* angolo del livello dove devo andare */


main(){

  int i; /*i gradi*/
  int r; /*r=scan*/
  int found=0;/*ho found nemico*/
  int imin;/*i gradi minimi*/
  int imax;/*i gradi massimi*/
  int resol;/*risoluzione dello scan*/

  resol=1;/*risoluzione dello scan migliore*/

  ABSang=AngVic();/*scegli angolo più vicino codardo !*/

  GotoP(ABSang);/*vatti a nascondere nell angolo più vicino*/
  
  /*setta i minimi e i massimi in base all'angolo dove si và a nascondere*/
  if (ABSang==4){imin=270;imax=359;}
  if (ABSang==2){imin=270;imax=180;}
  if (ABSang==7){imin=0;imax=90;}
  if (ABSang==5){imin=90;imax=180;}
    
  /*while principale (anche l'unico)*/
  while (1){
    
    found=scan(i,resol);/*prima scannerizzazzione*/
    r=found;/*setta distanza*/

    if (r>700){/*dista troppo*/
        found=0;
        r=0;
    }


    if (found==0){/*c'è nessuno?*/    
      r=0;
      i=imax;
      
      /*vai ADAM trova qualcuno !*/
      while(r==0){
            i-=2;/*scala i gradi*/
        
            r=scan(i,resol);/*setta gittata*/
        
            if (r>700){r=0;}/*che c'è non ci arrivi*/
        
            if (i<=imin){i=imax;}/*azzera gradi*/
        }
    }

    cannon(i,r);/*FUOCO !!!*/
  }


/*quoque tu*/
   
}


int AngVic(){/*trova angolo più vicino*/
  int angx;
  int angy;
  int angxy;
  
  /*angolo più vicino*/
  if (loc_x()<500){angx=4;}
  if (loc_x()>500){angx=2;}
  if (loc_y()<500){angy=3;}
  if (loc_y()>500){angy=0;}

  angxy=angx+angy;
  
  return angxy;
}

/*piccola allusione alla rosa dei venti, simbolo del sangreal*/
int GotoP(ang){/*vai all'angolo più vicino*/
  
  if (ang==2){/*angolo a nord-est*/
  
   while(loc_x() < 998){
    drive(0,50);
   }
   
   drive(0,0);
   
   while(loc_y() < 998){
    drive(90,50);
   }
   
   drive(180,0);
  
  }

  if (ang==4){/*angolo a nord-ovest*/
  
   while(loc_x() > 1){
    drive(180,50);

   }
   
   drive(0,0);
   
   while(loc_y() < 998){
    drive(90,50);
   }
   
   drive(0,0);
  
  }
    
  if (ang==7){/*angolo a sud-ovest*/
  
   while(loc_x() > 1){
    drive(180,50);
   }
   

   drive(0,0);
   
   while(loc_y() > 1){
    drive(270,50);
   }
   
   drive(0,0);
  
  }
  
  if (ang==5){/*angolo a sud-est*/

  
   while(loc_x() < 998){
    drive(0,50);
   }
   
   drive(0,0);
   
   while(loc_y() > 1){
    drive(270,50);
   }
   
   drive(180,0);
  
  }
  
  return 0;
}
