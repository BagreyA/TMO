function z = st(N,P_cum)
z=zeros(N,1);
z(1,1)=1;
r=rand(N,1);
n=2;
k=1;
while n~=N+1
    if (k==1)&&(r(n-1,1)>=P_cum(1,1))
        k=2;
        z(n,1)=k;
        n=n+1;
    elseif (k==1)&&(r(n-1,1)<P_cum(1,1))
        k=1;
        z(n,1)=k;
        n=n+1;
    end
    if (k==2)&&(r(n-1,1)>=P_cum(2,2))
        k=3;
        z(n,1)=k;
        n=n+1;
    elseif (k==2)&&(r(n-1,1)<=P_cum(2,2))
        k=2;
        z(n,1)=k;
        n=n+1;
    end
    if (k==3)&&(r(n-1,1)>=P_cum(3,2))
        k=3;
        z(n,1)=k;
        n=n+1;
    elseif (k==3)&&(r(n-1,1)<P_cum(3,2))
        k=2;
        z(n,1)=k;
        n=n+1;
    end
    if (k==4)&&(r(n-1,1)>=P_cum(4,3))
        k=4;
        z(n,1)=k;
        n=n+1;
    elseif (k==4)&&(r(n-1,1)<P_cum(4,3))
        k=3;
        z(n,1)=k;
        n=n+1;
    end
    if (n==N)
        z(n,1)=z(n-1,1);
        break
    end
end
x =1:N;
stairs(x,z);
end