

L1 = Link('d', 118.1, 'a', 0, 'alpha', pi/2);
L2 = Link('d', 0, 'a', 154.1, 'alpha', 0);
L3 = Link('d', 0, 'a', 0, 'alpha', pi/2);
L4 = Link('d', 115.3, 'a', 0, 'alpha', -pi/2);
L5 = Link('d', 0, 'a', 0, 'alpha', pi/2);
L6 = Link('d', 206, 'a', 0, 'alpha', 0);
bot = SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'lab1');
% 
% %configuration 1
% q_in=[0 1 0 pi/2 0 0];

%  %configuration 2
 q_in=[1 pi/2 1 0 1 0];


% %homogenous transformation from frame 6 to the world frame 0
% T_in = HomoT(q_in);
% 
% q_out = invkinCC(T_in);
% 
% T_out=HomoT(q_out);


T_in=bot.fkine(q_in);
disp(T_in)
q_out=bot.ikine(T_in, 'pinv');
disp(q_out);
T_out=bot.fkine(q_out);


% bot.plot(q_out);
% title('configuration 2 from inverse transformation');


