function  ploteaQ( Q1,t)
    subplot(3,2,1)
        plot(t,Q1(:,1))
        title('q1')
        xlabel('t')
        ylabel('q1')
        grid on
    subplot(3,2,2)
        plot(t,Q1(:,2))
        title('q2')
        xlabel('t')
        ylabel('q2')
        grid on
    subplot(3,2,3)
        plot(t,Q1(:,3))
        title('q3')
        xlabel('t')
        ylabel('q3')
        grid on
    subplot(3,2,4)
        plot(t,Q1(:,4))
        title('q4')
        xlabel('t')
        ylabel('q4')
        grid on
    subplot(3,2,5)
        plot(t,Q1(:,5))
        title('q5')
        xlabel('t')
        ylabel('q5')
        grid on
    subplot(3,2,6)
        plot(t,Q1(:,6))
        title('q6')
        xlabel('t')
        ylabel('q6')
        grid on
    

end

