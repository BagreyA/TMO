clc;
clear all;
close all;

syms x;
syms z;

f=0.5*exp(x/2); % от -беск до 0
f1=0; % от 0 до беск

%ПОЛУЧЕНИЕ ФУНКЦИИ РАСПРЕДЕЛЕНИЯ
F0=int(0.5*exp(x/2),[-inf 0]); % проверка , F0=1
F=int(0.5*exp(x/2),[-inf x]); % функция распределения на интервале от -inf до 0
F1=exp(0/2); % функция распределения на интервале от 0 до inf

%ГРАФИК ФУНКЦИИ РАСПРЕДЕЛЕНИЯ ВЕРОЯТНОСТИ И ФУНКЦИИ ПЛОТНОСТИ ВЕРОЯТНОСТИ
figure('Name','Функция распределения и плотность','NumberTitle','off');
%subplot(2,1,1);
fplot(x,0.5*exp(x/2),[-10 0],'b','Linewidth',2);
hold on;
grid on;
fplot(0,[0 10],'b','Linewidth',2);
hold on
%subplot(2,1,2);
fplot(F,[-10 0],'r','Linewidth',2);
hold on;
grid on;
fplot(F1,[0 10],'r','Linewidth',2);

%ОБРАТНАЯ ФУНКЦИЯ К ФУНКЦИИ РАСПРЕДЕЛЕНИЯ
X=solve(exp(x/2)==z,x);

clear f1 F0 F1

%СОЗДАНИЕ ВЫБОРКИ
z1=rand(50,1);
z2=rand(200,1);
z3=rand(1000,1);

N=2.*log(z1);
N1=2.*log(z2);
N2=2.*log(z3);

LN(1,1)=length(N);
LN(2,1)=length(N1);
LN(3,1)=length(N2);

%Уровни значимости
a(1,1)=0.1;
a(2,1)=0.05;
a(3,1)=0.01;

%Рассчёт кси-квадрат распределения для верхней и нижней интервальной оценки
KSID=zeros(3,3);
KSIH=zeros(3,3);
for j =[1 2 3]
for i =[1 2 3]
KSID(i,j)=chi2inv((1-(a(j,1)/2)),(LN(i,1)-1)); %p=1-a; for a/2 = p=1-a/2 for 1-a/2 p=1-(1-a/2)=a/2;
KSIH(i,j)=chi2inv((a(j,1)/2),(LN(i,1)-1));
end
end

clear z1 z2 z3

%ТОЧЕЧНАЯ ОЦЕНКА СРЕДНЕГО
SR(1,1)=sum(N)/length(N);
SR(2,1)=sum(N1)/length(N1);
SR(3,1)=sum(N2)/length(N2);

%ТОЧЕЧНАЯ ОЦЕНКА ДИСПЕРСИИ
DISP(1,1)=var(N);
DISP(2,1)=var(N1);
DISP(3,1)=var(N2);

%ТОЧЕЧНАЯ ОЦЕНКА СКО
SKO(1,1)=std(N);
SKO(2,1)=std(N1);
SKO(3,1)=std(N2);

%ТОЧЕЧНАЯ ОЦЕНКА МАТОЖИДАНИЯ
MAT(1,1)=mean(N);
MAT(2,1)=mean(N1);
MAT(3,1)=mean(N2);

%Коэффициенты Стьюдента
%альфа 0,1
Student(1,1)=1.671;
Student(2,1)=1.660;
Student(3,1)=1.646;
%альфа 0,05
Student(1,2)=2.010;
Student(2,2)=1.984;
Student(3,2)=1.962;
%альфа 0,01
Student(1,3)=2.726;
Student(2,3)=2.626;
Student(3,3)=2.581;

%Интервальная оцека среднего (обращаемся к функции "interval")
INTH=zeros(3,3);
INTD=zeros(3,3);
for j=[1 2 3]
for i=[1 2 3]
[INTH(i,j), INTD(i,j)]=interval(DISP(i,1),MAT(i,1),Student(i,j),LN(i,1));
end
end

%Интервальная оцека дисперсии (обращаемся к функции "dispersia")
DISPH=zeros(3,3);
DISPD=zeros(3,3);
for j=[1 2 3]
for i=[1 2 3]
[DISPH(i,j), DISPD(i,j)]=dispersia(SKO(i,1),KSIH(i,j),KSID(i,j),LN(i,1));
end
end


%СВЕДЕНИЕ ЗНАЧЕНИЙ В ТАБЛИЦУ
T_p90=table(LN,INTD(:,1),INTH(:,1),DISPD(:,1),DISPH(:,1));
T_p95=table(LN,INTD(:,2),INTH(:,2),DISPD(:,2),DISPH(:,2));
T_p99=table(LN,INTD(:,3),INTH(:,3),DISPD(:,3),DISPH(:,3));

clear i j stD stH student KSIH KSID DISPH DISPD INTH INTD DISP student MAT SKO a

%ПОСТРОЕНИЕ ГИСТОГРАММ
figure('Name','Гистограмма для НСВ','NumberTitle','off');

%формула Стерджесса
k(1,1)=ceil(1+3.322*log10(LN(1,1)));
k(2,1)=ceil(1+3.322*log10(LN(2,1)));
k(3,1)=ceil(1+3.322*log10(LN(3,1)));

subplot(1,3,1)
histogram(N,k(1,1),'Normalization','probability');
hold on;
fplot(x,0.5*exp(x/2),[-12 0]);

subplot(1,3,2)
histogram(N1,k(2,1),'Normalization','probability');
hold on;
fplot(x,0.5*exp(x/2),[-12 0]);

subplot(1,3,3)
histogram(N2,k(3,1),'Normalization','probability');
hold on;
fplot(x,0.5*exp(x/2),[-12 0]);

clear z x