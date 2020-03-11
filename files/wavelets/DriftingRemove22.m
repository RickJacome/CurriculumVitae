function [] = DriftingRemove22(t,sigcoif,signal,idx1,idx2,idx3,idx4)
% First Event
figure; 
%idx1 = find(t ==0); idx2 = find(t ==60);
sig1 = signal(idx1:idx2);
sigcoif1 = sigcoif(idx1:idx2);
t1 = t(idx1:idx2);
subplot(211); plot(t1,sig1,t1,sigcoif1)
legend('Original Signal','Coiflet Signal')
% Second Event
%idx3 = find(t ==130); idx4 = find(t ==180);
sig2 = signal(idx3:idx4);
sigcoif2 = sigcoif(idx3:idx4);
t2 = t(idx3:idx4);
subplot(212); plot(t2,sig2,t2,sigcoif2)
legend('Original Signal','Coiflet Signal')
% Add Section RJ34.4 Here
% % --------------------------------------
figure(100);
sig1x = sig1(1:end);
sigcoif1x = sigcoif1(1:end);
t1x = t1(1:end);
plot(t1x,sig1x*-1); hold on;
plot(t1x,sigcoif1x*-1,'--','Linewidth',1.5); 
sig2x = sig2(470:end);
sigcoif2x = sigcoif2(470:end);
t2x = t2(470:end) - 136;
plot(t2x,sig2x*-1); 
plot(t2x,sigcoif2x*-1,'--','Linewidth',1.5)
xlabel('Time (sec)'); ylabel('Acceleration Gs')
legend('SG1','SG1 Approx','SG2','SG2 Approx')
legend('location','NW')
xlim([10 60])
% % --------------------------------------
% End of Section RJ34.4

g = 9.81;   
%----
% Cubic Spline Interpolation + Simpsons Quadrature Scheme
tq1 = t1(1):.01:t1(end);
yy1 = spline(t1,sig1*g,tq1);
yyc1 = spline(t1,sigcoif1*g,tq1);
[v1,d1,n1] = DiscIntegSims(t1,yy1);
[vc1,dc1,nc1] = DiscIntegSims(t1,yyc1);
figure; subplot(211); plot(tq1,v1,'Linewidth',1.5); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
hold on; plot(tq1,vc1,'--','Linewidth',2); grid on;
legend('Original Integrated Signal','Coiflet Integrated Signal')
legend('location','NW')
%figure; plot(t1,d1); grid on;
%xlabel('Time (sec)'); ylabel('Distance m')
%----
% Cubic Spline Interpolation + Simpsons Quadrature Scheme
tq2 = t2(1):.01:t2(end);
yy2 = spline(t2,sig2*g,tq2);
yyc2 = spline(t2,sigcoif2*g,tq2);
[v2,d2,n2] = DiscIntegSims(t2,yy2);
[vc2,dc2,nc2] = DiscIntegSims(t2,yyc2);
subplot(212); plot(tq2,v2,'Linewidth',1.5); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
hold on; plot(tq2,vc2,'--','Linewidth',2); grid on;
legend('Original Integrated Signal','Coiflet Integrated Signal')
legend('location','NW')
%figure; plot(t2,d2); grid on;
%xlabel('Time (sec)'); ylabel('Distance m')
%----
end