clc; clear all; close all;
load('errordiffSentra1.mat'); edS1 = errordiff;
load('errordiffSentra2.mat'); edS2 = errordiff;
load('errordiffAltima1.mat'); edA1 = errordiff;
load('errordiffAltima2.mat'); edA2 = errordiff;
load('errordiffElantra1.mat'); edE1 = errordiff;
load('errordiffElantra2.mat'); edE2 = errordiff;

M = [edS1 edS2 edA1 edA2 edE1 edE2];
[J,I] = size(M)
X1 = mean(edS1); X2 = mean(edS2);
X3 = mean(edA1); X4 = mean(edA2);
X5 = mean(edE1); X6 = mean(edE2);
Xgm = (X1+X2+X3+X4+X5+X6)/I;

S1 = std(edS1); S2 = std(edS2);
S3 = std(edA1); S4 = std(edA2);
S5 = std(edE1); S6 = std(edE2);
MSE = (1/I)*(S1^2 + S2^2 + S3^2 + S4^2 + S5^2 + S6^2);
MSTr = (J/(I-1))*( (X1-Xgm)^2 + (X2-Xgm)^2 +...
    (X3-Xgm)^2 + (X4-Xgm)^2 + (X5-Xgm)^2 + (X6-Xgm)^2 );

v1 = I-1
v2 = I*(J-1)
F = MSTr/MSE
% F at .05 significance, v1 = 5 and v2 = 594
% yieds F = 2.6 for about 0.047911
MeanTable = [X1 X2 X3 X4 X5 X6];
stdTable = [S1 S2 S3 S4 S5 S6];
% Total sum of sums
xdd = sum(sum(M))
xij = sum(sum(M.^2))
SST = xij - (1/(I*J))*xdd^2


M =[0.56  1.12 0.90 1.07 0.94;...
    0.72  0.69 0.87 0.78 0.91;...
    0.62  1.08 1.07 0.99 0.93];
M = transpose(M);
[J, I] = size(M);
xdd = sum(sum(M))
xij = sum(sum(M.^2))
SST = xij - (1/(I*J))*xdd^2
xid = sum(sum(M).^2)
SSTr = (1/J)*xid - (1/(I*J))*xdd^2
SSE = SST-SSTr
