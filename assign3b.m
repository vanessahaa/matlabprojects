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
sy0_val=zeros(1,10);
sy0_val(1)=sy0; %store initial sy0
[acc,vel,pos]=get_traj(sx0,sy0,ux0,uy0,dt,tf); %calculate accelaration,velocity and position
closest_alt(1)=min(sqrt(pos(:,1).^2 +pos(:,2).^2)-Rm); %store initial closest altitude
 
for i=2:10
sy0=2*sy0; %double sy0
tf=2*tf;%double tf
[acc,vel,pos]=get_traj(sx0,sy0,ux0,uy0,dt,tf); %calculate accelaration,velocity and position
sy0_val(i)=sy0; %store syo value of each step
closest_alt(i)=min(sqrt(pos(:,1).^2 +pos(:,2).^2)-Rm);%closest altitude for every sy0
end
 
k=table(sy0_val',closest_alt','VariableNames',{'sy0_values' 'closest_altitude'})%create table for sy0 values and closest altitude in S.I units
writetable(k,'sy0.txt','Delimiter','\t') %write table to text file
 


