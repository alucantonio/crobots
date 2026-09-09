/* by Joshua Gruber 11/21/87   age 11

     Tracker scans the feild at a 20 degree
   resolution to catch robots more quickly.
   It then stalks it prey while shooting.
   It's programming is very simple but have
   fun TRYING to beat it.


    note to Eric : tracker will eat rabbit
                   for dinner.
*/
main()  {
int i;                         /* direction of scan */
int p;                         /* range */
   while(1)  {                 /* endless loop */
      i = i + 20;              /* change scan area */
      p = scan(i,21);          /* scan */
      if (p > 0)  { 
         cannon(i+10,p);        /* shoot at target */
         drive(i+10,49);        /* turn and move toward target */
         drive(i+10,100);       /* move faster toward target */
         i = i - 40;           /* rescan area if target */
      }
   }
}