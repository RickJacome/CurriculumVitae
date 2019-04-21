close all; format compact; clc;
A1x = R1.Ax; A1y = R1.Ay; A1z = R1.Az;
Ang1x = R1.Angx; Ang1y = R1.Angy; Ang1z = R1.Angz;

figure(1); 
plot(A1x); hold on; plot(A1y); plot(A1z);
plot(Ang1x); plot(Ang1y); plot(Ang1z);

A2x = R2.Ax; A2y = R2.Ay; A2z = R2.Az;
Ang2x = R2.Angx; Ang2y = R2.Angy; Ang2z = R2.Angz;
figure(2); 
plot(A2x); hold on; plot(A2y); plot(A2z);
plot(Ang2x); plot(Ang2y); plot(Ang2z);

A3x = R3.Ax; A3y = R3.Ay; A3z = R3.Az;
Ang3x = R3.Angx; Ang3y = R3.Angy; Ang3z = R3.Angz;
figure(3); 
plot(A3x); hold on; plot(A3y); plot(A3z);
plot(Ang3x); plot(Ang3y); plot(Ang3z);

A4x = R4.Ax; A4y = R4.Ay; A4z = R4.Az;
Ang4x = R4.Angx; Ang4y = R3.Angy; Ang4z = R4.Angz;
figure(4); 
plot(A4x); hold on; plot(A4y); plot(A4z);
plot(Ang4x); plot(Ang4y); plot(Ang4z);