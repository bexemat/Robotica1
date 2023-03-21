function  ploteaS( R,qq )
%=========================================================================%
R1 = SerialLink(R,'name','q1');
subplot(3,3,1); 
R1.plot3d(qq(:,1)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')

%=========================================================================%
R2 = SerialLink(R,'name','q2');
subplot(3,3,2); 
R2.plot3d(qq(:,2)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')

%=========================================================================%
R3 = SerialLink(R,'name','q3');
subplot(3,3,3);  
R3.plot3d(qq(:,3)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')

%=========================================================================%
R4 = SerialLink(R,'name','q4');
subplot(3,3,4);  
R4.plot3d(qq(:,4)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')
%=========================================================================%
%=========================================================================%
R5 = SerialLink(R,'name','q5');
subplot(3,3,5); 
R5.plot3d(qq(:,5)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')

%=========================================================================%
R6 = SerialLink(R,'name','q6');
subplot(3,3,6); 
R6.plot3d(qq(:,6)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')

%=========================================================================%
R7 = SerialLink(R,'name','q7');
subplot(3,3,7);  
R7.plot3d(qq(:,7)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')

%=========================================================================%
R8 = SerialLink(R,'name','q8');
subplot(3,3,8);  
R8.plot3d(qq(:,8)','path',pwd),campos([10 15 10])
hold on,trplot(diag(ones(4,1)),'length',1.5,'frame','0')
%=========================================================================%

end

