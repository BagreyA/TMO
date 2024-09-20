clc 
clear 
close all 

%% Task ¹9
for i = 2:300
    for k = 1:600
        w(1,k) = 0;
        w(i,k)=0.9*w(i-1,k)+normrnd(0,1);
    end
end
figure('Name','Weiner process','NumberTitle','off');
plot(w);
title('All realisations of attenuation weiner process');

clear i k

figure('Name','Sctarret diogram','NumberTitle','off');
subplot(2,1,1);

X = [10, 50, 100, 200];
Y = [9, 49, 99, 199];
for i = 1:4
    x =w(X(i),:);
    y =w(Y(i),:);
    c = linspace(1,10,length(x));
    scatter(x,y,[],c);
    title('Scatter (10,9) (50,49) (100,99) (200,199)');
    xlabel('X');
    ylabel('Y');
    ylim([-10 20]);
    xlim([-10 10]);
    hold on;
end
subplot(2,1,2);

X = [50, 100, 200];
Y = [40, 90, 190];
for i = 1:3
    x =w(X(i),:);
    y =w(Y(i),:);
    c = linspace(1,10,length(x));
    scatter(x,y,[],c);
    title('Scatter (50,40) (100,90) (200,190)');
    xlabel('X');
    ylabel('Y');
    ylim([-10 20]);
    xlim([-10 10]);
    hold on;
end
clear X Y x y i c
%% Task ¹10
for i = 1:300
    w1 = circshift(w,1);
    W = w.*w1;
    ACF(1,i) = mean(W(i,:));
end
figure()
plot(ACF);
hold on

theory = 0.05*(1-0.9.^[0:299])./(1-0.9).^ 2;
plot(theory);

xlim([0 300])
ylim([0 max(ACF)])
title('Autocorr function for attenuation weiner process')
xlabel('X')
ylabel('Y')
clear W w1 i theory 