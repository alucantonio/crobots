/*************************************************************************/
/*                                                                       */
/*   Leavy - Robot Code.                    completed : 12/5/88          */
/*                                                                       */
/*   Programmer - Mark Leavy                                             */
/*                                                                       */
/*                                                                       */
/*          Home Address                         Work Address            */
/*                                                                       */
/*      10409 Strathmore Drive              US Elevator Corporation      */
/*      Santee, Ca 92071                    10728 US Elevator Rd         */
/*      (619) 449-3581                      Spring Valley, Ca 92078      */
/*                                          (619) 660-1000 ext. 321      */
/*                                                                       */
/*                                                                       */
/*   Notes:  I developed this robot program as an entry to Computor      */
/*           Edge's programming contest.  After studying the sample      */
/*           robots, I determined that the main objectives should be:    */
/*                                                                       */
/*              1: Speed                                                 */
/*              2: Continuous, accurate cannon fire.                     */
/*              3: Preference for closer targets.                        */
/*              4: Follow a course that allows rapid coverage            */
/*                 of the entire battlefield, but stays out of           */
/*                 the hot spots. (corners and center).                  */
/*                                                                       */
/*           To achieve these goals required some fairly intelligent     */
/*           algorithms, and I hope you will excuse me for not prov-     */
/*           iding the full uncompressed, commented source code.  I      */
/*           did spend a decent amount of time on this program and I     */
/*           do not want to just hand it out.  If you realy are          */
/*           interested in discussing the methodology, give me a call.   */
/*                                                                       */
/*           The original program followed good programming practice,    */
/*           and was only about %50 of capacity.  After all of the       */
/*           code had been proven, however, I sacrificed code space      */
/*           for speed.  Therefore, wherever possible, in-line code      */
/*           was substituted for subroutine calls, and global variables  */
/*           were used instead of parameter passing.                     */
/*                                                                       */
/*           Now for the results of my testing:                          */
/*                                                                       */
/*             Of all the sample robots provided, the best robots are:   */
/*                                                                       */
/*               1) Mad_Max2.r                                           */
/*               2) Slasher.r                                            */
/*               3) RoboCop2.r                                           */
/*               4) Destroy.r                                            */
/*                                                                       */
/*             I matched these up with Leavy.r as follows:               */
/*                                                                       */
/*         100 matches of Leavy.r, Mad_Max2.r, Slasher.r RoboCop2.r        
                                                                               
(1)       leavy.r: wins=78 ties=0  	   (2)    mad_max2.r: wins=15 ties=0  
(3)     slasher.r: wins=6 ties=0  	      (4)    robocop2.r: wins=1 ties=0  	
                                                                         */
/*                                                                       */
/*         100 matches of Leavy.r, Mad_Max2.r, Slasher.r Destroy.r        
                                                                               
(1)       leavy.r: wins=84 ties=0  	   (2)    mad_max2.r: wins=12 ties=0  
(3)     slasher.r: wins=4 ties=0   	   (4)     destroy.r: wins=0 ties=0  	
                                                                         */
/*                                                                       */
/*         100 matches of Leavy.r, Mad_Max2.r, Slasher.r
                                                                               
(1)       leavy.r: wins=86 ties=0  	   (2)    mad_max2.r: wins=6 ties=0  
(3)     slasher.r: wins=7 ties=0
                                                                         */
/*                                                                       */
/*         100 matches of Leavy.r, Mad_Max2.r                          
                                                                               
(1)       leavy.r: wins=100 ties=0 	   (2)    mad_max2.r: wins=0 ties=0  
                                                                         */
/*                                                                       */
/*         100 matches of Leavy.r, Slasher.r                           
                                                                               
(1)       leavy.r: wins=100 ties=0 	   (2)     slasher.r: wins=0 ties=0  
                                                                         */
/*                                                                       */
/*************************************************************************/

int A,B,C,D,E,F,G,H,I,J;main(){C=loc_x();D=loc_y();K();while(1){if(L())M();}}
K(){if(F&64){if(F&128){if(C<500){G=980;}else{G=20;}if(D<500){H=800;}else{H=
200;}}else{if(D>500){if(C>500){G=800;H=20;}else{G=800;H=980;}}else{if(C>500){
G=200;H=20;}else{G=200;H=980;}}}}else{if(F&128){if(C<500){G=800;}else{G=200;}
if(D<500){H=980;}else{H=20;}}else{if(D>500){if(C>500){G=20;H=800;}else{G=20;
H=200;}}else{if(C>500){G=980;H=800;}else{G=980;H=200;}}}}E=N();}L(){A=4;while
(A<360){if(B=scan(A,10)){if(B<60)B=60;cannon(A,B);A+=720;return(1);}if(B=
scan(360-A,10)){A=1080-A;if(B<60)B=60;cannon(A,B);return(1);}A+=20;++F;C=
loc_x();D=loc_y();I=G-C;J=H-D;if(((I*I)+(J*J))<10000){drive(E,10);K();}if(
speed()<50){E=N();drive(E,100);}}return(0);}M(){int O,P;O=1;while(O){if(
B=scan(A,5)){if(B<60)B=60;cannon(A,B);}else{A+=14;if(B=scan(A,10)){if(B<60)B
=60;cannon(A+3,B);}else{A-=28;if(B=scan(A,10)){if(B<60)B=60;cannon(A-6,B);}
else{O=0;}}}if(B>330){A+=(P=rand(120));if(B=scan(A,10)){if(B<60)B=60;cannon(A
,B);}else{if(B=scan(A+120,10)){if(B<60)B=60;cannon((A+=120),B);}else{if(B=
scan(A+240,10)){if(B<60)B=60;cannon((A+=240),B);}else{A-=P;}}}}++F;C=loc_x();
D=loc_y();I=G-C;J=H-D;if(((I*I)+(J*J))<10000){drive(E,10);K();}if(speed()<50)
{E=N();drive(E,100);}}}N(){int Q;I=G-loc_x();J=H-loc_y();if(I){Q=atan(J*
100000/I);if(I<0){Q+=180;}}else{if(J<0){Q=270;}else{Q=90;}}if(Q<0){Q+=360;}
return (Q);}
