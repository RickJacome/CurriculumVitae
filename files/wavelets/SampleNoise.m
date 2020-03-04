clc; clear all; close all
load('Sample_Approx.mat')
load('SampleCoeff.mat')
t = (0:0.1:12)'; n = numel(t);
x = sawtooth(t); 
y = awgn(x,1,'measured');
plot(t,[x y])
legend('Original Signal','Signal with AWGN')
Approx3 = approximations_1D(3,:);
figure; plot(Approx3);
Coef = cfs_1D.coefs;
figure; plot(Coef)