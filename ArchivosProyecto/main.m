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
%% Matriz homogenea posicion 1
T1 = [1         0         0     0.475;
      0         1         0      0.05;
      0         0         1     1.003;
      0         0         0        1];
%% Matriz homogenea posicion 2
% T2 =[-1.0000   -0.0001   -0.0000    0.3957;
%    -0.0001    1.0000    0.0001     0.05001;
%     0.0000    0.0001   -1.0000         0.9;
%          0         0         0          1];
 T2=[   -1         0         0       0.4067;
         0         1         0         0.05;
         0         0        -1       0.9158;
         0         0         0           1];  
%% Matriz homogenea posicion 3
      
% T3 =[ -1.0000   -0.0001   -0.0000    0.3958;
%    -0.0001    1.0000    0.0001      0.05001;
%     0.0000    0.0001   -1.0000          0.5;
%          0         0         0           1];
T3=[    -1         0         0       0.4067;
         0         1         0         0.05;
         0         0        -1       0.5158;
         0         0         0           1];  
%% Matriz homogenea posicion 4
T4=[1.0000    0.0001    0.0000   -0.3957;
    0.0001   -1.0000   -0.0001   0.04999;
    0.0000    0.0001   -1.0000       0.9;
         0         0         0        1];
%% Matriz homogenea posicion 5

T5=[ 1.0000    0.0000    0.0000   -0.4067;
    0.0000   -1.0000    0.0000      -0.05;
    0.0000         0   -1.0000     0.5158;
         0         0         0         1];
qant=[0,0,0,0,0,0];
qact=qant;
q1=qact;
%% Calculo del segundo punto
q2=ECartesianoAngular(qant,qact,R,T2,1,dh);
%% 1 era Trayectoria "Interpolacion en el espacio Articular"
M=100;
[Q1,Qv1,Qa1]=jtraj(q1,q2,M);
dt=0.1;
t1=0:dt:10-dt;
t2=10:dt:20-dt;
t3=20:dt:30-dt;
t4=30:dt:40-dt;
t5=40:dt:50-dt;
t6=50:dt:60-dt;
t7=60:dt:70-dt;
[TC1] = EarticlarCartesiano( Q1,R,M );
%% 2 da Trayectoria "Interpolacion en el espacio cartesiano"
qant=Q1(M,:);
qact=qant;
TC2=ctraj(T2,T3,M);
[Q2] = ECartesianoAngular( qant,qact,R,TC2,M,dh);
[Qv2] = DerivadaP( Q2,dt,M);
[Qa2] = DerivadaS( Q2,dt,M);
%% 3 ra Trayectoria "Interpolacion en el espacio cartesiano"
qant=Q2(M,:);
qact=qant;
TC3=ctraj(T3,T2,M);
[Q3] = ECartesianoAngular( qant,qact,R,TC3,M,dh);
[Qv3] = DerivadaP( Q3,dt,M);
[Qa3] = DerivadaS( Q3,dt,M);
%% calculo posicon del punto 4
 q4=Q3(M,:);
 q4(1)=q4(1)+pi;
%q4=[-3.1416,1.7100,-0.4498,-3.1415,4.4018,3.1415];
%% 4ta Trayectoria "Interpolacion en el espacio Articular"
[Q4,Qv4,Qa4]=jtraj(Q3(M,:),q4,M);
[TC4] = EarticlarCartesiano( Q4,R,M );
%% 5 ta Trayectoria "Interpolacion en el espacio cartesiano"
qant=Q4(M,:);
qact=qant;
% T4=R.fkine(Q4(M,:));
% T4=T4.double;
TC5=ctraj(T4,T5,M);
[Q5] = ECartesianoAngular( qant,qact,R,TC5,M,dh);
[Qv5] = DerivadaP( Q5,dt,M);
[Qa5] = DerivadaS( Q5,dt,M);
%% 6ta Trayectoria "Interpolacion en el Espacio Cartesiano"
qant=Q5(M,:);
qact=qant;
TC6=ctraj(T5,T4,M);
[Q6] = ECartesianoAngular( qant,qact,R,TC6,M,dh);
[Qv6] = DerivadaP( Q6,dt,M);
[Qa6] = DerivadaS( Q6,dt,M);
%% ULTIMA Trayectoria "Interpolacion en el Espacio Articular"
[Q7,Qv7,Qa7]=jtraj(Q6(M,:),q2,M);
[TC7] = EarticlarCartesiano( Q7,R,M );

%%  Grafico
Q=[Q1;Q2;Q3;Q4;Q5;Q6;Q7];
Qv=[Qv1;Qv2;Qv3;Qv4;Qv5;Qv6;Qv7];
Qa=[Qa1;Qa2;Qa3;Qa4;Qa5;Qa6;Qa7];
Mt=7*M;
t=[t1,t2,t3,t4,t5,t6,t7];
figure
ploteaQ( Q,t )
figure
ploteaQ( Qv,t )
figure
ploteaQ( Qa,t )
TC=zeros(4,4,Mt);
for i=1:Mt
    if(i<=100)
        TC(:,:,i)=TC1(:,:,i);
    elseif(i>100 && i<=200)
        TC(:,:,i)=TC2(:,:,(i-100));
    elseif(i>200 && i<=300)
        TC(:,:,i)=TC3(:,:,(i-200));
    elseif(i>300 && i<=400)
        TC(:,:,i)=TC4(:,:,(i-300));
    elseif(i>400 && i<=500)
        TC(:,:,i)=TC5(:,:,(i-400));
    elseif(i>500 && i<=600)
        TC(:,:,i)=TC6(:,:,(i-500));
    elseif(i>600 && i<=Mt)
        TC(:,:,i)=TC7(:,:,(i-600));
    end
end
figure
ploteaXYZ( TC,Mt,t)
%% Animo recorrido
figure
R.plot3d(q1,'trail',{'r', 'LineWidth', 2},'workspace', [-3 3 -3 3 0 3],'path',pwd)
animaTrayectoria(Q1,M,R )
animaTrayectoria(Q2,M,R )
animaTrayectoria(Q3,M,R )
animaTrayectoria(Q4,M,R )
animaTrayectoria(Q5,M,R )
animaTrayectoria(Q6,M,R )
animaTrayectoria(Q7,M,R )

%EN t=18.3 , t=21,4 se observan picos debido a la singularidad

