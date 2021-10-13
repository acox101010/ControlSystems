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

sys = feedback(k*G_a*G_d*k_g,[1]);
figure(1);
step(sys);
title('Initial System with Time Delay');
figure(2);
margin(sys);
%pidtool(sys,'pid');

num_C = [1.3563 0.9215 0.0166]; %after PID tuning
den_C = [1 0];
G_C = tf(num_C,den_C); %PID Transfer function
sys_p = feedback(k*G_a*G_d*k_g*G_C,[1]); %PID design system

figure(3);
hold on;
step(sys);
step(sys_p);
legend('Uncompensated','PID Controlled');

zeta = 0.45594;
wn = 4/(4.5*zeta);
pm = zeta/0.01;

kk1 = [0.10:0.02:0.20]; %Gain from 0<35 increaments of 5
figure(4);
hold on;
for i=1:length(kk1)
    b=feedback(kk1(i)*G_a*G_d*k_g,[1]);
    step(b);
end
legend('0.10','0.12','0.14','0.16','0.18','0.20');
title('Uncompensated Variable K (0.10 to 0.20)');
hold off;

figure(5);
G_b = tf(num_act,den_act);
sys2 = feedback(k*G_b*G_d*k_g,[1]);
rlocus(sys2);
