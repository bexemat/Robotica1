function [ok] = Comprobacion( R,qq,pm)
T1=R.links(1).A(qq(1));
T2=R.links(2).A(qq(2));
T3=R.links(3).A(qq(3));
T4=R.links(4).A(qq(4));
T=T1*T2*T3*T4;
T=T.double;
for i=1:4
    if (pm(i)==T(i,4))
        ok=1;
    else
        ok=0;
    end
end
%fprintf('El valor de p es : p=[%f , %f , %f] \n ',T(1,4),T(2,4),T(3,4))



end

