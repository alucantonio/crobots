pinpoint(head)
{
if (range = scan(head+4,6))
   head += 4;
else if (range = scan(head-4,6))
   head -= 4;
else 
   return 0;
if (range = scan(head+2,3))
   head += 2;
else if (range = scan(head-2,3))
   return head -= 2;
else
   return 0;
if (range = scan(head+1,2))
   return head+1;
else if (range = scan(head-1,2))
   return head-1;
else 
   return 0;
 
}


main()
  {
  head = 0;
  pts = 0;
  miss=0;
  while (1)
     {
     if (pts && bear)
        drive(bear,50);
 
     if (range = scan(head,10))
        if (bear = pinpoint(head))
           {
           ++pts;
           miss=-1;
           if (pts < 2)
              cannon(bear,range);
           else
              {
              if (rdif>0)
                 rdif = (range - pr) * range / 300;
              else
                 rdif = (range - pr) * range / 575;
              if (tdif>2)
                 tdif = (bear - pt) * range / 300;
              else 
                 tdif = 0;
              cannon(bear+tdif,range+rdif);
              }
           pr = range;
           pt = bear;
           if (bear)
              head = bear - 46;
           }
     head += 10;
     ++miss;
     if (miss == 5)
        {
        pts = 0;
         }
     if ((miss > 100) && !(miss%10))
        drive(head,50);
     }
     
  }

              

