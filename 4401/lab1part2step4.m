
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


%configuration 1
q2=[0 0 1 pi/2 0 0];
initTrans=bot.fkine(q2);
disp(initTrans)
q3=bot.ikine(initTrans, 'pinv');
disp(q3);
%bot.plot(q2);
%title('configuration 1');
%bot.plot(q3);
title('configuration 1 from inverse transformation');
% 
% Robot = MSE4401BOT(1234,4321);
% Robot.sendPosition([150 60 60 30 150 150 150]);
% %configuration 2
% q2=[0 pi/2 1 0 1 0];
% initTrans=bot.fkine(q2);
% disp(initTrans)
% q3=bot.ikine(initTrans, 'pinv');
% disp(q3);
% %bot.plot([0 pi/2 pi/2 1 0 0]);
% bot.plot(q3);
% title('configuration 2 from inverse transformation');
