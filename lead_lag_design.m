clc;
clear;
s=tf('s');
num_act = [10];
den_act = [1 10];
num_dyn = [11.4];
den_dyn = [1 1.4 0];
k=0.16; %gain 
k_g=1; %stable gyroscope
G_a = tf(num_act,den_act,'InputDelay',0.125); % 0.125ms time delay added to actuator response
G_d = tf(num_dyn,den_dyn); %Aircraft dynamics

Kp1=0.6; %high gain value
p1=15; z1=20;
C1=Kp1*(p1/z1)*tf([1 z1],[1 p1]); %lead lag compensator 

sys = feedback(k*G_a*G_d,[1]); %uncompensated
sys_c = feedback(k*C1*G_a*G_d,[1]);%compensated
figure(1);
step(sys,sys_c);
legend('uncomp','compensated');
title('Lead Lag System with Time Delay');

hold on;
figure(2);
bode(sys,sys_c);
legend('Uncompensated','Compensated');
hold off;

G_b = tf(num_act,den_act);

sys8= G_b*G_d;
%rlocus(sys8);
zeta = 1.52;
wn=0;

figure(3);
G_c = tf(num_act,den_act); %Time Delay removed
sys_d = feedback(k*Kp1*C1*G_c*G_d,[1]);
step(sys_c, sys_d);
legend('with time delay','without time delay');
title('compensated W/WO time delay');

figure(4);
bode(sys_c,sys_d);
title('compensated W/WO time delay');
legend('with time delay','without time delay');

%%%%======Continuous to Discrete=========%%%%%%
Ts= 0.1; %sample time
Gz = c2d(C1, Ts,'matched');

