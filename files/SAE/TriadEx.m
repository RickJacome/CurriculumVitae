clc; clear all; close all;

figure;
plot3([0,1],[0,0],[0,0],'Color',[1,0,0]); hold on
plot3([0,0],[0,1],[0,0],'Color',[0,1,0]);
plot3([0,0],[0,0],[0,1],'Color',[0,0,1]);

figure
t = 0:pi/50:10*pi;
plot3(sin(t),cos(t),t);