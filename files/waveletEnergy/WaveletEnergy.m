%%Coilet Analysis 
clc; close all; clear all
load('FCA.mat')
format compact
Signal = FullConcreteAccel;
s = 1e2; wv = 'db2';
MaxDecompLevel = wmaxlev(s,wv)

for k = 1:MaxDecompLevel
        ha(k) = EnergyShanonRatio(Signal,k,'haar');
        coi(k) = EnergyShanonRatio(Signal,k,'coif2');
        db(k) = EnergyShanonRatio(Signal,k,'db2');
        dm(k) = EnergyShanonRatio(Signal,k,'dmey');
        sy(k) = EnergyShanonRatio(Signal,k,'sym2');        
end
    R = [ha; coi; db; dm; sy]
T = table(abs(ha'), abs(coi'), abs(db'), abs(dm'), abs(sy'));
filename = 'DecompLevelEnergy.xlsx';
writetable(T,filename,'Sheet',1,'Range','B1')
% The highest Level of Energy Ratio is Coiflet

% [ERatio1] = RelativeEnergy(Signal,'coif1')
% [ERatio2] = RelativeEnergy(Signal,'coif2')
% [ERatio3] = RelativeEnergy(Signal,'coif3')
% [ERatio4] = RelativeEnergy(Signal,'coif4')
% [ERatio5] = RelativeEnergy(Signal,'coif5')


