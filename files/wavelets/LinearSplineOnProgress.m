clear all;clc; close all
load('ApproxCoif2L6CompleteSignal.mat'); 
load('SGT.mat');
Time = SplitGravelTime;
%Time = Time(1:numel(Time)/2);
Signal =  DecomCoif2L6Complete(6,:)*-1;
%Signal = Signal(1:numel(Signal)/2);
plot(Time,Signal); hold on

windowSize = 100; % Relate this to frequency
kernel = (1/windowSize)*ones(1,windowSize);
%Coefficients of Rational Transfer Function
% a = 1
out = filter(kernel, 1, Signal);
% Plot 1-D Filter with a Window Size of 100
plot(Time,out)

% Detect When the Average Changes Drastically
n = numel(Signal);
o = zeros(n,1);
T1 = zeros(n,1);
threshold = 0.1;
Sig1 = zeros(n,1);
Sig2 = zeros(n,1);
for i = 1:n-1
        if  mean([Signal(i),Signal(i+1)]) < threshold  
          o(i) = 0;
          Sig1(i) = Signal(i);
        else  
          o(i) = 1;  
          Sig2(i) = Signal(i);
        end      
end
plot(Time,o)
legend('Coiflet Signal','Moving Window Filtered','Average Switch')
legend('location','best')
figure
plot(Time,Sig1); hold on; plot(Time,Sig2)








