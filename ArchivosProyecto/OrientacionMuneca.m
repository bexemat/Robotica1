function [ q ] = OrientacionMuneca(R,qq,T,qant)
    T1=R.links(1).A(qq(1));
    T2=R.links(2).A(qq(2));
    T3=R.links(3).A(qq(3));
    T30=T1*T2*T3;
    T30=T30.double;
    T36=inv(T30)*T;
    q4=zeros(1,2);
    q4(1) = atan2(real(-T36(2,3)), real(-T36(1,3)));
    if(abs(T36(3,3)-1)<=abs(0.00001))
        q4(1)=qant(4);
        q4(2)=q4(1);
        q5(1)=0;
        q5(2)=0;
        q6(1)=atan2(T36(2,1),T36(1,1))-q4(1);
        q6(2)=q6(1);
    else
        if q4(1) > 0, q4(2) = q4(1) - pi; else, q4(2) = q4(1) + pi; end
        q5 = zeros(1,2);
        q6 = q5;
        for i=1:2
            T34 =R.links(4).A(q4(i));
            T04=T1*T2*T3*T34;
            T04=T04.double;
            T46 = inv(T04)* T;
            q5(i) =(pi/2)+atan2(real(T46(2,3)), real(T46(1,3)));
            T45 = R.links(5).A(q5(i));
            T45=T45.double;
            T05=T04*T45;
            T56 = inv(T05)*T;
            q6(i) = atan2(real(T56(2,1)), real(T56(1,1)));
        end
    end
    q=[q4(1),q4(2),q5(1),q5(2),q6(1),q6(2)];
end

