close all; clc; clear all
emax = 4;
fmax = 0:.01:.50;

Rmin = 42;
V = sqrt(Rmin*(15*(0.01*emax + fmax)));


plot(V,fmax)

