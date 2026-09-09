/* **************************** */
/*  Crobots tournament 2015     */
/*  Participant: Mick Switser   */
/* **************************** */

/* This robot was written in 1 day based on an idea by Mike Jonkmans */
/* Basically it goes around in circles and shoots */


int prefd;
int tbd;

int sd,dist,orig,dd,diff,cor,ang,mp, myx, myy, amb, sca, scb, res, sml, lrg, svar;

int mickscan () {
    while (dist==0) {
        if ((dist=scan(sd,10))>0) {
            cannon(sd,dist);
        } else {
            sd=(sd-20+360)%360;
            if ((dist=scan((360-(sd-orig))+orig,10))>0) {
                cannon((sd=(((360-(sd-orig))+orig)+360)%360),dist);
            }
        }

    }


    if ((dist=scan((sd-=5),5))==0) {
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
                return cannon((sd=sd+svar),sca);
            }
        } else {
            return cannon((sd=sd+svar+lrg),dist);
        }
    }

}

int dodrive() {
    drive(dd,40);
    dd=sd+(ang=(atan(100000*(sqrt((dist*dist)-((tbd/2)*(tbd/2)))/(tbd/2)))));
    if (dist<prefd) {
        mp=1;
        diff=prefd-dist;
    } else {
        ang=180-ang;
        diff=dist-prefd;
        mp=-1;
    }

    cor=((180-ang-(amb=(((100000*(tbd-diff))/(tbd+diff))*atan(100000*ang/2))))/200000);
    dd+=mp*cor;
    dd=(dd+360)%360;

    if ((myx=loc_x(myy=loc_y()))<100) {
        if (dd>90&&dd<=180) {
            if (myy<900) {            
                dd=90;
            } else {
                dd=0;
            }
        } else if (dd>180&&dd<270) {
            if (myy>100) {
                dd=270;
            } else {
                dd=90;
            }
        }
    } else if (myx>900) {
        if (dd<90) {
            if (myy<900) {
                dd=90;
            } else {
                dd=270;
            }
        } else if (dd>270) {
            if (myy>100) {
                dd=270;
            } else {
                dd=90;
            }
        }
    } else if (myy<100) {
        if (dd>270) {
            dd=0;
        } else if (dd>180) {
            dd=180;
        }
    } else if (myy>900) {
        if (dd<=90) {
            dd=0;
        } else if (dd<180) {
            dd=180;
        }
    }

    

    drive(dd,100);
}

main () {
    prefd = 150;
    tbd = 50;
    res=sml=2;
    lrg=4;
    svar=3;

    dd=sd=45+((loc_x()>500)*90);
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
        mickscan(dist=0);
    }

    while(1) {
        dodrive();
        mickscan(dist=0);
    }

}



