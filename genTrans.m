function [statespace, sys] = genTrans(A, B, C, D)
statespace = ss(A, B, C, D);
sys = tf(statespace);
disp(sys);
end
   