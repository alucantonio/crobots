/*
Nome del robot  : Reduced Instruction Set Challenger
Nome del file   : Risc.r
Autore          : Gianni Ino

Il robot e' una rielaborazione di Navaho.r, che ha partecipato al torneo dello
scorso anno.
Anche questo e' basato sul vincitore del torneoY2K, ma questa volta, complice 
la limitazione delle 500 istruzioni, il codice e' totalmente riscritto: del
Dav46.r e' quindi rimasta solo l'idea.
*/

int scn, angolo, oscn, oangolo;   
int z,dir;
int py,px,dor,danni,x,y,v;

main()
{
    x=40+920*(loc_x((y=40+920*(loc_y()>500)))>500);

    while (1)
    {

       dir=(360-((px=(x-loc_x()))<0)*180+atan(((y-loc_y())*100000)/px));

       while ((v=((px=x-loc_x())*px+(py=y-loc_y())*py))>10000) fuoco(v<15000);
       drive(dir,0);

       if (!z) z=danni=damage();
       
       if (danni<damage()-5)
       {
         drive(dir,z=0);
         if (free(90+180*(y>500))) y=1000-y;
         else if (free(180*(x>500))) x=1000-x;
       }
       else
       {
         danni=damage();
         dir=45+90*((x>500)+(1+2*(x<500))*(y>500));
         while ((loc_x()%900)<100) fuoco(0);
       }

    }        
}

free (gradi)
{
    return (!scan(gradi+350,10) && !scan(gradi+10,10));
}

fuoco(flag)
{
    drive (dir,100);
    if ((oscn=scan(angolo,10))&&(oscn<800))
      {
        if (flag);
        else
        {

        radar();

        if (oscn=scan(oangolo=angolo,5))
        {

        radar();

            if (scn=scan(angolo,10)) 
                return cannon(angolo+(angolo-oangolo)*((1200+scn)>>9)-(sin(angolo-dir)>>14),
                       scn*160/(160+oscn-scn-(cos(angolo-dir)>>12)));
        }
        }
        }
    if ((oscn=scan(angolo,10))&&(oscn<800));
    else if (oscn=scan(angolo+=340,10));
    else if (oscn=scan(angolo+=40,10));
    else return angolo+=40;
    cannon (angolo,2*scan(angolo,10)-oscn);

}

radar()
{
            if(scan(angolo+355,5)) angolo+=355;
            if(scan(angolo+5,5)) angolo+=5;
            if(scan(angolo+357,1)) angolo+=357;
            if(scan(angolo+3,1)) angolo+=3;
            if(scan(angolo+359,1)) angolo+=359;
            if(scan(angolo+1,1)) angolo+=1;
}
