%This example shows how to create an arc trajectory using the 
%waypointTrajectory System object™. waypointTrajectory creates a 
%path through specified waypoints that minimizes acceleration and 
%angular velocity. After creating an arc trajectory, you restrict 
%the trajectory to be within preset bounds.

%Create an Arc Trajectory

%Define a constraints matrix consisting of waypoints, 
%times of arrival, and orientation for an arc trajectory.
%The generated trajectory passes through the waypoints at the specified 
%times with the specified orientation. The waypointTrajectory System 
%object requires orientation to be specified using quaternions or
%rotation matrices. Convert the Euler angles saved in the constrains 
%matrix to quaternions when specifying the Orientation property.

          % Arrival, Waypoints, Orientation
constraints = [0,    20,20,0,    90,0,0;
               3,    50,20,0,    90,0,0;
               4,    58,15.5,0,  162,0,0;
               5.5,  59.5,0,0    180,0,0];

trajectory = waypointTrajectory(constraints(:,2:4), ...
    'TimeOfArrival',constraints(:,1), ...
    'Orientation',quaternion(constraints(:,5:7),'eulerd','ZYX','frame'));

%Call waypointInfo on trajectory to return a table of your 
%specified constraints. The creation properties Waypoints,
%TimeOfArrival, and Orientation are variables of the table. 
%The table is convenient for indexing while plotting.

tInfo = waypointInfo(trajectory)

%The trajectory object outputs the current position, velocity, 
%acceleration, and angular velocity at each call. Call trajectory 
%in a loop and plot the position over time. Cache the other outputs.

figure(1)
plot(tInfo.Waypoints(1,1),tInfo.Waypoints(1,2),'b*')
title('Position')
axis([20,65,0,25])
xlabel('North')
ylabel('East')
grid on
daspect([1 1 1])
hold on

orient = zeros(tInfo.TimeOfArrival(end)*trajectory.SampleRate,1,'quaternion');
vel = zeros(tInfo.TimeOfArrival(end)*trajectory.SampleRate,3);
acc = vel;
angVel = vel;

count = 1;
while ~isDone(trajectory)
   [pos,orient(count),vel(count,:),acc(count,:),angVel(count,:)] = trajectory();

   plot(pos(1),pos(2),'bo')

   pause(trajectory.SamplesPerFrame/trajectory.SampleRate)
   count = count + 1;
end

%Inspect the orientation, velocity, acceleration, and angular
%velocity over time. The waypointTrajectory System object™ creates a
%path through the specified constraints that minimized acceleration 
%and angular velocity.

figure(2)
timeVector = 0:(1/trajectory.SampleRate):tInfo.TimeOfArrival(end);
eulerAngles = eulerd([tInfo.Orientation{1};orient],'ZYX','frame');
plot(timeVector,eulerAngles(:,1), ...
     timeVector,eulerAngles(:,2), ...
     timeVector,eulerAngles(:,3));
title('Orientation Over Time')
legend('Rotation around Z-axis', ...
       'Rotation around Y-axis', ...
       'Rotation around X-axis', ...
       'Location','southwest')
xlabel('Time (seconds)')
ylabel('Rotation (degrees)')
grid on

figure(3)
plot(timeVector(2:end),vel(:,1), ...
     timeVector(2:end),vel(:,2), ...
     timeVector(2:end),vel(:,3));
title('Velocity Over Time')
legend('North','East','Down')
xlabel('Time (seconds)')
ylabel('Velocity (m/s)')
grid on

figure(4)
plot(timeVector(2:end),acc(:,1), ...
     timeVector(2:end),acc(:,2), ...
     timeVector(2:end),acc(:,3));
title('Acceleration Over Time')
legend('North','East','Down','Location','southwest')
xlabel('Time (seconds)')
ylabel('Acceleration (m/s^2)')
grid on

figure(5)
plot(timeVector(2:end),angVel(:,1), ...
     timeVector(2:end),angVel(:,2), ...
     timeVector(2:end),angVel(:,3));
title('Angular Velocity Over Time')
legend('North','East','Down')
xlabel('Time (seconds)')
ylabel('Angular Velocity (rad/s)')
grid on

%Restrict Arc Trajectory Within Preset Bounds

%You can specify additional waypoints to create trajectories
%within given bounds. Create upper and lower bounds for the arc trajectory.

figure(1)
xUpperBound = [(20:50)';50+10*sin(0:0.1:pi/2)';60*ones(11,1)];
yUpperBound = [20.5.*ones(31,1);10.5+10*cos(0:0.1:pi/2)';(10:-1:0)'];

xLowerBound = [(20:49)';50+9*sin(0:0.1:pi/2)';59*ones(11,1)];
yLowerBound = [19.5.*ones(30,1);10.5+9*cos(0:0.1:pi/2)';(10:-1:0)'];

plot(xUpperBound,yUpperBound,'r','LineWidth',2);
plot(xLowerBound,yLowerBound,'r','LineWidth',2)

%To create a trajectory within the bounds, add additional waypoints. 
%Create a new waypointTrajectory System object™, and then call it
%in a loop to plot the generated trajectory. Cache the orientation, 
%velocity, acceleration, and angular velocity output from 
%the trajectory object.

            % Time,  Waypoint,     Orientation
constraints = [0,    20,20,0,      90,0,0;
               1.5,  35,20,0,      90,0,0;
               2.5   45,20,0,      90,0,0;
               3,    50,20,0,      90,0,0;
               3.3,  53,19.5,0,    108,0,0;
               3.6,  55.5,18.25,0, 126,0,0;
               3.9,  57.5,16,0,    144,0,0;
               4.2,  59,14,0,      162,0,0;
               4.5,  59.5,10,0     180,0,0;
               5,    59.5,5,0      180,0,0;
               5.5,  59.5,0,0      180,0,0];

trajectory = waypointTrajectory(constraints(:,2:4), ...
    'TimeOfArrival',constraints(:,1), ...
    'Orientation',quaternion(constraints(:,5:7),'eulerd','ZYX','frame'));
tInfo = waypointInfo(trajectory);

figure(1)
plot(tInfo.Waypoints(1,1),tInfo.Waypoints(1,2),'b*')

count = 1;
while ~isDone(trajectory)
   [pos,orient(count),vel(count,:),acc(count,:),angVel(count,:)] = trajectory();

   plot(pos(1),pos(2),'gd')

   pause(trajectory.SamplesPerFrame/trajectory.SampleRate)
   count = count + 1;
end

%The generated trajectory now fits within the specified boundaries.
%Visualize the orientation, velocity, acceleration, and angular 
%velocity of the generated trajectory.

figure(2)
timeVector = 0:(1/trajectory.SampleRate):tInfo.TimeOfArrival(end);
eulerAngles = eulerd(orient,'ZYX','frame');
plot(timeVector(2:end),eulerAngles(:,1), ...
     timeVector(2:end),eulerAngles(:,2), ...
     timeVector(2:end),eulerAngles(:,3));
title('Orientation Over Time')
legend('Rotation around Z-axis', ...
       'Rotation around Y-axis', ...
       'Rotation around X-axis', ...
       'Location','southwest')
xlabel('Time (seconds)')
ylabel('Rotation (degrees)')
grid on

figure(3)
plot(timeVector(2:end),vel(:,1), ...
     timeVector(2:end),vel(:,2), ...
     timeVector(2:end),vel(:,3));
title('Velocity Over Time')
legend('North','East','Down')
xlabel('Time (seconds)')
ylabel('Velocity (m/s)')
grid on

figure(4)
plot(timeVector(2:end),acc(:,1), ...
     timeVector(2:end),acc(:,2), ...
     timeVector(2:end),acc(:,3));
title('Acceleration Over Time')
legend('North','East','Down')
xlabel('Time (seconds)')
ylabel('Acceleration (m/s^2)')
grid on

figure(5)
plot(timeVector(2:end),angVel(:,1), ...
     timeVector(2:end),angVel(:,2), ...
     timeVector(2:end),angVel(:,3));
title('Angular Velocity Over Time')
legend('North','East','Down')
xlabel('Time (seconds)')
ylabel('Angular Velocity (rad/s)')
grid on

%Note that while the generated trajectory now fits within
%the spatial boundaries, the acceleration and angular velocity
%of the trajectory are somewhat erratic. 
%This is due to over-specifying waypoints.