k = [0.1:0.1:10]; %controller gain array 0<k<=10
G = tf([1], [1 20 20]); %transfer function 
for i = 1:length(k)
    num = k(i);
    den = [1];
    Td = tf(num,den);
    sysfb=feedback(G,Td);
    T=tf(k(i)*G/(1+k(i)*G)); %transfer function of response
    y = step(T); %step response
    y2 = step(sysfb); %step response for disturbance
    Tf(i) = y(end);
    Tfd(i) = y2(end);
end
    
%Plot of the values
plot(k,Tf,k,Tfd);
title('Steady State Value of Y(s)');
xlabel('Controller Gain(k)');
ylabel('Y(s)');
legend('Steady State','Disturbance')
%P = InterX([k;Tf],[k;Tfd]); %function for calculating intersection
%disp(P); %intersection is 1.00 and 0.0475