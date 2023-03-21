function [ dQ ] = DerivadaP( Q,dt,M)
dQ=zeros(M,6);
for i=1:M
    for j=1:6
        if(i==1)
            dQ(i,j)=(1/(dt))*(Q(i+1,j)-Q(i,j));
        end
        if(i==M)
            dQ(i,j)=(1/(dt))*(Q(i,j)-Q(i-1,j));
        end
        if(i~=1 && i~=M)        
            dQ(i,j)=(1/(2*dt))*(Q(i+1,j)-Q(i-1,j));
        end
    end
end



end

