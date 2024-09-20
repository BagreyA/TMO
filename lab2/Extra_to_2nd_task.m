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

%average of each rows ( ensemble average )
sk = zeros(1,300);
for i = 1:300
    sk(1,i) = mean(matrix(i,1:10));
end

figure('Name','Ensemble and time average','NumberTitle','off')
plot(matrix(:,1:10))
hold on;
plot(sk,'r','LineWidth',1.5)
hold on;
legend('time average','ensemble average')
xlim([0 300]);

clear sk