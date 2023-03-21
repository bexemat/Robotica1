function ploteaXYZ( TC,M,t )
    X=zeros(1,M);
    Y=X;
    Z=X;
    for i=1:M
        X(1,i)=TC(1,4,i);
        Y(1,i)=TC(2,4,i);
        Z(1,i)=TC(3,4,i);
    end
    subplot(3,1,1)
        title('x')    
        plot(t,X)
        xlabel('t')
        ylabel('x')
        grid on
     subplot(3,1,2)
        title('y')    
        plot(t,Y)
        xlabel('t')
        ylabel('y')
        grid on
     subplot(3,1,3)
        title('z')    
        plot(t,Z)
        xlabel('t')
        ylabel('z')
        grid on
end

