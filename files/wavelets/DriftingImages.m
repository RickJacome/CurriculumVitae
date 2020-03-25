clc; clear all; close all
load('matlabData\ApproxCoif2L6CompleteSignalFCA.mat');
load('matlabData\FCT.mat'); load('matlabData\FCA.mat')
FCt = FullConcreteTime;  FCsigcoif = DecomCoif2L6CompFCA(6,:);
FCsignal = FullConcreteAccel; 
idx1 = find(FCt ==0); idx2 = find(FCt ==60);
idx3 = find(FCt ==130); idx4 = find(FCt ==180);
DriftingRemove22(FCt,FCsigcoif,FCsignal,idx1,idx2,idx3,idx4);
% % --------------------------------------
% % For this Test  you need Section RJ34.4
% figure(100);
% sig1x = sig1(1050:end); sigcoif1x = sigcoif1(1050:end);
% t1x = t1(1050:end);
% plot(t1x,sig1x*-1); hold on;
% plot(t1x,sigcoif1x*-1,'--','Linewidth',1.5); 
% t2x = t2 - 119;
% plot(t2x,sig2*-1);
% plot(t2x,sigcoif2*-1,'--','Linewidth',1.5)
% xlabel('Time (sec)'); ylabel('Acceleration Gs')
% legend('FC1','FC1 Approx','FC2','FC2 Approx')
% xlim([10 60]);
% legend('location','NW')
% %---------------------------------------
% load('matlabData\ApproxCoif2L6CompleteSignalFGA.mat');
% load('matlabData\FGT.mat'); load('matlabData\FGA.mat')
% FGt = FullGravelTime;  FGsigcoif = DecomCoif2L6CompFGA(6,:);
% FGsignal  = FullGravelAccel; 
% idx1 = find(FGt ==30); idx2 = find(FGt == 90);
% idx3 = find(FGt ==130); idx4 = find(FGt ==180);
% DriftingRemove22(FGt,FGsigcoif,FGsignal,idx1,idx2,idx3,idx4);
% % --------------------------------------
% % For this Test  you need Section RJ34.4
% figure(100);
% sig1x = sig1(1:end); sigcoif1x = sigcoif1(1:end);
% t1x = t1;
% plot(t1x,sig1x*-1); hold on;
% plot(t1x,sigcoif1x*-1,'--','Linewidth',1.5); 
% t2x = t2-100;
% plot(t2x,sig2*-1); 
% plot(t2x,sigcoif2*-1,'--','Linewidth',1.5)
% xlabel('Time (sec)'); ylabel('Acceleration Gs')
% legend('FG1','FG1 Approx','FG2','FG2 Approx')
% legend('location','NW')
% %---------------------------------------
% load('matlabData\ApproxCoif2L6CompleteSignalFSA.mat');
% load('matlabData\FST.mat'); load('matlabData\FSA.mat')
% FSt = FullSandTime;  FSsigcoif = DecomCoif2L6CompFSA(6,:);
% FSsignal  = FullSandAccel; 
% idx1 = find(FSt == 0); idx2 = find(FSt == 60);
% idx3 = find(FSt ==90); idx4 = find(FSt ==140);
% DriftingRemove22(FSt,FSsigcoif,FSsignal,idx1,idx2,idx3,idx4);
%---------------------------------------
% % For this Test  you need Section RJ34.4
% figure(100);
% sig1x = sig1(1050:end); sigcoif1x = sigcoif1(1050:end);
% t1x = t1(1050:end);
% plot(t1x,sig1x*-1); hold on;
% plot(t1x,sigcoif1x*-1,'--','Linewidth',1.5); 
% t2x = t2-80;
% plot(t2x,sig2*-1); 
% plot(t2x,sigcoif2*-1,'--','Linewidth',1.5)
% xlabel('Time (sec)'); ylabel('Acceleration Gs')
% legend('FS1','FS1 Approx','FS2','FS2 Approx')
% legend('location','NW')
% % %---------------------------------------
% load('matlabData\ApproxCoif2L6CompleteSignal.mat'); 
% load('matlabData\SGT.mat'); load('matlabData\SGA.mat')
% SGt = SplitGravelTime; SGsigcoif = DecomCoif2L6Complete(6,:);
% SGsignal = SpliGravelAccel;
% idx1 = find(SGt == 10); idx2 = find(SGt == 60);
% idx3 = find(SGt ==140); idx4 = find(SGt ==190);
% DriftingRemove22(SGt,SGsigcoif,SGsignal,idx1,idx2,idx3,idx4);
% %---------------------------------------
% % For this Test  you need Section RJ34.4
% figure(100);
% sig1x = sig1(1:end);
% sigcoif1x = sigcoif1(1:end);
% t1x = t1(1:end);
% plot(t1x,sig1x*-1); hold on;
% plot(t1x,sigcoif1x*-1,'--','Linewidth',1.5); 
% sig2x = sig2(470:end);
% sigcoif2x = sigcoif2(470:end);
% t2x = t2(470:end) - 136;
% plot(t2x,sig2x*-1); 
% plot(t2x,sigcoif2x*-1,'--','Linewidth',1.5)
% xlabel('Time (sec)'); ylabel('Acceleration Gs')
% legend('SG1','SG1 Approx','SG2','SG2 Approx')
% legend('location','NW')
% xlim([10 60])
% %---------------------------------------
% load('matlabData\ApproxCoif2L6CompleteSignalSSA.mat');
% load('matlabData\SST.mat'); load('matlabData\SSA.mat')
% SSt = SplitSandTime;  SSsigcoif = DecomCoif2L6CompSSA(6,:);
% SSsignal = SplitSandAccel;
% idx1 = find(SSt == 10); idx2 = find(SSt == 60);
% idx3 = find(SSt ==90); idx4 = find(SSt ==140);
% DriftingRemove22(SSt,SSsigcoif,SSsignal,idx1,idx2,idx3,idx4);
% %---------------------------------------
% figure(100);
% sig1x = sig1(180:end); sigcoif1x = sigcoif1(180:end);
% t1x = t1(180:end);
% plot(t1x,sig1x*-1); hold on;
% plot(t1x,sigcoif1x*-1,'--','Linewidth',1.5);
% t2x = t2 - 78;
% plot(t2x,sig2*-1); plot(t2x,sigcoif2*-1,'--','Linewidth',1.5)
% xlabel('Time (sec)'); ylabel('Acceleration Gs')
% legend('SS1','SS1 Approx','SS2','SS2 Approx')
% legend('location','NW')
% %---------------------------------------
