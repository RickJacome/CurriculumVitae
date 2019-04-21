clear all; clc; close all; format compact
load('R1.mat'); load('R2.mat'); load('R3.mat'); load('R4.mat');
A1x = R1.AX; A1y = R1.AY; A1z = R1.AZ;
Ang1x = R1.AngleX; Ang1y = R1.AngleY; Ang1z = R1.AngleZ;

figure(1);
plot(A1x,'LineWidth',2); hold on; 
plot(A1y,'LineWidth',2); plot(A1z,'LineWidth',2);
plot(Ang1x,'LineWidth',2); plot(Ang1y,'LineWidth',2); 
plot(Ang1z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 1'); xlabel('Sample');

A2x = R2.AX; A2y = R2.AY; A2z = R2.AZ;
Ang2x = R2.AngleX; Ang2y = R2.AngleY; Ang2z = R2.AngleZ;
figure(2); 
plot(A2x,'LineWidth',2); hold on;
plot(A2y,'LineWidth',2); plot(A2z,'LineWidth',2);
plot(Ang2x,'LineWidth',2); plot(Ang2y,'LineWidth',2);
plot(Ang2z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 2'); xlabel('Sample');

A3x = R3.AX; A3y = R3.AY; A3z = R3.AZ;
Ang3x = R3.AngleX; Ang3y = R3.AngleY; Ang3z = R3.AngleZ;
figure(3); 
plot(A3x,'LineWidth',2); hold on;
plot(A3y,'LineWidth',2); plot(A3z,'LineWidth',2);
plot(Ang3x,'LineWidth',2); plot(Ang3y,'LineWidth',2);
plot(Ang3z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 3'); xlabel('Sample');

A4x = R4.AX; A4y = R4.AY; A4z = R4.AZ;
Ang4x = R4.AngleX; Ang4y = R3.AngleY; Ang4z = R4.AngleZ;
figure(4); 
plot(A4x,'LineWidth',2); hold on;
plot(A4y,'LineWidth',2); plot(A4z,'LineWidth',2);
plot(Ang4x,'LineWidth',2); plot(Ang4y,'LineWidth',2);
plot(Ang4z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 4'); xlabel('Sample');

close all

figure(5); hold on;
plot(A1x,'LineWidth',2); plot(A2x,'LineWidth',2);
plot(A3x,'LineWidth',2); plot(A4x,'LineWidth',2);  
legend('Test 1','Test 2','Test 3','Test 4');
figure(6); hold on;
plot(A1y,'LineWidth',2); plot(A2y,'LineWidth',2);
plot(A3y,'LineWidth',2); plot(A4y,'LineWidth',2);
legend('Test 1','Test 2','Test 3','Test 4');
figure(7); hold on;
plot(A1z,'LineWidth',2); plot(A2z,'LineWidth',2);
plot(A3z,'LineWidth',2); plot(A4z,'LineWidth',2); 
legend('Test 1','Test 2','Test 3','Test 4');
figure(8); hold on;
plot(Ang1x,'LineWidth',2); plot(Ang2x,'LineWidth',2);
plot(Ang3x,'LineWidth',2); plot(Ang4x,'LineWidth',2);
legend('Test 1','Test 2','Test 3','Test 4');
figure(9); hold on;
plot(Ang1y,'LineWidth',2); plot(Ang2y,'LineWidth',2);
plot(Ang3y,'*','LineWidth',2); plot(Ang4y,'LineWidth',2);
legend('Test 1','Test 2','Test 3','Test 4');
figure(10); hold on;
plot(Ang1z,'LineWidth',2); plot(Ang2z,'LineWidth',2);
plot(Ang3z,'LineWidth',2); plot(Ang4z,'LineWidth',2); 
legend('Test 1','Test 2','Test 3','Test 4');
