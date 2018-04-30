clc
clear variables
close all

%% PART 2
load('Drifter_dataset.mat')
C=load('BCcstlne.mat');

dlon = 72.8e3;        % defines 1 degree of longitude ~ 72.8km
dlat = 111e3;         % defines 1 degree of latitude ~ 111km
dtime = 24*60*60;     % defines time constant - days to seconds

%% Draw map 
subplot('Position',[0.3 0.51 0.45 0.45])
for k=1:length(C.k)-1
    ii=C.k(k)+1:C.k(k+1)-1;
    patch(C.ncst(ii,1),C.ncst(ii,2),[0 .5 0],'FaceColor',[0.5 0.5 0.5],'edgecolor','none');
end

%% Calculate INSTANTANEOUS and DISPERSION speeds

red = 0;                                    % number of drifters in each zone
cyan = 0;
green = 0;
black = 0;
dispfin = zeros(numel(drifter.mtime),1);    % final dispersion speed of drifters

for k = 1:113
    
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
    set(gca,'box','on')
    set(gca,'tickdir','out')
    title('All tracks')
    xlabel('Longitude')
    ylabel('Lattitude')
    hold on
    
    dispfin(k) = disp(end);                 % final dispersion speed of each drifter
    
    if drifter.lat{k}(end) < 48.78 || (drifter.lat{k}(end) < 49.1 && drifter.long{k}(end) < -124)
        red = red+1;
        plot(drifter.long{k},drifter.lat{k}, 'red')
        plot(drifter.long{k}(end),drifter.lat{k}(end), 'red','Marker','o')
        
        subplot(2,2,3)
        line(X,N/(sum(N)*xx),'color','red')
        
        subplot(2,2,4)
        loglog(dt1/dtime,disp,'color','red')
        hold on
    elseif drifter.lat{k}(end) >= 48.78 && drifter.lat{k}(end) <= 49.1
        cyan = cyan+1;
        plot(drifter.long{k},drifter.lat{k}, 'cyan')
        plot(drifter.long{k}(end),drifter.lat{k}(end), 'cyan','Marker','o')
        
        subplot(2,2,3)
        line(X,N/(sum(N)*xx),'color','cyan')
        
        subplot(2,2,4)
        loglog(dt1/dtime,disp,'color','cyan')
        hold on
    elseif drifter.long{k}(end) < -123.7
        green = green+1;
        plot(drifter.long{k},drifter.lat{k}, 'green')
        plot(drifter.long{k}(end),drifter.lat{k}(end), 'green','Marker','o')
        
        subplot(2,2,3)
        line(X,N/(sum(N)*xx),'color','green')
        
        subplot(2,2,4)
        loglog(dt1/dtime,disp,'color','green')
        hold on
    else
        black = black+1;
        plot(drifter.long{k},drifter.lat{k}, 'black')
        plot(drifter.long{k}(end),drifter.lat{k}(end), 'black','Marker','o')
        
        subplot(2,2,3)
        line(X,N/(sum(N)*xx),'color','black')
        
        subplot(2,2,4)
        loglog(dt1/dtime,disp,'color','black')
        hold on
        
    end
end

subplot(2,2,3)                              % subplot cosmetic modifications
set(gca,'box','on')
set(gca,'tickdir','out')
xlabel('Instantaneous speed U/(m/s)')
ylabel('P(u)')

subplot(2,2,4)                              % subplot cosmetic modifications
ylim([1e-2 5])
xlim([1e-2 30])
xlabel('Time/days')
ylabel('Dispersion speed/(m/s)')

figure()                                    % construct probabilitz density function of dispersion speeds
[N,X]=hist(dispfin,0:0.04:1);
line(X,N/(sum(N)))
title('Probability density function of the dispersion speed for all drifters')
xlabel('Dispersion speed U/(m/s)')
ylabel('P(u)')
set(gca,'box','on')
set(gca,'tickdir','out')

%% answer assignment questions
sprintf('%d drifters leave the strait, %d drifters end up in southern part of the strait, %d drifters end up in northern part of the strait and %d drifters end up in central part of the strait',red,cyan,green,black)
sprintf('Average drift speed (as estimated by final data) is %f m/s',sum(dispfin)/numel(dispfin))
