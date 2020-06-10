clc; clear all; close all;
H = tf([1 0.1 7.5],[1 0.12 9 0 0]);
bode(H)