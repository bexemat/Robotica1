function ploteaPVA(Q,Qv,Qa,t )
subplot(3,1,1)
qplot(t,Q)%plotea las trayectorias de las distintas articulaciones
title('Trayectorias de articulaciones ')
subplot(3,1,2)
qplot(t,Qv)%plotea las velocidades de las distintas articulaciones
title('Velocidades de articulaciones ')
subplot(3,1,3)
qplot(t,Qa)%plotea las aceleraciones de las distintas articulaciones
title('Aceleraciones de articulaciones ')
end

