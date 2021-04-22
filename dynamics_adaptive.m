function dxdt = dynamics_adaptive(t, x, um, ym, time_um,am,bm,a,b,gamma)

um_interp = interp1(time_um, um, t); % Interpolate the data set (time_um, um) at time t
ym_interp = interp1(time_um, ym, t); % Interpolate the data set (time_um, ym) at time t

dxdt(1,1)=x(2);
dxdt(2,1)=-am*x(2)-gamma*am*x(5)*um_interp+gamma*am*ym_interp*um_interp;
dxdt(3,1)=x(4);
dxdt(4,1)=-am*x(4)+gamma*am*x(5)^2-gamma*am*x(5)*ym_interp;
dxdt(5,1)=-a*x(5)+b*x(1)*um_interp-b*x(3)*x(5);

