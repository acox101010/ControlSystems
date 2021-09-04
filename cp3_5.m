%define matrix variables
%X1
A_1 = [0 1 0; 0 0 1; -4 -5 -8];
B_1 = [0; 0; 4];
C_1 = [1 0 0];
D_1 = [0];
%X2
A_2 = [0.5 0.5 0.7071; -0.5 -0.5 0.7071; -6.3640 -0.7071 -8.0];
B_2 = [0; 0; 4];
C_2 = [0.7071 -0.7071 0];
D_2 = [0];

%find transfer function manually
%st_1 = ss(A_1, B_1, C_1, D_1);
%sys = tf(st_1);
%disp(sys);

%Transfer Function for each part using genTrans.m function
%part a
X1 = genTrans(A_1,B_1,C_1,D_1);
%part b
X2 = genTrans(A_2,B_2,C_2,D_2);

%display values for comparison
[num1,den1] = tfdata(X1);
[num2,den2] = tfdata(X2);

disp("X1 numerator/denominator:");
disp(num1);
disp(den1);
disp("X2 numerator/denominator:");
disp(num2);
disp(den2);
