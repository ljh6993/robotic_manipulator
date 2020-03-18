
%lab part 1

%syms x1 x2 x3 x4 x5 x6;
x1=0;
x2=1.5708;
x3=0;
x4=0;
x5=0;
x6=0;
a = [0,154.1,0,0,0,0];
d =[118.1,0,0,115.3,0,206];
alpha =[pi/2,0,pi/2,-pi/2,pi/2,0];
Theta = [x1,x2,x3,x4,x5,x6];
A1 =[cos(x1) -sin(x1)*cos(alpha(1)) sin(x1)*sin(alpha(1)) a(1)*cos(x1); sin(x1) cos(x1)*cos(alpha(1)) -cos(x1)*sin(alpha(1)) a(1)*sin(x1);0 sin(alpha(1)) cos(alpha(1)) d(1); 0 0 0 1];
A2 =[cos(x2) -sin(x2)*cos(alpha(2)) sin(x2)*sin(alpha(2)) a(2)*cos(x2); sin(x2) cos(x2)*cos(alpha(2)) -cos(x2)*sin(alpha(2)) a(2)*sin(x2);0 sin(alpha(2)) cos(alpha(2)) d(2); 0 0 0 1];
A3 =[cos(x3) -sin(x3)*cos(alpha(3)) sin(x3)*sin(alpha(3)) a(3)*cos(x3); sin(x3) cos(x3)*cos(alpha(3)) -cos(x3)*sin(alpha(3)) a(3)*sin(x3);0 sin(alpha(3)) cos(alpha(3)) d(3); 0 0 0 1];
A4 =[cos(x4) -sin(x4)*cos(alpha(4)) sin(x4)*sin(alpha(4)) a(4)*cos(x4); sin(x4) cos(x4)*cos(alpha(4)) -cos(x4)*sin(alpha(4)) a(4)*sin(x4);0 sin(alpha(4)) cos(alpha(4)) d(4); 0 0 0 1];
A5 =[cos(x5) -sin(x5)*cos(alpha(5)) sin(x5)*sin(alpha(5)) a(5)*cos(x5); sin(x5) cos(x5)*cos(alpha(5)) -cos(x5)*sin(alpha(5)) a(5)*sin(x5);0 sin(alpha(5)) cos(alpha(5)) d(5); 0 0 0 1];
A6 =[cos(x6) -sin(x6)*cos(alpha(6)) sin(x6)*sin(alpha(6)) a(6)*cos(x6); sin(x6) cos(x6)*cos(alpha(6)) -cos(x6)*sin(alpha(6)) a(6)*sin(x6);0 sin(alpha(6)) cos(alpha(6)) d(6); 0 0 0 1];
%homogenous transformation from frame 6 to the world frame 0
T=A1*A2*A3*A4*A5*A6;


%lab part 2.1 begin
L1 = Link('d', 118.1, 'a', 0, 'alpha', pi/2);
L2 = Link('d', 0, 'a', 154.1, 'alpha', 0);
L3 = Link('d', 0, 'a', 0, 'alpha', pi/2);
L4 = Link('d', 115.3, 'a', 0, 'alpha', -pi/2);
L5 = Link('d', 0, 'a', 0, 'alpha', pi/2);
L6 = Link('d', 206, 'a', 0, 'alpha', 0);
bot = SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'lab1');
%robot's end-effector

% draw a stick figure of our robot

% configuration 1
bot.fkine([0 pi/2 0 0 0 0]);
%bot.plot([0 pi/2 0 0 0 0]);
%Robot.sendPosition([150 150 60 150 150 150 150]);
%ans %use ans to check the 
% configuration2
 %bot.fkine([0 pi/2 pi/2 0 0 0]);
 %bot.plot([0 pi/2 pi/2 0 0 0]);
% Robot = MSE4401BOT(1234,4321);
% Robot.sendPosition([150 150 150 150 150 150 150]);



%labpart2.3
% need to change the number of invkinCC
 q1 = invkinCC(T);
 %same as we run invkinCC(ans)
 
 
%labpart2.4
 %qi = bot.ikine(T, 'pinv');
 %q2 = bot.ikine(T)
% 
%  mdl_puma560;
%  q2 = [0 pi/2 pi/2 0 0 0];
%  T2 = p560.fkine(q2);
%q2=bot.ikine(T);
q2=[0 pi/2 0 0 0 0];
initTrans=bot.fkine(q2);
disp(initTrans)
q3=bot.ikine(initTrans, 'pinv');
disp(q3);
%bot.plot([0 pi/2 0 0 0 0]);
bot.plot(q3);


