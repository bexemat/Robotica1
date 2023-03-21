function [ dQ ] = DerivadaS( Q,dt,M)
dQ=zeros(M,6);
for i=1:M
    for j=1:6
        if(i==1)
            dQ(i,j)=(1/(2*dt))*(-3*Q(i,j)+4*Q(i+1,j)-Q(i+2,j));
        end
        if(i==M)
            dQ(i,j)=(1/(2*dt))*(3*Q(i,j)-4*Q(i-1,j)+Q(i-2,j));
        end
        if(i~=1 && i~=M)        
            dQ(i,j)=(1/((dt)^2))*(Q(i+1,j)-2*(Q(i,j))+Q(i-1,j));
        end
    end
end



end

