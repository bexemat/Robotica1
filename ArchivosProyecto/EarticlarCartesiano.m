function [ TC] = EarticlarCartesiano( Q,R,M )
    TC=zeros(4,4,M);
    for i=1:M
        TC(:,:,i)=R.fkine(Q(i,:));
    end

end

