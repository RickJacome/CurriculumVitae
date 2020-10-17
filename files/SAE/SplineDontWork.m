%HERE I am trying to create the Filter of the Centerlines 
clear; close all; clc
%Google Earth Data
load('GPS1Xft.mat'); load('GPS1Yft.mat'); %Data is in Feet
x2 = GPSX; y2 = GPSY;
x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters
%GPS DATA
% load('CVF9LatX.mat'); load('CVF9LongY.mat');
% x2 = LatX'; y2 = LongY'; 
%Ideal AASHTO
%load('MichXm.mat'); load('MichYm.mat');  
%x2 = xm'; y2 = ym';
x2 = unique(x2,'stable'); y2 = unique(y2,'stable');
x2 = x2(1:numel(y2));

xs = min(x2):1:max(x2);
ys = pchip(x2,y2,xs);
figure; plot(x2,y2,'o',xs,ys); axis equal
x2 = xs; y2 = ys;

ys = spline(x2,y2,xs);
figure; plot(x2,y2,'o',xs,ys); axis equal
x2 = xs; y2= ys;

ys = makima(x2,y2,xs);
figure; plot(x2,y2,'o',xs,ys); axis equal
x2 = xs; y2 = ys;