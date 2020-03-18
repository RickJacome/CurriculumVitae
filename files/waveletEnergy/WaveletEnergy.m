%%Coilet Analysis 
clc; close all; clear all
load('FCA.mat')
format compact
Signal = FullConcreteAccel;

for k = 1:6
        coi(k) = EnergyShanonRatio(Signal,k,'coif1');
        ha(k) = EnergyShanonRatio(Signal,k,'haar');
        db(k) = EnergyShanonRatio(Signal,k,'db1');
        dm(k) = EnergyShanonRatio(Signal,k,'dmey');
end
    R = [coi; ha; db; dm]
%  EnergyShanonRatio(Signal,5,'coif1')
%  EnergyShanonRatio(Signal,5,'haar')
%  EnergyShanonRatio(Signal,5,'db1')
%  EnergyShanonRatio(Signal,5,'dmey')