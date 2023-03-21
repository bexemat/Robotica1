function [Q1] = ECartesianoAngular( qant,qact,R,TC1,M,dh)

Q1=zeros(M,6);
for i=1:M    
    base=R.base;
    herramienta=R.tool;
    base=base.double;
    herramienta=herramienta.double;
    TC1(:,:,i)=inv(base)*TC1(:,:,i)*inv(herramienta);  %matriz homogenae sin base ni herramienta
    qn=CinematicaInversaf(R,qant,TC1(:,:,i),dh);
    if (i==1)
        qn
    end
    %q mas cercano
    qnuevos=zeros(6,8);
    for h=1:6
        for j=1:8
            if(abs(qn(h,j))<abs(abs(qant(h))+(30*(pi/180))))
                qnuevos(h,j)=qn(h,j);
            else
                qnuevos(h,j)=0;
            end
        end
    end
    cant=zeros(1,8);
    for l=1:8
        k=0;
        for n=1:6
            if(qnuevos(n,l)~=0)
                k=k+1;
            end
            cant(l)=k;
        end
    end
    maximo=max(abs(cant));
    flag=1;
    while(flag)
        for z=1:8
            if(cant(z)==maximo)
                qact=qn(:,z)';
                flag=0;
            end
        end
    end
    Q1(i,:)=qact;
    qant=qact;
end


end

