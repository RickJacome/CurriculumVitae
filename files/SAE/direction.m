function [O1,O2] = direction(K2)
    %Orthogonal Shift Function 
     O1 = atand(K2(:,2)./K2(:,1));  %Angle in Degrees
     %O1 = atan2d(K2(:,2),K2(:,1)); 
     %; + 360*(K2(:,2)<0);
     O2 = O1 - 90;   % If traveling southbound
     %O2 = O1 + 90;   % If traveling northbound
end