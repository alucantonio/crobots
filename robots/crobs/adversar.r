/* ------------------------------------------------------------------------- */
/* --- Program/Robot name  :                                  adversar.r --- */
/* --- Author :                                          James W. Penner --- */
/* --- Program date :                                  December 29, 1988 --- */
/* --- Strategy:                                                         --- */
/* ---      This robot, scans, pursues, and fires upon another robot.    --- */
/* ---       - Adversary will scan dead ahead, for the current target.   --- */
/* ---         +/-20d. if the target has moved out of angle or range.    --- */
/* ---         -60d. if no target is found.                              --- */
/* ---       - Pursuance, of a target robot is done at top speed, 100.   --- */
/* ---       - Firing is accomplished through the determination of the   --- */
/* ---         future position of a target.                              --- */
/* ------------------------------------------------------------------------- */
main()
  int antic;                           /* --- Anticipated distance --------- */
  int motor;                           /* --- Speed of motor --------------- */
  int old;                             /* --- Old or previous range -------- */
  int range;                           /* --- Current or last range -------- */
  int angle;                           /* --- Scan & directional angle ----- */
  int scope;                           /* --- Scope of scan ---------------- */
{
  /* ----------------------------------------------------------------------- */
  /* --- Main action : 360 degree scan, lock, pursue, and fire ------------- */
  /* ----------------------------------------------------------------------- */
  antic=0;                             /* --- Not anticipating ------------- */
  motor = 100;                         /* --- Set motor at top speed ------- */
  angle=90;                            /* --- Set scan angle to start @90d.- */
  scope=10;                            /* --- Set scope of scan @10d. ------ */
  while (1){
    drive(angle,motor);                /* --- Move robot, (toward target) -- */
    if (angle >= 360){                 /* --- Angle larger than 360d. ? ---- */
      angle %= 360;                    /* ------ reduce angle to < 360d. --- */
    }
    range = scan(angle,scope);         /* --- Get range of target ---------- */
    if (range>0 && range<=700){        /* --- Target in range ? ------------ */
      cannon(angle,range+antic);       /* ------ Fire ---------------------- */
    }else{                             /* --- Otherwise -------------------- */
      range = scan(angle-20,scope);    /* ------ Scan -20d. ---------------- */
      if (range>0 && range<=700){      /* ------ Target in range ? --------- */
        angle -= 20;                   /* --------- Point to target -------- */
        cannon(angle,range+antic);     /* --------- Fire ------------------- */
      }else{                           /* ------ Otherwise ----------------- */
        range = scan(angle+20,scope);  /* --------- Scan +20d. ------------- */
        if (range>0 && range<=700){    /* --------- Target in range ? ------ */
          angle += 20;                 /* ------------ Point to target ----- */
          cannon(angle,range+antic);   /* ------------ Fire ---------------- */
        }else{                         /* --------- Otherwise -------------- */
          angle -= 60;                 /* ------------ Set new scan angle -- */
        }                              /* --------- End if ----------------- */
      }                                /* ------ End if -------------------- */
    }                                  /* --- End if ----------------------- */
    if (range!=0){                     /* --- Target scanned ? ------------- */
      antic = range-old;               /* ------ Anticipate next distance -- */
    }else{                             /* --- Otherwise -------------------- */
      antic = 0;                       /* ------ Do not anticipate --------- */
    }                                  /* --- End if ----------------------- */
    old = range;                       /* --- Set last range to previous --- */
  }
}
