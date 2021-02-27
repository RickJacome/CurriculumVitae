clc; clear all; close all
load('K.mat')
K = K_vector;
 g = 9.81;
 
 
% v = linspace(30,38, numel(K));
% [V,Ka] = meshgrid(v,K);
% a = V.^2.*Ka/g;
% 
% surf(V,Ka,a)
% colorbar
% view(90,90)

e = 4;
mu = linspace(0.1,0.9, numel(K));
[MU,Ka] = meshgrid(mu,K);

v = sqrt( ((MU - 0.01*e)./(1 - 0.01.*MU.*e)).*g./Ka);

surf(MU,Ka,v); xlabel('mu'); ylabel('kappa'); zlabel('v')
colorbar; view(90,90)

figure
surf(MU,Ka,v); xlabel('mu'); ylabel('kappa'); zlabel('v')
colorbar; view(0,90)

figure
surf(MU,Ka,v); xlabel('mu'); ylabel('kappa'); zlabel('v')
colorbar; view(0,0)

e = 4; mu = 0.4;
K = linspace(0,max(K),numel(K));

v1 = sqrt(mu.*g./K);
figure; plot(K,v1); 
v2 = sqrt((g./K).*(mu + 0.01*e)/(1-0.01*mu*e));

hold on; plot(K,v2);
xlabel('K'); ylabel('v');
legend('e = 0',' e\neq0')

mu = 0.1:.1:.9;

figure;
for i = 1:2:numel(mu)

v2 = sqrt((g./K).*(mu(i) + 0.01*e)/(1-0.01*mu(i)*e));
txt = ['e = 0, \mu =', num2str(mu(i))];
plot(K,v2,'DisplayName',txt); hold on;
end

grid on; legend show
xlabel('K'); ylabel('v');

%figure;
for i = 1:2:numel(mu)

v2 = sqrt((g./K).*mu(i));
txt = ['e\neq0, \mu =', num2str(mu(i))];
plot(K,v2,'--','DisplayName',txt); hold on;
end
ylim([0 70])
grid on; legend show
xlabel('K'); ylabel('v');















