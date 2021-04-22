% MATLAB simulation of a model reference adaptive controller
% Author: Aleksandar Haber 
% Date: April 21, 2021

clear, pack, clc

% reference model parameters

am=2
bm=2

% plant parameters (that are unknown during control design)
a=1
b=0.5 

%  final values of the parameters for verification of convergence
theta1final=bm/b
theta2final=(am-a)/b

% reference model
Wm=tf([bm],[1 am])

tmax=100 % max simulation time
time=0:0.001:tmax;   %time vector 

% define a reference input signal
pulsew = 10; %pulse width
delayop= pulsew/2:pulsew*2:tmax; %delay vector
% reference input
ur=2*pulstran(time,delayop,'rectpuls',pulsew)-1; 

% input reference signal
figure(1)
plot(time,ur); 
set(gca,'Ylim',[-1.5 1.5]);

% output reference signal
yr=lsim(Wm,ur,time)

figure(2)
plot(time,yr,'r')
hold on
plot(time,ur,'k')


% initial condition
x0=zeros(5,1);
% gain
gamma2=0.5;

[time1 state_trajectories] = ode45(@(t,x) dynamics_adaptive(t, x, ur, yr, time,am,bm,a,b,gamma2), time, x0);

theta1=state_trajectories(:,1)
theta2=state_trajectories(:,3)
y=state_trajectories(:,5)


figure(3)
plot(time,yr,'k')
hold on
plot(time,y,'m')

figure(4)
plot(time,theta1,'k')
hold on 
plot(time,theta2,'m')



