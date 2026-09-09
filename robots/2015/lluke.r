/* **************************** */
/*  Crobots tournament 2015     */
/*  Participant: Mick Switser   */
/* **************************** */

/* This robot has been made from scratch, no code has been used from previous robots. */
/* Most likely that is the reason that this will not be the winner ;-) */
/* My strategy was to make a scanner with a narrowing beam and overlap to position the target and fire as soon as possible */
/* Along the way it got more and more complex and I lost the timings, making it more accurate, but less fast */
/* I ended up with this version, which tries to keep a medium distance and moves back and forth and sideways to avoid incoming missiles */


int dd, orig, sd, sca, scb, res, sml, lrg, svar, cnt, dist, scm, temp, flip, dir, myx, myy;
int mickscan();
int dodrive();

main () {
    dd=orig=sd=45+((loc_x()>500)*90);
    if (loc_y()>500) sd=360-sd;

    if ((sca=scan(sd,10))>0) {
        if ((scb=scan(sd+5,5))>0) {
            cannon((sd+=7),scb);
        } else {
            cannon((sd-=7),sca);
        }
    } else if ((sca=scan((sd-=21),10))>0) {
        if ((scb=scan(sd+5,5))>0) {
            cannon((sd+=7),scb);
        } else {
            cannon((sd-=7),sca);
        }
    } else if ((sca=scan((sd+=42),10))>0) {
        if ((scb=scan(sd+5,5))>0) {
            cannon((sd+=7),scb);
        } else {
            cannon((sd-=7),sca);
        }
    } else {
        drive(dd,100);
        mickscan((sd-=63),(res=sml=2),(lrg=4),(svar=3),(cnt=dist=0));
    }

    while (1) {
        dodrive(); /* 152 */
        mickscan((res=sml=2),(lrg=4),(svar=3),(cnt=dist=0),(orig=(sd+360)%360));
    }
}

int mickscan () {
    while (dist==0) {
        if ((dist=scan(sd,10))>0) {
        } else {
            if (++cnt%6==0) dodrive();
            sd=(sd-20+360)%360;
            if ((dist=scan((360-(sd-orig))+orig,10))>0) {
                sd=(360-(sd-orig))+orig;
            }
        }
    }
    if (dist<350) {
        res=4;
        sml=3;
        lrg=8;
        svar=6;
    } else if ((dist=scan((sd-=5),5))==0) {
        sd+=10;
    }
    if ((sca=scan(sd-svar,res))>0) {
        if ((scb=scan(sd,res))>0) {
            return cannon((sd=sd-sml),scb-((sca-scb)*(scb/110)));
        } else {
            if ((scb=scan(sd-svar,res))>0) {
                return cannon((sd=sd-lrg),scb-((sca-scb)*(scb/100)));
            } else { 
                return cannon((sd=(sd-svar-lrg)),sca);
            }
        }
    } else if ((sca=scan(sd+svar,res))>0) {
        if ((scb=scan(sd,res))>0) {
            return cannon((sd=sd+sml),scb-((sca-scb)*(scb/110)));
        } else {
            if ((scb=scan(sd+svar,res))>0) {
            	return cannon((sd=sd+lrg),scb-((sca-scb)*(scb/100)));
            } else {
                return cannon((sd=sd+svar+lrg),sca);
            }
        }
    } else {
        if ((sca=scan(sd,res))>0) {
            if ((scb=scan(sd,res))>0) {
            	return cannon(sd,scb-((sca-scb)*(scb/110)));
			} else {
                return cannon((sd=sd+(svar*scm)),sca);
            }
        } else {
            return cannon((sd=sd+((svar+lrg)*scm)),dist);
        }
    }
}

int dodrive() {
        drive(dd,40);
        if (dist>600) {
            dd=sd+(rand(10)-5);
            scm=0;
        } else if (++flip%6==0) {
            dd=(sd+(dir=dir+90)+(rand(10)))%360;
        } else {
            dd=(dd+180+(rand(10)))%360;
            scm*=-1;
        }

        if ((myx=loc_x())>800) {
            if ((temp=((dd+90)%360))<180) {
                dd=(360-temp)-90;
            }
        } else if (myx<200) {
            if ((temp=((dd+90)%360))>180) {
                dd=(360-temp)-90;
            }
        }
        if ((myy=loc_y())>800) {
            if ((temp=((dd+360)%360))<180) {
                dd=360-temp;
            }
        } else if (myy<200) {
            if ((temp=((dd+360)%360))>180) {
                dd=360-temp;
            }
        } 

        scm=(((360+dd-sd)%360+45)/90)%4;
        if (scm==1) {
            scm=-1;
        } else if (scm==3) {
            scm=1;
        } else {
            scm=0;
        }
        res=2;
        sml=2;
        lrg=4;
        svar=3;
        drive(dd,100);
}

