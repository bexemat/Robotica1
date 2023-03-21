%% Trayectoria con interpolacion en el espacio cartesiano

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
%% Matriz homogenea posicion 1
T1 = [1         0         0     0.475;
      0         1         0      0.05;
      0         0         1     1.003;
      0         0         0        1];
%% Matriz homogenea posicion 2
T2 =[-0.9921    0.1253   -0.0017    0.3989;
      0.1253    0.9921    0.0002    0.0000;
      0.0017    0.0000   -1.0000    0.9000;
          0         0         0    1.0000];
%% Matriz homogenea posicion 3
      
T3 =[-0.9921    0.1253   -0.0017    0.3989;
      0.1253    0.9921    0.0002    0.0000;
      0.0017    0.0000   -1.0000    0.5000;
           0         0        0    1.0000];
%% Matriz homogenea posicion 4
T4 = [0.9921   -0.1253    0.0017       -0.3989;
     -0.1253   -0.9921   -0.0002    -2.046e-07;
      0.0017         0   -1.0000           0.9;
          0          0        0             1]; 
%% Matriz homogenea posicion 5
T5 = [0.9921   -0.1253    0.0017     -0.3989;
     -0.1253   -0.9921   -0.0002  -2.046e-07;
      0.0017         0   -1.0000         0.5;
           0         0         0          1];
%% 1 er Interpolacion en el espacio cartesiano
M=100;
TC1=ctraj(T1,T2,M);
dt=0.1;
t=0:dt:9.99;
%% pasaje de coordenada cartesianas a coordenadas articulares
qant=[0,0,0,0,0,0];
qact=qant;
[Q1] = ECartesianoAngular( qant,qact,R,TC1,M,dh);
[Qv1] = DerivadaP( Q1,dt,M);
[Qa1] = DerivadaS( Q1,dt,M);
figure;
ploteaPVA(Q1,Qv1,Qa1,t );
%% 2 da Interpolacion en el espacio cartesiano
qant=Q1(M,:);
qact=qant;
TC2=ctraj(T2,T3,M);
[Q2] = ECartesianoAngular( qant,qact,R,TC2,M,dh);
[Qv2] = DerivadaP( Q2,dt,M);
[Qa2] = DerivadaS( Q2,dt,M);
figure;
ploteaPVA(Q2,Qv2,Qa2,t );
%% 3 ra Interpolacion en el espacio cartesiano
qant=Q2(M,:);
qact=qant;
TC3=ctraj(T3,T2,M);
[Q3] = ECartesianoAngular( qant,qact,R,TC3,M,dh);
[Qv3] = DerivadaP( Q3,dt,M);
[Qa3] = DerivadaS( Q3,dt,M);
figure;
ploteaPVA(Q3,Qv3,Qa3,t );
%% 4 ta Interpolacion en el espacio cartesiano
qant=Q3(M,:);
qact=qant;
TC4=ctraj(T2,T4,M);
[Q4] = ECartesianoAngular( qant,qact,R,TC4,M,dh);
[Qv4] = DerivadaP( Q4,dt,M);
[Qa4] = DerivadaS( Q4,dt,M);
figure;
ploteaPVA(Q4,Qv4,Qa4,t );
%% 5 ta Interpolacion en el espacio cartesiano
qant=Q4(M,:);
qact=qant;
TC5=ctraj(T4,T5,M);
[Q5] = ECartesianoAngular( qant,qact,R,TC5,M,dh);
[Qv5] = DerivadaP( Q5,dt,M);
[Qa5] = DerivadaS( Q5,dt,M);
figure;
ploteaPVA(Q5,Qv5,Qa5,t );
%% 6 ta Interpolacion en el espacio cartesiano
qant=Q5(M,:);
qact=qant;
TC6=ctraj(T5,T4,M);
[Q6] = ECartesianoAngular( qant,qact,R,TC6,M,dh);
[Qv6] = DerivadaP( Q6,dt,M);
[Qa6] = DerivadaS( Q6,dt,M);
figure;
ploteaPVA(Q6,Qv6,Qa6,t );
%% 7 ta Interpolacion en el espacio cartesiano
qant=Q6(M,:);
qact=qant;
TC7=ctraj(T4,T2,M);
[Q7] = ECartesianoAngular( qant,qact,R,TC7,M,dh);
[Qv7] = DerivadaP( Q7,dt,M);
[Qa7] = DerivadaS( Q7,dt,M);
figure;
ploteaPVA(Q7,Qv7,Qa7,t );
%% Animacion de la trayectoria
%R.plot3d(qant,'trail',{'r', 'LineWidth', 2},'workspace', [-3 3 -3 3 0 3],'path',pwd)
%title('Animacion de la trayectoria realizada ')
%animaTrayectoria(Q1,M,R)
%animaTrayectoria(Q2,M,R)
%animaTrayectoria(Q3,M,R)
%animaTrayectoria(Q5,M,R)
%animaTrayectoria(Q6,M,R)
%R.teach()