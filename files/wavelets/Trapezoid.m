close all; clc; clear all

trapezoidal_pulse(1, 0.02, 6, 1.5)
xlim([0,3.5]); ylim([0 9]); grid on;
xlabel('Time (sec)'); ylabel('Magnitude')




function [] = trapezoidal_pulse (rise_time, fall_time, height, length)
pulse = zeros (2, 4);

pulse(1,2)=height;
pulse(1,3)=height;

pulse(2,2)=rise_time;
pulse(2,3)=pulse(2,2)+length;
pulse(2,4)=pulse(2,3)+fall_time;

plot(pulse(2,:),pulse(1,:))
end