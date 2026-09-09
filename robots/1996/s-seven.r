/* NOME ROBOT:  s-7 v1.2
   AUTORE:      Aneloni Giovanni
   DESCRIZIONE: s-7 comincia col portarsi sul fondo dell'arena che poi
                costeggierÖ fino alla morte (speriamo degli altri!)
                fermandosi negli angoli fino a quando non viene colpito.
                Per sparare usa tre diverse routines:
                fuoco : nella fase iniziale mentre si sposta in basso e
                        nelle fasi di decelerazione
                spara : quando ä in movimento sul fondo
                cerca : da fermo
                cerca si appoggia alla routine ricorsiva 'mira'
   COMMENTI:    questo ä il robot che vorrei far partecipare se non fosse
                possibile ammettere anche d_ray.
*/
int scn,ang,vscn,lock,ci;
main()
{
        int d,inattivo;
        lock=0;
        while (loc_y()>50)                              /* finchä non ä arrivato... */
        {
                drive (270,100);                        /* ...si sposta in gió... */
                fuoco();                                /* ...e spara */
                }
        drive (270,0);                                  /* si ferma */
        while(1)
        {
                while (loc_x()<900)                     /* si muove a destra */
                {
                        drive(0,100);
                        spara();
                        }
                while (speed())                         /* si ferma */
                {
                        drive(0,0);
                        fuoco();
                        }
                d=damage();
                inattivo=500*(damage()>85);
                ci=3;                                   /* identifica l'angolo */
                while (damage()==d&&++inattivo<500)    /* spara da fermo */
                 cerca();
                while (loc_x()>100)                     /* si muove a sinistra */
                {
                        drive(180,100);
                        spara();
                        }
                while (speed())        /* si ferma */
                {
                        drive(180,0);
                        fuoco();
                        }
                d=damage();
                inattivo=500*(damage()>75);
                ci=1;                                   /* identifica l'angolo */
                while (damage()==d&&++inattivo<500)     /* spara da fermo */
                 cerca();
                }
        }
fuoco()
{
        if((scn=scan(ang,6))&&scn<800)          /* verifica se il nemico ä ancora a tiro */
         while(!cannon(ang,scn));
        else
         if((scn=scan(ang-13,7))&&scn<800)      /* scanna i 72 gradi attorno all'ultimo sparo */
          cannon(ang-=13,scn);
         else
          if((scn=scan(ang+13,7))&&scn<800)
           cannon(ang+=13,scn);
            else
             if((scn=scan(ang-28,8))&&scn<800)
              cannon(ang-=28,scn);
             else
              if((scn=scan(ang+28,8))&&scn<800)
               cannon(ang+=28,scn);
              else
               ang+=72;
        }
spara() /* scanna ad angoli fissi e spara se trova qualcosa */
{
        if ((scn=scan(0,10))&&scn<700)
         cannon(0,scn-(scn>>4));
        if ((scn=scan(180,10))&&scn<700)
         cannon(180,scn-(scn>>4));
        if ((scn=scan(20,10))&&scn<700)
         cannon(20,scn);
        if ((scn=scan(160,10))&&scn<700)
         cannon(160,scn);
        if ((scn=scan(40,10))&&scn<700)
         cannon(40,scn);
        if ((scn=scan(140,10))&&scn<700)
         cannon(140,scn);
        if ((scn=scan(60,10))&&scn<700)
         cannon(60,scn);
        if ((scn=scan(120,10))&&scn<700)
         cannon(120,scn);
        if ((scn=scan(80,10))&&scn<700)
         cannon(80,scn);
        if ((scn=scan(100,10))&&scn<700)
         cannon(100,scn);
        }
cerca() /* cerca un bersaglio con la stessa logica di 'fuoco' e richiama 'mira' */
{
        if(scan(ang,6)&&scan(ang,6)<850) /* verifica se il nemico ä ancora a tiro */
        {
                if (!mira (ang+3,3))     /* se il nemico e' stato trovato da un lato evita di perdere tempo */
                mira (ang-3,3);
                lock=1;                  /* il bersaglio ä rimasto sotto tiro */
                }
        else
         if(scan(ang-12,8))              /* scanna i 68 gradi attorno all'ultimo sparo */
         {
                if (!mira (ang-8,4))
                mira (ang-16,4);
                }
         else
          if(scan(ang+12,8))
          {
                if (!mira (ang+16,4))
                mira (ang+8,5);
                }
           else
            if(scan(ang-24,10))
            {
                        lock=0;
                        if (!mira (ang-19,5))
                        mira (ang-29,5);
                        }
             else
              if(scan(ang+24,8))
              {
                        lock=0;
                        if (!mira (ang+29,4))
                        mira (ang+19,4);
                        }
              else
              {
                        ang=45*ci;                /* il bersaglio ä andato perso */
                        lock=0;
                        }
        }
mira (a,r)
{
        if (r>2)                                /* se la risoluzione ä ancora troppo scarsa */
         if (scn=scan(a,r))
         {
                if (!mira (a-(r>>1),(r>>1)))    /* si richiama ricorsivamente con precisione sempre maggiore */
                 mira (a+(r>>1),(r>>1));
                return 1;                       /* il nemico ä stato trovato in questa direzione */
                }
         else
          return 0;                             /* non c'ä traccia di robot qui !?! */
        else
        {                                       /* la risoluzione ä ok: ora bisogna sparare! */
                if (lock)
                {
                        ang=a;
                        vscn=(scn<<1)-vscn;
                        while(!cannon(ang,vscn));
                        }
                else
                 while(!cannon (ang=a,vscn=scn));
                }
        }
        
