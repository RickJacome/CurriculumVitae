function [Th,n] = DiscInteg(K2,L2)
%Discrete Integration Function
S = L2;
%K = K2(:,2)-K2(:,1);

K = sqrt((K2(:,2).^2+K2(:,1).^2));
n = numel(S);
%% Leave everything below
Th  = zeros(1,n);   D  = zeros(1,n);
for k = 2:n-1 
   Th(k+1) =  ( (S(k+1)-S(k))*((K(k+1)+K(k))/2) ) + Th(k) ; 
end

for k = 2:n-1 
   D(k+1) =  ( (S(k+1)-S(k))*((Th(k+1)+Th(k))/2) ) + D(k) ; 
end
% figure(3)
% plot(S(1:n),Th)
% xlabel('Segment S'); ylabel('Angle \theta')
% title('Numerically Integrated \theta')
% figure(4)
% plot(S(1:n),D)
% xlabel('Segment S'); ylabel('Integrated Angle')
% title('Numerically Integrated Angle')
end
