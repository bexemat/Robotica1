%=========================================================================%
clc, clear, close all
%=========================================================================%
dh = [
    0.000  0.478  0.05    -pi/2  0;
    0.000  0.05   0.425     0    0;
    0.000  0.00   0.000    pi/2  0;
    0.000  0.425  0.000   -pi/2  0;
    0.000  0.000  0.000    pi/2  0;
    0.000  0.1    0.000   0.000  0];

R =SerialLink(dh);
q1=[0,0,0,0,0,0];
T1=R.fkine(q1)
qact=q1;
R.qlim(1,1:2) = [-180,  180]*pi/180;
R.qlim(2,1:2) = [-130,  147.5]*pi/180;
R.qlim(3,1:2) = [-145,  145]*pi/180;
R.qlim(4,1:2) = [-270,  270]*pi/180;
R.qlim(5,1:2) = [-115,  140]*pi/180;
R.qlim(6,1:2) = [-270,  270]*pi/180;
R.name=('STAUBLI TX90');
R.base = transl(0,0,0.863);
R.tool = transl(0,0,0.05);
q3=[-7.2,38.8,139.2,0,2.1,0]*(pi/180); %punto robot recoge objeto

%% Calculo matriz inversa
T3=R.fkine(q3)%matriz homonea del robot para recoger el objeto
T3=T3.double;
T2=T3;
T2(3,4)=0.9%matriz homogenea del robot con el brazo posicionado 
base=R.base;
herramienta=R.tool;
base=base.double;
herramienta=herramienta.double;
T2=inv(base)*T2*inv(herramienta);  %matriz homogenae sin base ni herramienta
qn=CinematicaInversaf(R,qact,T2,dh);
q2=qn;%posicionamiento del brazo
dt=0.1;
t=0:dt:9.99;
%% primer trayectoria
M=100;%puntos de interpolacion
[Q1,Qv1,Qa1]=jtraj(q1,q2,M);%vector de trayectorias de Mx6 ; trayectoria curva desde la posicion de home a p2
%figure
%ploteaPVA(Q1,Qv1,Qa1,t)
%% Segunda trayectoria
[Q2,Qv2,Qa2]=jtraj(q2,q3,M);
%figure
%ploteaPVA(Q2,Qv2,Qa2,t)
%% Tercer trayectoria
[Q3,Qv3,Qa3]=jtraj(q3,q2,M);
%figure
%ploteaPVA(Q3,Qv3,Qa3,t)
%% cuarta trayectoria
q4=q2;
q4(1)=q4(1)+pi;
T4=R.fkine(q4)
[Q4,Qv4,Qa4]=jtraj(q2,q4,M);
%figure
%ploteaPVA(Q4,Qv4,Qa4,t)
%% quinta trayectoria
q5=q3;
q5(1)=q5(1)+pi;
T5=R.fkine(q5)
[Q5,Qv5,Qa5]=jtraj(q4,q5,M);
%figure
%ploteaPVA(Q5,Qv5,Qa5,t)
%% sexta trayectoria
[Q6,Qv6,Qa6]=jtraj(q5,q4,M);
%figure
%ploteaPVA(Q6,Qv6,Qa6,t)
%% Penultima trayectoria
[Qp,Qvp,Qap]=jtraj(q4,q2,M);
%figure
%ploteaPVA(Qp,Qvp,Qap,t)
%% Trayectoria final
[Qf,Qvf,Qaf]=jtraj(q2,q1,M);
%figure
%ploteaPVA(Qf,Qvf,Qaf,t)
%% Animacion de la trayectoria
figure
R.plot3d(q1,'path',pwd,'trail',{'r', 'LineWidth', 2},'workspace',[-2, 2 -2 2 0 3])
title('Animacion de la trayectoria realizada ')
for i=1:M
    R.animate(Q1(i,:))
end
for i=1:M
    R.animate(Q2(i,:))
end
for i=1:M
    R.animate(Q3(i,:))
end
for i=1:M
    R.animate(Q4(i,:))
end
for i=1:M
    R.animate(Q5(i,:))
end
for i=1:M
    R.animate(Q6(i,:))
end
for i=1:M
    R.animate(Qp(i,:))
end
for i=1:M
    R.animate(Qf(i,:))
end

%% con espacio cartesiano
%TC=ctraj(T2,T3,M);% M Matrices homogeneas de 4x4 trayectoria en linea recta de p2 a p3
%Qc=zeros(M,6);%vectores posicion articular de la trayectoria recta
%for i=1:M
%    base=R.base;
%    herramienta=R.tool;
%    base=base.double;
%    herramienta=herramienta.double;
%    TC(:,:,i)=inv(base)*TC(:,:,i)*inv(herramienta);  %matriz homogenae sin base ni herramienta
%    Qc(i,:)=CinematicaInversaf(R,qact,TC(:,:,i),dh);
%end

