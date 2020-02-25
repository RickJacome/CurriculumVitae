function [FGmu1,FGmu2] = FrictionEst(FricCoeff,v,idx1,idx2,idx3,idx4)
% Plot Velocity from Integration + FricCoeff from FilterSwitch
figure; subplot(211)
v1 = v(idx1:idx2); Fric1 = FricCoeff(idx1:idx2);
v2 = v(idx3:idx4); Fric2 = FricCoeff(idx3:idx4);
plot(v1,Fric1);
xlabel('Velocity m/s'); ylabel('Acceleration Gs');
subplot(212); plot(v2, Fric2);
xlabel('Velocity m/s'); ylabel('Acceleration Gs');
% Fit a 0 degree polynomial through data
p1 = polyfit(v1,Fric1',0);
r1 = polyval(p1,v1);
subplot(211); hold on; plot(v1,r1);      
p2 = polyfit(v2,Fric2',0);
r2 = polyval(p2,v2);
subplot(212); hold on; plot(v2,r2);
% Remove all terms below the Coefficient of the Polynomial
indx1 = find(Fric1<p1);
Fric1(indx1) = [];
FGmu1 = mean(Fric1);
Fmean1 = ones(1,numel(v1))*mean(Fric1); 
subplot(211); hold on; plot(v1,Fmean1);

indx2 = find(Fric2<p2);
Fric2(indx2) = [];
FGmu2 = mean(Fric2);
Fmean2 = ones(1,numel(v2))*FGmu2;
subplot(212); hold on; plot(v2,Fmean2);
end
        
   

