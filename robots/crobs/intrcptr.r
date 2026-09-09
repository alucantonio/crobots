/*********************************************************************/
/*                                                                   */
/*                          INTERCEPTOR                              */
/*                                                                   */
/*                       by Scott R. Gilbert                         */
/*                        (619) 223-8848                             */
/*                                                                   */
/*  Interceptor's philososphy is simply 'kill or be killed.'         */
/*  It makes no attempt to defend itself.  When it spots a target,   */
/*  it starts firing on the target and moving toward it.             */
/*  Interceptor uses a simply algorithm to lead its targets.         */
/*  Before firing on a target Interceptor always scans it at least   */
/*  twice to determine whether the target is moving.  Interceptor    */
/*  then attempts to lead the target using a crude linear            */
/*  interpolation formula.                                           */
/*********************************************************************/

int head1,head2,range1,range2,flag;

main()
{
flag = 1;

if ((loc_x() <= 500) && (loc_y() <= 500))          /* set a direction*/
      {
      drive(45,40);
      head1 = 0;
      }

if ((loc_x() <= 500) && (loc_y() > 500))
      {
      drive(315,40);
      head1 = 270;
      }

if ((loc_x() > 500) && (loc_y() <= 500))
      {
      drive(135,40);
      head1 = 90;
      }

if ((loc_x() > 500) && (loc_y() > 500))
      {
      drive(225,40);
      head1 = 180;
      }

while(1)
      {
      while(scan(head1,6) == 0)
           head1 += 12;

      flag = 1;

      if (range1 = scan((head1 - 4),2))
           head2 = head1 - 4;
      else if (range1 = scan((head1 + 4),2))
           head2 = head1 + 4;
      else if (range1 = scan(head1,2))
           head2 = head1;

      while (flag)
           {
           flag = 0;
           drive(head1,50);
           if (range2 = scan((head2 - 4),2))
                {
                cannon((head1=head2 - 8),(range1=(2 * range2) - range1));
                flag = 1;
                }

           else if (range2 = scan((head2 + 4),2))
                {
                cannon((head1=head2 + 8),(range1=(2 * range2) - range1));
                flag = 1;
                }
           else if (range2 = scan(head2,2))
                {
                cannon((head1=head2),(range1=(2 * range2) - range1));
                flag = 1;
                }
           else if (range2 = scan((head2 - 8),2))
                {
                cannon((head1=head2 - 16),(range1=(2 * range2) - range1));
                flag = 1;
                }
           else if (range2 = scan((head2 + 8),2))
                {
                cannon((head1=head2 + 16),(range1=(2 * range2) - range1));
                flag = 1;
                }
           }
      head1 -= 20;
      }
}

