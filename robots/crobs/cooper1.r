/* D W Cooper - 3/19/86    Updated 3/20/86 */

main(){d3rk5s2jnm554nbh32j=0;p3ck9q1nsl058ckc84e=j5kz1h4hmc347ncnj34q=rand(360);
if(j5kz1h4hmc347ncnj34q<270&&j5kz1h4hmc347ncnj34q>90)m9ch3n0hxb484bdk39f=-1;else(m9ch3n0hxb484bdk39f=1);
if(j5kz1h4hmc347ncnj34q>180)k8sb2j6jnx208ckd35z=-1;else(k8sb2j6jnx208ckd35z=1);
while(1){drive(j5kz1h4hmc347ncnj34q,100);if(loc_x()<100)if(m9ch3n0hxb484bdk39f==-1){
drive(j5kz1h4hmc347ncnj34q,50);j5kz1h4hmc347ncnj34q=rand(178)+1;if(j5kz1h4hmc347ncnj34q>89)j5kz1h4hmc347ncnj34q+=180;
while(speed()>50);drive(j5kz1h4hmc347ncnj34q,100);if(j5kz1h4hmc347ncnj34q<270&&j5kz1h4hmc347ncnj34q>90)m9ch3n0hxb484bdk39f=-1;
else(m9ch3n0hxb484bdk39f=1);if(j5kz1h4hmc347ncnj34q>180)k8sb2j6jnx208ckd35z=-1;
else(k8sb2j6jnx208ckd35z=1);}if(loc_x()>900)if(m9ch3n0hxb484bdk39f==1){drive(j5kz1h4hmc347ncnj34q,50);
j5kz1h4hmc347ncnj34q=rand(178)+91;while(speed()>50);drive(j5kz1h4hmc347ncnj34q,100);
if(j5kz1h4hmc347ncnj34q<270&&j5kz1h4hmc347ncnj34q>90)m9ch3n0hxb484bdk39f=-1;
else(m9ch3n0hxb484bdk39f=1);if(j5kz1h4hmc347ncnj34q>180)k8sb2j6jnx208ckd35z=-1;
else(k8sb2j6jnx208ckd35z=1);}if(loc_y()<100)if(k8sb2j6jnx208ckd35z==-1){drive(j5kz1h4hmc347ncnj34q,50);
j5kz1h4hmc347ncnj34q=rand(178)+1;while(speed()>50);drive(j5kz1h4hmc347ncnj34q,100);
if(j5kz1h4hmc347ncnj34q<270&&j5kz1h4hmc347ncnj34q>90)m9ch3n0hxb484bdk39f=-1;else(m9ch3n0hxb484bdk39f=1);
if(j5kz1h4hmc347ncnj34q>180)k8sb2j6jnx208ckd35z=-1;else(k8sb2j6jnx208ckd35z=1);
}if(loc_y()>900)if(k8sb2j6jnx208ckd35z==1){drive(j5kz1h4hmc347ncnj34q,50);j5kz1h4hmc347ncnj34q=rand(178)+181;
while(speed()>50);drive(j5kz1h4hmc347ncnj34q,100);if(j5kz1h4hmc347ncnj34q<270&&j5kz1h4hmc347ncnj34q>90)m9ch3n0hxb484bdk39f=-1;
else(m9ch3n0hxb484bdk39f=1);if(j5kz1h4hmc347ncnj34q>180)k8sb2j6jnx208ckd35z=-1;
else(k8sb2j6jnx208ckd35z=1);}if(d3rk5s2jnm554nbh32j){y2dbf0sh1apq847chy63u=18;while(y2dbf0sh1apq847chy63u>1){
o7xg2h1cnf085sjh49q=y2dbf0sh1apq847chy63u/2;if(h9ldj3d8dhb294cbe20g=scan(p3ck9q1nsl058ckc84e,o7xg2h1cnf085sjh49q))h8wo0j4xbn375cns48a=0;
else if(h9ldj3d8dhb294cbe20g=scan(p3ck9q1nsl058ckc84e+y2dbf0sh1apq847chy63u,o7xg2h1cnf085sjh49q))h8wo0j4xbn375cns48a=y2dbf0sh1apq847chy63u;
else if(h9ldj3d8dhb294cbe20g=scan(p3ck9q1nsl058ckc84e-y2dbf0sh1apq847chy63u,o7xg2h1cnf085sjh49q))h8wo0j4xbn375cns48a=360-y2dbf0sh1apq847chy63u;
else{if(y2dbf0sh1apq847chy63u==18){p3ck9q1nsl058ckc84e=(p3ck9q1nsl058ckc84e+180)%360;
d3rk5s2jnm554nbh32j=0;}h9ldj3d8dhb294cbe20g=y2dbf0sh1apq847chy63u=0;}if(h9ldj3d8dhb294cbe20g>40){
cannon(p3ck9q1nsl058ckc84e+h8wo0j4xbn375cns48a,h9ldj3d8dhb294cbe20g-(k4jx4j6xnb103cjd46g-h9ldj3d8dhb294cbe20g)/3);
k4jx4j6xnb103cjd46g=h9ldj3d8dhb294cbe20g;p3ck9q1nsl058ckc84e=(p3ck9q1nsl058ckc84e+h8wo0j4xbn375cns48a)%360;
y2dbf0sh1apq847chy63u/=3;}}}else{h9ldj3d8dhb294cbe20g=scan(p3ck9q1nsl058ckc84e,10);
if(h9ldj3d8dhb294cbe20g==0||h9ldj3d8dhb294cbe20g>700)p3ck9q1nsl058ckc84e=(p3ck9q1nsl058ckc84e+20)%360;
else{d3rk5s2jnm554nbh32j=1;k4jx4j6xnb103cjd46g=h9ldj3d8dhb294cbe20g;if(h9ldj3d8dhb294cbe20g>200){drive(j5kz1h4hmc347ncnj34q,50);
while(speed()>50);drive(p3ck9q1nsl058ckc84e,100);j5kz1h4hmc347ncnj34q=p3ck9q1nsl058ckc84e;
if(j5kz1h4hmc347ncnj34q<270&&j5kz1h4hmc347ncnj34q>90)m9ch3n0hxb484bdk39f=-1;else(m9ch3n0hxb484bdk39f=1);
if(j5kz1h4hmc347ncnj34q>180)k8sb2j6jnx208ckd35z=-1;else(k8sb2j6jnx208ckd35z=1);}}}}}
