%% Se encuentra q1 a traves de la interseccion de una recta tangente con una circunferencia
function [ qr ] = q1r(p)
r=0.05;
a=((4*(r^2))-(4*(p(1)^2)));
b=8*p(1)*p(2);
c=((4*(r^2))-(4*(p(2)^2)));
qr=zeros(1,2);
qr(1)=atan((-b+sqrt(b^2-4*a*c))/(2*a));
qr(2)=atan((-b-sqrt(b^2-4*a*c))/(2*a));
end

