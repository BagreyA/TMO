clc 
clear 
close all 

%% Task ¹3
weiner1=zeros(300,1);

for i = 1:299
    d(1)=0;
    d(i+1)=d(i)+normrnd(0,1);
    weiner1(i+1,1)=d(i+1);
end
figure();
plot(weiner1);
M=mean(weiner1); %add to report
%% Task ¹4
for i = 1:299
    d1(1)=0;
    d1(i+1)=d(i)+normrnd(0,1);
    weiner2(i+1,1)=d1(i+1);
end
R=zeros(299,1);
for i = 1:299
    R(i,1)=(weiner2(i+1,1)-weiner2(i,1))*(weiner2(i+1,1)-weiner2(i,1));
end
SKO=mean(R); %add to report

clear R d d1
%% Task ¹5 : autocorrelation coefficient(-1)
acf1 = autocorr(weiner1,'NumLag',1,'NumSTD',1);
acf1 = acf1(2,1);
disp('Task ¹5.1');
if acf1 >= 0.9
    disp('In our example, the relationship between the rows is high and straight');
elseif (acf1 >=0.5) && (acf1 <0.7)
    disp('A clear correlation between the rows');
else
    disp('Weak or moderate correlation');
end
%% Task ¹5.1 : autocorrelation coefficient(-2)
acf2 = autocorr(weiner1,'NumLag',2,'NumSTD',1);
acf2 = acf2(3,1);
disp('Task ¹5.2');
if acf2 >= 0.9
    disp('In our example, the relationship between the rows is high and straight');
elseif (acf2 >=0.5) && (acf2 <0.7)
    disp('A clear correlation between the rows');
else
    disp('Weak or moderate correlation');
end
ACF = table(acf1,acf2);
clear acf1 acf2 i j
%% Task ¹8 
