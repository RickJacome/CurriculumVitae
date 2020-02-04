close all; clc; clear all
m = 1450;  %Mass kg
g = 9.81; % Gravity m/s^2
L =  2.825; %Wheelbase meters
mu = 1.2; %Coefficient of friction
WD = (40/60); %Weight Distribution
Lf = L/(1+WD);   Lr = L-Lf;
W = m*g;
Cf = 1032; %N/deg Front Cornering Stiffness
Cr = 867;   %N/deg Rear Cornering Stiffness
K =  W*( (Lf/L)*(1/Cf) -  (Lr/L)*(1/Cr) )/g;   %Understeer Gradient (Deg/g's)
ay = mu*g;  %in m/s^2
V = 22.22:.1:36.11;  %50 mph to 80 mph or 80km/h to 130 km/h
% 22.22 m/s to 36.11 m/s
Rho = V.^2/(ay); %Max Rho from Fiction Given Different Velocities 
Ang = 57.3*L./Rho + K.*(ay/g);
plot(V,Ang); grid on;
xlabel('Speed (m/s)'); ylabel('Angle(degrees)'); 


%For multiple Frictions
mu = .1:.1:1;
ay = zeros(1,numel(mu));
V = linspace(22.22,36.11,numel(mu));
figure
MAng = cell(numel(mu),1);
MRho = cell(numel(mu),1);
for m = 1:numel(mu)
        ay(m) = mu(m)*g;
        Rho = V.^2./(ay(m)); MRho{m} = Rho;  
        Ang = 57.3*L./Rho + K.*(ay(m)/g); MAng{m} = Ang;
        txt = ['\mu =', num2str(mu(m))];
        plot(V,Ang,'DisplayName',txt); hold on  
end
xlabel('Speed (m/s)'); ylabel('Angle \delta (degrees)')
grid on; legend show

V = linspace(22.22,36.11,8);
%V = linspace(4, 36,10); % All Ranges from 10 mph to 80 mph
mu = linspace(.1,1,numel(V));
ay = zeros(1,numel(V));
figure
MAng2 = cell(numel(V),1);
MRho2 = cell(numel(V),1);
for k = 1:numel(V)
        ay(k) = mu(k)*g;
        Rho = V.^2./(ay(k));   MRho2{k} = log(Rho)';
        Ang = 57.3*L./Rho + K.*(ay(k)/g);  MAng2{k} = Ang';
        txt = ['V =', num2str(V(k)), 'm/s'];
        figure(3)
        plot(log(Rho),Ang,'DisplayName',txt,'LineWidth',2); hold on 
        figure(4)
        plot(Rho,Ang,'DisplayName',txt,'LineWidth',2); hold on 
end     
figure(3)
xlabel('Log of Radius of Curvature \rho'); ylabel('Angle \delta (degrees)')
grid on; legend show        
figure(4)
xlabel('Radius of Curvature \rho (m) '); ylabel('Angle \delta (degrees)')
grid on; legend show 

%This graph shows that the faster you go, the less radius of curvature 
% and angle of turning you have available 
% This behavior is the same for Varying Friction. (or velocities) 
   
CMRho2 = cell2mat(MRho2); CMAng2 = cell2mat(MAng2);
figure; scatter(CMRho2,CMAng2,'*')

