function  PloteaEjes( qq,R )
R.plot(qq');
hold on;
T01=R.links(1).A(qq(1));
T12=R.links(2).A(qq(2));
T23=R.links(3).A(qq(3));
T34=R.links(4).A(qq(4));
T45=R.links(5).A(qq(5));
T01=T01.double;
T12=T12.double;
T23=T23.double;
T34=T34.double;
T45=T45.double;
T12=T01*T12;
T23=T01*T12*T23;
T34=T01*T12*T23*T34;
T45=T01*T12*T23*T34*T45;
trplot(T01,'frame','1','color','b');
trplot(T12,'frame','2','color','r');
trplot(T23,'frame','3','color','g');
trplot(T34,'frame','4','color','y');
trplot(T45,'frame','5','color','w');
end

