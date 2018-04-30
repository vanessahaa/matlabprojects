global Mp Rm G %declare global variables 
%Mp=Mass of mercury,Rm=Radius of Mercury,G=Gravitational constant
Mp=3.3*10^23; %Mass of planet(Mercury) in S.I.
Rm=2440000; %Radius of planet (Mercury)in S.I.
tf=40*60; %time final in S.I.
dt=60; %time step in second 
sx0=-3050000; %initial sx in m
sy0=-3*Rm; %initial sy in m
s=[sx0 sy0]; %initial position vector
uy0=7000; %initial uy in m/s
ux0=sin(0);% initial ux in m/s
u=[ux0 uy0]; %initial velocity vector
G=6.67*10^-11; %Gravitanional constant in S.I.

[acc,vel,pos]=get_traj(sx0,sy0,ux0,uy0,dt,tf); %calculate accelaration,velocity and position
t=0:dt/60:tf/60; %create time array (minutes) for plot

figure(1)
theta=0:360; %theta values for plotting the planet
x=Rm*cosd(theta)/1000; %x polar coordinate for planet
y=Rm*sind(theta)/1000;%y polar coordinate for planet
plot(pos(:,1)/1000,pos(:,2)/1000,'r *',x,y)
grid on
xlim([-8000 8000])
ylim([-9000 10000])
xlabel('x-axis (km)')
ylabel('y-axis (km)')

figure(2)
subplot(3,1,1) %subplot for acc vs t
plot(t,acc(:,1),'r --',t,acc(:,2),'g --',t,sqrt(acc(:,1).^2+acc(:,2).^2),'b --')
ylim([-2 4])
xlabel('time (min)')
ylabel('accelaration m/s^2')
title('Accelaration due to Gravitational Force')
legend('ax','ay','|a|')

subplot(3,1,2) %subplot for u vs t
plot(t,(sqrt(vel(:,1).^2+vel(:,2).^2))/1000,'k --')
ylabel('u (km/s)')
xlabel('time (min)')
title('Spacecraft speed')

subplot(3,1,3) %subplot s-Rm vs t
plot(t,(sqrt(pos(:,1).^2+pos(:,2).^2))/1000,'g --')
ylim([100 10000])
xlabel('time (min)')
ylabel('altitude(km)')
title('Spacecraft Altitude')
 
 


