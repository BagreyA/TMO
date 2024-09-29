clear
clc
close all

%% �1
P = [0 0.0087 0 0; 0 0.53 0,63 0; 0 0.45 0.36 0; 0 0 0 0];

%% �2
MC = dtmc(P,"StateNames" , ["Healthy" "Unwell" "Sick" "Very sick"]);

%% �3
MCP = MC.P;
S=sum(MCP,2);

%% �4
figure('Name','���� ���� �������','NumberTitle','off')
graphplot(MC,'ColorEdges',true);

%% �5
P_cum = MCP;
for K = 1:4
    for L=1:3
        P_cum(K,L+1) = P_cum(K,L) + P_cum(K,L+1);
    end
end
clear K L

%% �6/7/8
N=[200 1000 10000];
figure('Name','������������� ��������� ���� �������','NumberTitle','off')
for i=1:3
    subplot(3,1,i)
    text=['����� ',num2str(N(i)),' ���������'];
    title(text)
    hold on
    z = st(N(i),P_cum);
end

%% �10 (�������������) 

%% �12
lam=15;
mu=10;
n=3;
m=5;

p=lam/mu;
Psum=0;
for i=0:m
   Psum=Psum+(p^i)/(factorial(i));
end
p0=Psum^(-1);
Potk=(p^(n+m))*p0/((n^m)*factorial(n));
Q=1-Potk;
A=lam*Q;

kzan=A/mu;
Loch=(p^(n+1))*(1-((p/n)^m)*(m+1-m*p/n))*p0/(n*factorial(n)*(1-p/n)^2);
Toch=Loch/lam;
Lsist=Loch+kzan;
Tsist=Lsist/lam;

% ����� ��� �������� ������� 9 � 11-�� ������
% �� � ���������� �� ������� � ��� ����, ���� � ����� ����� ����������,
% ����� �� ��������, ��� ������� � ��� ����� � �� � ��� ���������, �� ���
% �������, ����� ������ ������� ������������ ������, � �� �� �� ������ ��
% ����� ��� ��������� �������