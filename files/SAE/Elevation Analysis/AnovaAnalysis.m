clc; clear all; close all;
load('errordiffSentra1.mat'); edS1 = errordiff;
load('errordiffSentra2.mat'); edS2 = errordiff;
load('errordiffAltima1.mat'); edA1 = errordiff;
load('errordiffAltima2.mat'); edA2 = errordiff;
load('errordiffElantra1.mat'); edE1 = errordiff;
load('errordiffElantra2.mat'); edE2 = errordiff;

M = [edS1'; edS2'; edA1'; edA2'; edE1'; edE2']