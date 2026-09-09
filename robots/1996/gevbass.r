/*             
        GevBass.r  (dedicato al mio famosissimo gruppo musicale
                    ovvero: i Grappa e Vinci;di cui naturalmente
                    io sono il bassista, e non sono un cesso!!!)

        Passando alle cose un po' pi— serie:
        per l' impostazione fondamentale mi sono ispirato alla routine
        di sparo di Passion.r,mentre per il movimento a quella di Apache95,
        sulle quali ho ovviamente portato eccezionali modifiche (ma dove?).
        Volevo inoltre ringraziare Carlin Alessandro e Zavarise Paolo
        (entrambi hanno spedito un loro robot, o almeno credo), per il 
        loro prezioso aiuto.

        Per i contatti (anche musicali) rivolgersi a:
        Tommaso De Pra

*/
int ang,dir,oldr,pausa,dam;

main()
{
        fuggi();        /* il robot si direziona verso un angolo */
        while (1)       /* ciclo principale */
        {
                if ( damage()>dam ) fuggi();    /* se viene colpito,si sposta in un altro angolo */
                else            /* routines di sparo (fermo,movimento) */
                {
                        if (speed()) mosso();
                        else fermo();
                }
        }
}

int quadrante()
/* a seconda di dove si trova, si sposta */

{

        int x,y;

        y=loc_y();
        x=loc_x();
        if (x<333){
                if (y<=500) return(0);
                return(3);
        }
        if (x>667) {
                if (y>500) return(2);
                return(1);
        }
        if (y<333) { 
                if (x<=500) return(0);
                return(1);
        }
        if (y>667) {
                if (x<=500) return(3);
                return(2);
        }
        return(5);
}
 
fuggi()
/* il robot fugge e spara se viene colpito */

{
        int a1,a2,range,sfas;

        drive(dir,0);
        a1=quadrante();
        if (a1!=5) {
                a1*=90;
                a2=a1+90;
                if (!scan(a2,10)) dir=a2;
                else if(!scan(a1,10)) dir=a1;
        }
        else {
                if(!scan(0,10)) dir=0;
                else if(!scan(90,10)) dir=90;
                else if(!scan(180,10)) dir=180;
                else dir=270;
        }
        drive (dir,100);
        pausa=0;
        dam=damage()+4;
        
        /* routine di sparo semplificata */
        if (!(range = scan (ang, 5))) {
                if (range = scan(ang -= 10, 5)) sfas = -6;
                else if (range = scan(ang -= 15, 10)) sfas = -10;
                else if (range = scan(ang += 35, 5)) sfas = 6;
                else if (range = scan(ang += 15, 10)) sfas = 10;
                else {
                        while (!(oldr = scan(ang += 20, 10)));
                        return;
                }
        }
        else sfas=0;

        if (range<700) {
                if (oldr) cannon(ang + sfas, range + (range - oldr) / 3);
                else cannon(ang, range);
        }
        else {
                ang+=40;
                oldr=0;
                return;
        } 

        oldr=range;     
        mosso();
}
mosso()
/* routine di sparo in movimento */
{
        int     range,sfas;

        if (!oldr) 
        /* se non trovo il nemico a cui sparare, uso una routine semplificata */ 
        {
                while (!(range = scan(ang += 20, 10)) );
                if (scan(ang-7,4)) ang-=7;
                else if(scan(ang+7,4)) ang+=7;
                if (oldr=scan(ang,10)) cannon(ang, oldr*oldr/range);
                return;
        }

        /* altimenti uso la routine consueta */
        if (!(range = scan (ang, 3))) {
                if (range = scan(ang -=6, 3)) sfas = -4;
                else if (range = scan(ang +=12, 3)) sfas = 4;
                else if (range = scan(ang -=19, 4)) sfas = -7;
                else if (range = scan(ang +=26, 4)) sfas = 7;
                else if (range = scan(ang -=38, 8)) sfas = -10;
                else if (range = scan(ang +=50, 8)) sfas = 10;
                else {
                        oldr=0;
                        return;
                }
        }
        else sfas=0;

        if (range<710) cannon(ang + sfas, range + (range - oldr) / 3);
        else if (range>oldr) {
                ang+=10;
                oldr=0;
                return;
        } 

        oldr=range;
}

fermo()
/* routine di sparo da fermo */

{
        int range,range1,sfas,olda;

        olda=ang;
        if (! (range1=scan(ang, 10)) ) {
                if (! (range1=scan(ang-=20,10))) {
                        ang+=40;
                        while (!(range1=scan(ang,10))) ang += 20;
                }
        }
                
        /* se Š passato troppo tempo e se non ho subito gravi danni attacco */
        if (range1>700) {
                cannon(ang,range1);
                if (++pausa==45 && dam<85) {
                        dir=(ang/30)*30;
                        pausa=0;
                        drive(dir,100);
                        oldr=range1;
                }
                else {
                        ang+=40;
                        oldr=0;
                }
                return;
        }

        /* cos faccio fuoco */
        if (!(scan(ang,2))) {
                if ((range=scan(ang + 8, 2))) ang += 8;
                else if ((range=scan(ang - 8, 2)))  ang -= 8;
                else if ((range=scan(ang + 4, 2))) ang += 4;
                else if ((range=scan(ang - 4, 2))) ang -= 4;
                else {
                        oldr=range1;
                        return;
                }
        }
        else {
                if (range=scan(ang+2,1)) ++ang;
                else if (range=scan(ang-2,1)) --ang;
                else if(!(range=scan(ang,10))) {
                        oldr=0;
                        return;
                }
        }
        if(oldr) sfas=(ang-olda)%360;
        else sfas=0;
        cannon(ang+sfas, range + (range * 7 / 50 + 20) * (range - range1) / 21);
        oldr=range;
}

