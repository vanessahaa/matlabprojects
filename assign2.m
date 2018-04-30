clc
clear variables
close all

A = load('temperature_1880_2017.dat');
temp = gettemp(A);

fid = fopen('monthly_in_situ_co2_mlo.csv');
co2 = getco2(fid);
fclose(fid);

% Plotting part 5 (Figure 1) 
figure(1)
subplot(2,1,1)
stem(temp.time, temp.data, 'Linestyle', 'none', 'Marker', '+') 
xlim([min(temp.time) max(temp.time)]); 
title('Temperature anomalies since 1880')
xlabel('time in years')
ylabel('Temp. anomaly (deg. C)')
datetick('x',10)

subplot(2,1,2)
stem(co2.time, co2.data, 'Linestyle', 'none', 'Marker', '+')  
xlim([min(co2.time) max(co2.time)]); 
title('CO2 measurements in ppm since 1958')
xlabel('time in years')
ylabel('CO2 concentration (ppm)')
datetick('x',10)

% 6 Analyzing the CO2 record (Figure 2) 
[comean,codev] = getstats(co2.data,13);     %Used odd number as a window length (1 year)
figure(2) 
subplot(3,1,1) %This graph plots CO2 data vs time
stem(co2.time, co2.data, 'Linestyle', 'none', 'Marker', '+', 'Color', 'green') 
hold on
plot(co2.time,comean,'Color','black')
hold off
xlim([min(co2.time) max(co2.time)]);
title('CO2 measurements in ppm since 1958')
xlabel('time in years')
ylabel('CO2 concentration (ppm)')
datetick('x',10)

subplot(3,1,2) %This graph plots running standard deviation in CO2 vs time 
plot(co2.time,codev)
xlim([min(co2.time) max(co2.time)]);
title('CO2 measurement standard deviation')
xlabel('time in years')
ylabel('standard deviation')
sprintf('Average annual standard deviation in CO2 since 1958 is %f.', mean(codev(~isnan(codev))))
datetick('x',10)

subplot(3,1,3) %This graph plots annual change in CO2 concentration over time 
plot(co2.time(1:end-1),diff(codev))
xlim([min(co2.time) max(co2.time)]);
title('Annual change in CO2 concentration')
xlabel('time in years')
ylabel('annual change (ppm)')
sprintf('Average annual change in CO2 deviation is %f ppm.', mean(diff(codev(~isnan(codev)))))
datetick('x',10)

% 7 Analyzing Temperature record (Figure 3) 
tempdata = temp.data(937:end);
temptime = temp.time(937:end);

[tmpmean,tmpdev] = getstats(tempdata,13);     %Used odd number as a window length (1 year) 
figure(3)
subplot(3,1,1)
stem(temptime, tempdata, 'Linestyle', 'none', 'Marker', '+', 'Color', 'green')
hold on
plot(temptime,tmpmean,'Color','black')
hold off
xlim([min(temptime) max(temptime)]);
title('Temperature anomaly measurements in deg. C since 1958')
xlabel('time in years')
ylabel('Temperature anomaly (deg. C)')
datetick('x',10)

subplot(3,1,2)
plot(temptime,tmpdev)
xlim([min(temptime) max(temptime)]);
title('Temperature anomaly standard deviation')
xlabel('time in years')
ylabel('standard deviation')
datetick('x',10)

subplot(3,1,3)
plot(temptime(1:end-1),diff(tmpdev))
xlim([min(temptime) max(temptime)]);
title('Annual change in temperature anomaly')
xlabel('time in years')
ylabel('annual change (deg. C)')
datetick('x',10)

% Figure 4 - smooth window
tempdata = temp.data(937:end);
temptime = temp.time(937:end);

[tmpmean,tmpdev] = getstats(tempdata,37);     %Used odd number as window length (3 years) Wasn't so sure how smooth it should be, so I chose 3 years instead of 1 year.
figure(4)
subplot(3,1,1)
stem(temptime, tempdata, 'Linestyle', 'none', 'Marker', '+', 'Color', 'green')
hold on
plot(temptime,tmpmean,'Color','black')
hold off
xlim([min(temptime) max(temptime)]);
title('Temperature anomaly measurements in deg. C since 1958')
xlabel('time in years')
ylabel('Temperature anomaly (deg. C)')
datetick('x',10)

subplot(3,1,2)
plot(temptime,tmpdev)
xlim([min(temptime) max(temptime)]);
title('Temperature anomaly standard deviation')
xlabel('time in years')
ylabel('standard deviation')
datetick('x',10)

subplot(3,1,3)
plot(temptime(1:end-1),diff(tmpdev))
xlim([min(temptime) max(temptime)]);
title('Annual change in temperature anomaly')
xlabel('time in years')
ylabel('annual change (deg. C)')
datetick('x',10)