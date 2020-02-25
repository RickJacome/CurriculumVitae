function [Sig2] = FilterSwitch(Thrs,WdwSize,Signal,t)
Signal =  Signal(6,:)*-1;
windowSize = WdwSize; % Relate this to frequency
kernel = (1/windowSize)*ones(1,windowSize);
%Coefficients of Rational Transfer Function
% a = 1
out = filter(kernel, 1, Signal);
% Plot 1-D Filter with a Window Size of 100
figure
subplot(211)
plot(t,out); grid on; hold on
xlabel('Time (sec)'); ylabel('Acceleration (Gs)');
title('Acceleration Profile Coiflet + Moving Average Filter')
% Detect When the Average Changes Drastically
n = numel(Signal);  o = zeros(n,1);
threshold = Thrs;
Sig1 = zeros(n,1);
Sig2 = zeros(n,1);
for i = 1:n-1
        if  mean([Signal(i),Signal(i+1)]) < threshold  
          o(i) = 0;
          Sig1(i) = Signal(i);
        else  
          o(i) = 1;  
          Sig2(i) = Signal(i);
        end      
end
plot(t,o)
legend('Moving Window Filtered','Average Switch')
legend('location','SE')
subplot(212)
plot(t,Sig1); hold on; plot(t,Sig2); grid on;
xlabel('Time (sec)'); ylabel('Acceleration (Gs)');
title('Detection of Coefficient of Friction Profiles')