function [ q ] = RespuestaCorrecta( pok,qq )
    if(pok(1)==0 && pok(2)==1)
        fprintf('Soluciones posibles :\n')
        q=qq(:,1:4);
    elseif(pok(1)==1 && pok(2)==0)
        fprintf('Soluciones posibles :\n')
        q=qq(:,5:8);
    elseif(pok(1)==0 && pok(2)==0)
        fprintf('Soluciones posibles :\n')
        q=qq(:,1:8);
    elseif(pok(1)==1 && pok(2)==1)
        fprintf('No hay solucion posible')
        q=0;
    end
end

