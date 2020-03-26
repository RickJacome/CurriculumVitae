function [outputsignal,outputtime] = ZeroEtClean(DirtySignal,DirtyTime)

% To Zero Signal, Subtract Average of the Beginning Data
y = mean(DirtySignal(1:1000));
ZeroedSignal = DirtySignal-y;
% To Get Rid of NaN, Replace them by blanks
idx = isnan(ZeroedSignal);
ZeroedSignal(idx ==1) = [];
DirtyTime(idx == 1) = [];
outputsignal = ZeroedSignal;
outputtime = DirtyTime;
end
