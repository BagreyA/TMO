clc 
clear 
close all

%% Task ¹1
matrix = zeros(300,600);
for i = 1:300
    for j = 1:600
        matrix(i,j) = normrnd(6,4);
    end
end

%average of each columns ( time average )
s = zeros(1,600);
for i = 1:600
    s(1,i) = mean(matrix(:,i));
end
%average of each rows ( ensemble average )
sk = zeros(1,300);
for i = 1:300
    sk(1,i) = mean(matrix(i,:));
end

figure('Name','Ensemble and time average','NumberTitle','off','Position',[500,150,1000,700])
plot(s);
hold on
plot(sk);
hold on
legend('time average',' ensemble average')
xlim([0 600]);

clear sk s  
%% Task ¹2
figure('Name','Scatter plot','NumberTitle','off','Position',[500,150,1000,700])
l = randi(600,3,2); 
r(1,:) = xcorr(matrix(:,l(1,1)),matrix(:,l(1,2)),1,'normalized');
r(2,:) = xcorr(matrix(:,l(2,1)),matrix(:,l(2,2)),1,'normalized');
r(3,:) = xcorr(matrix(:,l(3,1)),matrix(:,l(3,2)),1,'normalized');
coeff = table(r(:,2)','VariableNames',{'r-coeff'});

a(1) = scatter(matrix(:,l(1,1)),matrix(:,l(1,2)),20,'r');
hold on
set(a(1),'Visible','off');
a(2) = scatter(matrix(:,l(2,1)),matrix(:,l(2,2)),20,'b');
hold on
set(a(2),'Visible','off');
a(3) = scatter(matrix(:,l(3,1)),matrix(:,l(3,2)),20,'g');
hold on
set(a(3),'Visible','off');
xlim([-20 50])
ylim([-20 50])
lgd = legend(num2str(l(1,:)),num2str(l(2,:)),num2str(l(3,:)));
title('Scatter plot for random realisations')
title(lgd,'Order')


for k = 1:3
    cbx(k) = uicontrol('Style','checkbox', 'string', r(k,2) , 'Position',[20 70*k 70 15], 'Callback',{@checkBoxCallback,k,a});
end

clear a matrix vectorx vectory k i j linspace r cbx lgd l