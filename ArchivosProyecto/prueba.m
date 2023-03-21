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
q1=[0,0,0,0,0,0];
%% Matriz homogenea posicion 2

q2=[pi/2,-0.3106,3.5914,-0.0007,-0.1392,0.0006];

%% Matriz homogenea posicion 3 
    T3=[0.0002   -1.0000   -0.0001  -0.05002;
   -1.0000   -0.0002   -0.0000    0.3957;
    0.0000    0.0001   -1.0000       0.5;
         0         0         0         1];
%q3=[ 1.5708,0.6770,2.4306,0.0029,0.0340,-0.0031];

%% 1 era Trayectoria "Interpolacion en el espacio Articular"
M=100;
[Q1,Qv1,Qa1]=jtraj(q1,q2,M);
dt=0.1;
t1=0:dt:10-dt;
t2=10:dt:20-dt;
t3=20:dt:30-dt;
t4=30:dt:40-dt;
t5=40:dt:50-dt;
[TC1] = EarticlarCartesiano( Q1,R,M );
%% 2 da Trayectoria "Interpolacion en el espacio cartesiano"
qant=Q1(M,:);
qact=qant;
q3=ECartesianoAngular( qant,qact,R,T3,1,dh)
T2=R.fkine(q2);
T2=T2.double;
T3=R.fkine(q3);
T3=T3.double;
TC2=ctraj(T2,T3,M);
[Q2] = ECartesianoAngular( qant,qact,R,TC2,M,dh);
[Qv2] = DerivadaP( Q2,dt,M);
[Qa2] = DerivadaS( Q2,dt,M);
%% 3 ra Trayectoria "Interpolacion en el espacio cartesiano"
qant=Q2(M,:);
qact=qant;
T3=R.fkine(Q2(M,:));
T3=T3.double;
TC3=ctraj(T3,T2,M);
[Q3] = ECartesianoAngular( qant,qact,R,TC3,M,dh);
[Qv3] = DerivadaP( Q3,dt,M);
[Qa3] = DerivadaS( Q3,dt,M);
%% ploteo
Q=[Q1;Q2;Q3];
Qv=[Qv1;Qv2;Qv3];
Qa=[Qa1;Qa2;Qa3];
Mt=3*M;
t=[t1,t2,t3];
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
    elseif(i>200 && i<=Mt)
        TC(:,:,i)=TC3(:,:,(i-200));
    end
end
%         TC(:,:,i)=TC3(:,:,(i-200));
%     elseif(i>300 && i<=400)
%         TC(:,:,i)=TC4(:,:,(i-300));
%     elseif(i>400 && i<=500)
%         TC(:,:,i)=TC5(:,:,(i-400));
%     elseif(i>500 && i<=600)
%         TC(:,:,i)=TC6(:,:,(i-500));
%     elseif(i>600 && i<=Mt)
%         TC(:,:,i)=TC7(:,:,(i-600));
%     end
% end
figure
ploteaXYZ( TC,Mt,t)