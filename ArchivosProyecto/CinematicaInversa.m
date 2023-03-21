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
%qact=[3.0159,0.6770,2.4305,0.0029,0.0341,-0.0030];
qact=[pi/2,-0.3106,3.5914,-0.0007,-0.1392,0.0006];
%qact =[90,15,20,25,30,100]*pi/180;%Respuesta actual
R.qlim(1,1:2) = [-180,  180]*pi/180;
R.qlim(2,1:2) = [-130,  147.5]*pi/180;
R.qlim(3,1:2) = [-145,  145]*pi/180;
R.qlim(4,1:2) = [-270,  270]*pi/180;
R.qlim(5,1:2) = [-115,  140]*pi/180;
R.qlim(6,1:2) = [-270,  270]*pi/180;
R.name=('STAUBLI TX90');
%R.base = transl(0,0,0.5);
%R.tool = transl(0,0,0.05);
R.base = transl(0,0,0.863);
R.tool = transl(0,0,0.05);
%q=[0,0,0,0,0,0];
q2=[0,13.9,139.2,0,26.9,0]*(pi/180);  
q3=[0,-0.6369,3.1109,3.1416,-0.6676,-3.1416];
%qact=[0,0.6770,2.4305,0.0029,0.0341,-0.0030];
T=R.fkine(qact)

T=[ 1.0000   -0.0000   -0.0000   -0.4067;
   -0.0000   -1.0000    0.0000   -0.0500;
   -0.0000    0.0000   -1.0000    0.9158;
         0         0         0    1.0000];
     
%% Ploteo del robot
%R.offset =[0,-90,0,0,0,0]*pi/180;
%R.plot(q,'workspace', [-0.5 1.5 -0.2 1.5 -1 3] );
%R.plot3d(q,'path',pwd,'trail',{'r', 'LineWidth', 2},'workspace', [-3 3 -3 3 0 3])
%hold on
%R.teach
%% Calculo matriz inversa
%T=R.fkine(qact);
% q=[3.0158,-0.3106,3.5913,-0.0007,-0.1391,0.0006];
%q=[3.0159,-0.3106,3.5913,-0.0007,-0.1391,0.0006];
% T =[-1.0000   -0.0001   -0.0000    0.3958;
%    -0.0001    1.0000    0.0001   0.05001;
%     0.0000    0.0001   -1.0000       0.9;
%          0         0         0         1]
% T=R.fkine(qact);
% T=T.double;
% T=[ -0.9921    0.1253   -0.0017    0.3989;
%     0.1253    0.9921    0.0002    0.0000;
%     0.0017    0.0000   -1.0000    0.7000;
%          0         0         0    1.0000];
base=R.base;
herramienta=R.tool;
base=base.double;
herramienta=herramienta.double;
T=inv(base)*T*inv(herramienta);  %matriz homogenae sin base ni herramienta
%T=T.double;
p=T(1:3,4)-dh(6,2)*T(1:3,3); %calcula el punto que corresponde al punto donde se interectan tres ejes rotacionales
pm=[p;1];
%% Calcula los dos valores de q1 posibles
q1=zeros(1,2);
q1=q1r(pm);
if(q1(2)>0)
    q1(2)=q1(2)+pi;
else
    q1(2)=q1(2)-pi;
end    
%% 8 posibles respuestas del robot
qq=zeros(6,8) ;
qq(1,1:4)=[1 1 1 1]*q1(1);
qq(1,5:8)=[1 1 1 1]*q1(2);
%% Calculo de las 4 respuestas distintas para q2
T1=zeros(4,4,4);
T1(:,:,1)=R.links(1).A(q1(1));%Sistema 1 con respecto a 0
T1(:,:,2)=R.links(1).A(q1(1));%Sistema 1 con respecto a 0
T1(:,:,3)=R.links(1).A(q1(2));%Sistema 1 con respecto a 0
T1(:,:,4)=R.links(1).A(q1(2));%Sistema 1 con respecto a 0
a1=dh(2,3); %dimension del 3 eslabon
a2=dh(4,2); %dimension del 4 eslabon
p1=zeros(4,2);
q2=zeros(1,4);   %4 soluciones distintas
beta=zeros(1,2); %1 beta para cada punto
alfa=zeros(1,2); %2 alfa para cada punto
r=zeros(1,2);    %1 r para cada punto
p1(:,1)=inv(T1(:,:,1))*pm;
p1(:,2)=inv(T1(:,:,3))*pm;
pok=zeros(1,2);%comprueba si el punto esta en el espacio de trabajo
for i=1:2
    beta(i)=atan2(p1(2,i),p1(1,i));
    r(i)=sqrt(p1(1,(i))^2+p1(2,(i))^2);
    aa=((a2^2+r(i)^2-a1^2)/(2*a2*r(i)));
    if(aa>1)
        %fprintf('q1 %d : esta fuera del espacio de trabajo\n',i);
        pok(i)=1;
    end
    alfa(i)=acos(aa);
end
q2(1,1)=beta(1)+real(alfa(1));
q2(1,2)=beta(1)-real(alfa(1));
q2(1,3)=beta(2)+real(alfa(2));
q2(1,4)=beta(2)-real(alfa(2));
qq(2,:)=[q2(1),q2(1),q2(2),q2(2),q2(3),q2(3),q2(4),q2(4)]; 
%% Calculo las dos respuestas de q3
%% q3
T2=zeros(4,4,4);
for i=1:4
T2(:,:,i)=R.links(2).A(q2(i));%MATRIZ DEL SISTEMA 2 CON RESPECTO AL 1
T2(:,:,i)=T1(:,:,i)*T2(:,:,i);%MATRIZ DEL SISTEMA 2 CON RESPECTO AL 0
end
p2=zeros(4,4);
for i=1:4
    p2(:,i)=inv(T2(:,:,i))*pm;
end
q3=zeros(1,4);
fprintf('\n')
for i=1:4
    q3(i)=atan2(p2(2,i),p2(1,i))+(pi/2);    
end
qq(3,:)=[q3(1) q3(1) q3(2) q3(2) q3(3) q3(3) q3(4) q3(4)];;
%% Comprobacion hasta la muñeca
%ok=zeros(1,4);
%for i=1:4
%    ok(i)=Comprobacion(R,qq(:,i),pm);    
%end
%if(ok==[1,1,1,1])
%    fprintf('Respuestas  Correcta\n')
%    qq*(180/pi)
%else
%    fprintf('Respuestas  Incorrecta\n')
%end
%% Segunda parte Metodo de pipper
x1=OrientacionMuneca(R,qq(1:3,1),T,qact);
x2=OrientacionMuneca(R,qq(1:3,3),T,qact);
x3=OrientacionMuneca(R,qq(1:3,5),T,qact);
x4=OrientacionMuneca(R,qq(1:3,7),T,qact);
qq(4,:)=[x1(1),x1(2),x2(1),x2(2),x3(1),x3(2),x4(1),x4(2)];
qq(5,:)=[x1(3),x1(4),x2(3),x2(4),x3(3),x3(4),x4(3),x4(4)];
qq(6,:)=[x1(5),x1(6),x2(5),x2(6),x3(5),x3(6),x4(5),x4(6)];
%qq*(180/pi)

%% Comprueba soluciones posibles
qn=RespuestaCorrecta(pok,qq);%Respuestas nuevas posibles 
qn*(180/pi)
%% Ploteo de las  soluciones posibles
% %cant=length(qn(1,:));
% %for i=1:cant
% %    figure
     R.plot3d(qact,'path',pwd),campos([10 15 10])
     R.teach()
% %end
%% Solucion Mas cercana a la posicion anterior
%PloteaEjes(qact',R)

