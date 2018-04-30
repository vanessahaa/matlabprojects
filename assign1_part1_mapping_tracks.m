clc
clear variables
close all

k = 28;                                 % define track number

load('Drifter_dataset.mat')
C=load('BCcstlne.mat');

dlon = 72.8e3;        % define 1 degree of longitude ~ 72.8km
dlat = 111e3;         % define 1 degree of latitude ~ 111km
dtime = 24*60*60;     % define time constant - days to seconds

%% Draw the map
subplot('Position',[0.3 0.51 0.45 0.45])
for q=1:length(C.k)-1
    ii=C.k(q)+1:C.k(q+1)-1;
    patch(C.ncst(ii,1),C.ncst(ii,2),[0 .5 0],'FaceColor',[0.5 0.5 0.5],'edgecolor','none');
end

%% Calculate INSTANTANEOUS and DISPERSION speeds

dx = diff(drifter.lat{k})*dlat;         % distance difference in meters, X axis
dy = diff(drifter.long{k})*dlon;        % distance difference in meters, Y axis
dt = diff(drifter.mtime{k})*dtime;      % time difference between measurements
inst = sqrt(dx.^2+dy.^2)./dt;           % calculate instantaneous speed

xx=0.1;
[N,X]=hist(inst,0:xx:2.5);              % construct the histogram

dx1 = (drifter.lat{k}(2:end)-drifter.lat{k}(1))*dlat;           % distance traveled in meters, X axis
dy1 = (drifter.long{k}(2:end)-drifter.long{k}(1))*dlon;         % distance traveled in meters, Y axis
dt1 = (drifter.mtime{k}(2:end)-drifter.mtime{k}(1))*dtime;      % time elapsed
disp = sqrt(abs(dx1.^2+dy1.^2))./dt1;                           % calculate dispersion speed


%% Plot single track
subplot('Position',[0.3 0.51 0.45 0.45])
hold on

if drifter.lat{k}(end) < 48.78  || (drifter.lat{k}(end) < 49.1 && drifter.long{k}(end) < -124)
    plot(drifter.long{k},drifter.lat{k}, 'red')
    title(['Track ', num2str(k),' - leaves Strait of Georgia'])
    plot(drifter.long{k}(end),drifter.lat{k}(end), 'red','Marker','o')
    
    subplot(2,2,3)
    line(X,N/(sum(N)*xx),'color','red')
    
    subplot(2,2,4)
    loglog(dt1/dtime,disp,'color','red')
    hold on
elseif drifter.lat{k}(end) >= 48.78 && drifter.lat{k}(end) <= 49.1
    plot(drifter.long{k},drifter.lat{k}, 'cyan')
    title(['Track ', num2str(k),' - southern Strait of Georgia'])
    plot(drifter.long{k}(end),drifter.lat{k}(end), 'cyan','Marker','o')
    
    subplot(2,2,3)
    line(X,N/(sum(N)*xx),'color','cyan')
    
    subplot(2,2,4)
    loglog(dt1/dtime,disp,'color','cyan')
    hold on
elseif drifter.long{k}(end) < -123.7
    plot(drifter.long{k},drifter.lat{k}, 'green')
    title(['Track ', num2str(k),' - northern Strait of Georgia'])
    plot(drifter.long{k}(end),drifter.lat{k}(end), 'green','Marker','o')
    
    subplot(2,2,3)
    line(X,N/(sum(N)*xx),'color','green')
    
    subplot(2,2,4)
    loglog(dt1/dtime,disp,'color','green')
    hold on
else
    plot(drifter.long{k},drifter.lat{k}, 'black')
    title(['Track ', num2str(k),' - central Strait of Georgia'])
    plot(drifter.long{k}(end),drifter.lat{k}(end), 'black','Marker','o')
    
    subplot(2,2,3)
    line(X,N/(sum(N)*xx),'color','black')
    
    subplot(2,2,4)
    loglog(dt1/dtime,disp,'color','black')
    hold on
end

subplot(2,2,3)                          % subplot cosmetic modifications
set(gca,'box','on')
set(gca,'tickdir','out')
xlabel('Instantaneous speed U/(m/s)')
ylabel('P(u)')

subplot(2,2,4)                          % subplot cosmetic modifications
ylim([1e-2 5])
xlim([1e-2 30])
xlabel('Time/days')
ylabel('Dispersion speed/(m/s)')
