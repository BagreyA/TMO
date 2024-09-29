clear
clc
close all

%% №1
P = [13 14 0 0; 1 23 24 1; 3 3 3 3; 2 1 15 1];

%% №2
MC = dtmc(P,"StateNames" , ["Healthy" "Unwell" "Sick" "Very sick"]);

%% №3
MCP = MC.P;
S=sum(MCP,2);

%% №4
figure('Name','Граф цепи маркова','NumberTitle','off')
graphplot(MC,'ColorEdges',true);

%% №5
P_cum = MCP;
for K = 1:4
    for L=1:3
        P_cum(K,L+1) = P_cum(K,L) + P_cum(K,L+1);
    end
end
clear K L

%% №6/7/8
N=[200 1000 10000];
figure('Name','Моделирование поведения цепи Маркова','NumberTitle','off')

for i=1:3
    subplot(3,1,i)
    text=['Всего ',num2str(N(i)),' положений'];
    title(text)
    hold on
    z = st(N(i),P_cum);
end


%% № 9\11

P_obs=zeros(4,4,3);
for k=1:3
   for n=2:N(k) 
      for i=1:4
         if z(n-1,1)==i
            for j=1:4
               if z(n,1)==j
                  P_obs(i,j,k)=P_obs(i,j,k)+1; 
               end
            end
         end    
      end
   end
end
figure(3)
MC_Obs1=dtmc(normalize(P_obs(:,:,1),'norm',1),'StateNames',["Healthy" "Unwell" "Sick" "Very sick"]);
graphplot(MC_Obs1,'ColorEdges',true);
figure(4)
MC_Obs2=dtmc(normalize(P_obs(:,:,2),'norm',1),'StateNames',["Healthy" "Unwell" "Sick" "Very sick"]);
graphplot(MC_Obs2,'ColorEdges',true);
figure(5)
MC_Obs3=dtmc(normalize(P_obs(:,:,3),'norm',1),'StateNames',["Healthy" "Unwell" "Sick" "Very sick"]);
graphplot(MC_Obs3,'ColorEdges',true);

a=normalize(P_obs(:,:,1),'norm',1);
b=normalize(P_obs(:,:,2),'norm',1);
c=normalize(P_obs(:,:,3),'norm',1);

%% №10 (теоретический)
P1(:,:)=MCP(:,:)^200;
P2(:,:)=MCP(:,:)^1000;
P3(:,:)=MCP(:,:)^10000;

%% №12
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

