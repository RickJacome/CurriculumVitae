clear all;clc; close all
load('ApproxCoif2L6.mat'); 
load('SGT.mat');
Time = SplitGravelTime;
Time = Time(1:numel(Time)/2);
Signal =  ApproxCoif2L6(6,:)*-1;
Signal = Signal(1:numel(Signal)/2);
plot(Time,Signal); hold on
Constant = [22.57,40.26];
Linear = [40.26, 41.52];
Constant2 = [41.52, 45.62];
LinearDown = [45.62 47.85];
Stopped = [47.85 55.06];

idx1 =find(Time > 22.57 & Time <40.26);
idx2 =find(Time > 40.26 & Time <42);
idx3 =find(Time > 42 & Time <46);
idx4 =find(Time > 45.6 & Time <46.1);
idx5 =find(Time > 46.1 & Time <55.06);
T1 = Time(idx1); S1 = Signal(idx1);
T2 = Time(idx2); S2 = Signal(idx2);
T3 = Time(idx3); S3 = Signal(idx3);
T4 = Time(idx4); S4 = Signal(idx4);
T5 = Time(idx5); S5 = Signal(idx5);


[p, S] = polyfit(T1,S1',0);
[s1_fit] = polyval(p,T1,S);
plot(T1,s1_fit,'linewidth',2); hold on;

[p, S] = polyfit(T2,S2',1);
[s2_fit] = polyval(p,T2,S);
plot(T2,s2_fit,'linewidth',2); hold on;

[p, S] = polyfit(T3,S3',0);
[s3_fit] = polyval(p,T3,S);
plot(T3,s3_fit,'linewidth',2); hold on;

[p, S] = polyfit(T4,S4',1);
[s4_fit] = polyval(p,T4,S);
plot(T4,s4_fit,'linewidth',2); hold on;

[p, S] = polyfit(T5,S5',0);
[s5_fit] = polyval(p,T5,S);
plot(T5,s5_fit,'linewidth',2); hold on; 

xlim([30 52]); grid on;
xlabel('Time (sec)'); ylabel('Acceleration (Gs)');

legend('Filtered Signal','Constant','Linear Up',...
'Constant','Linear Down','Constant','location','best');
title('Logitudinal Acceleration Profile');
