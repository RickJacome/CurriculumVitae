function [FGmu1,FGmu2] = FrictionEst(FricCoeff,t,idx1,idx2,idx3,idx4)
% Plot Velocity from Integration + FricCoeff from FilterSwitch
figure; subplot(211)
t1 = t(idx1:idx2); Fric1 = FricCoeff(idx1:idx2);
t2 = t(idx3:idx4); Fric2 = FricCoeff(idx3:idx4);
plot(t1,Fric1);
xlabel('Time sec'); ylabel('Acceleration (Gs)');
subplot(212); plot(t2, Fric2);
xlabel('Time sec'); ylabel('Acceleration (Gs)');
% Fit a 0 degree polynomial through data
p1 = polyfit(t1,Fric1,0);
r1 = polyval(p1,t1);
subplot(211); hold on; plot(t1,r1,'-r');      
p2 = polyfit(t2,Fric2,0);
r2 = polyval(p2,t2);
subplot(212); hold on; plot(t2,r2,'-k');
% Remove all terms below the Coefficient of the Polynomial
indx1 = find(Fric1<p1);
Fric1(indx1) = [];
FGmu1 = mean(Fric1);
Fmean1 = ones(1,numel(t1))*mean(Fric1); 
subplot(211); hold on; plot(t1,Fmean1,'-m');

indx2 = find(Fric2<p2);
Fric2(indx2) = [];
FGmu2 = mean(Fric2);
Fmean2 = ones(1,numel(t2))*FGmu2;
subplot(212); hold on; plot(t2,Fmean2,'-b');
end
        
   

