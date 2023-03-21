%% Entrega las curvas de la aplicacion y la animacion de la misma

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
R.qlim(1,1:2) = [-180,  180]*pi/180;
R.qlim(2,1:2) = [-130,  147.5]*pi/180;
R.qlim(3,1:2) = [-145,  145]*pi/180;
R.qlim(4,1:2) = [-270,  270]*pi/180;
R.qlim(5,1:2) = [-115,  140]*pi/180;
R.qlim(6,1:2) = [-270,  270]*pi/180;
R.name=('STAUBLI TX90');
R.base = transl(0,0,0.863);
R.tool = transl(0,0,0.05);
% q1=[0,0,0,0,0,0];
% 
% q2=[180,36.1,142.1,0,1.8,0]*(pi/180);
% 
% q4=[3.1416,-0.3550,3.5951,0.0000,-0.0985,-0.0000];
% R.fkine(q4)
% R.plot3d(q4,'trail',{'r', 'LineWidth', 2},'workspace', [-3 3 -3 3 0 3],'path',pwd)
% R.teach()
q4=[3.1416,-0.3550,3.5951,0.0000,-0.0985,-0.0000]
T4=R.fkine(q4);
T4=T4.double;
T5=[1.0000    0.0000    0.0000   -0.4067;
    0.0000   -1.0000    0.0000   -0.0500;
    0.0000    0.0000   -1.0000    0.5158;
         0         0         0    1.0000];
M=100;
dt=0.1;
t=40:dt:50-dt;
TC5=ctraj(T4,T5,M);
qant=q4;
qact=qant;
[Q5] = ECartesianoAngular( qant,qact,R,TC5,M,dh);
[Qv5] = DerivadaP( Q5,dt,M);
[Qa5] = DerivadaS( Q5,dt,M);
figure
ploteaQ( Q5,t )
figure
ploteaQ( Qv5,t )
figure
ploteaQ( Qa5,t )
