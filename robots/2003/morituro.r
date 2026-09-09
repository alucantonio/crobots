/* *************************************************************************** */
/*   							*/
/*  NOME CROBOT: morituro.r				*/
/*							*/
/*  CATEGORIA: 500 istruzioni				*/
/*							*/
/*  AUTORE: Michele (Miccar) Cardinale 			*/
/*							*/
/* *************************************************************************** */

/*		SCHEDA TECNICA			*/
/*
Introduzione: Vedi Scanner.

Strategia: Si piazza in un angolo e ruota in attesa della morte.
Non si schioda dall'angolo di partenza.

Ho inviato questo crobot solo per poter far partecipare al torneo il mio Scanner (1000 istruzioni)
perche', se ho interpretato bene il regolamento, il primo crobot DEVE essere un micro..



*/
int dir,ang;
int x1,x2,odeg;
int l1,l2;

main(){


indangolo();

while(1)
	{
	while(loc_x()<l1) spara(drive(dir=0,100));
	while(loc_y()>l2) spara(drive(dir=270,100));
	while(loc_x()>l1) spara(drive(dir=180,100));
	while(loc_y()<l2) spara(drive(dir=90,100));
	}

}


spara(){
if(x1=scan(ang,10)){
	if(scan(ang+350,10)) ang+=355; else ang+=5;
	if(scan(ang+350,10)) ang+=356; else ang+=4;
	if(x2=scan(ang,10)) return cannon(ang,(x2*60)/60+(x1-(speed()*cos(ang-dir)>>20))-x2);
	}
else  {
	ang+=20;
	}
}

indangolo()
{
if (loc_x()>500){
	
	if (loc_y()>500) {
		l1=l2=890;
		} 
	else {
		l1=890;l2=110;
		}
	}
else{
	
	if (loc_y()>500) {
		l1=110;l2=890;
		}
	 else {
		l1=l2=110;
		}
	}
}