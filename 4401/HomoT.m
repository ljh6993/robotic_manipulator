function [T] = HomoT(q)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
x1=q(1);
x2=q(2);
x3=q(3);
x4=q(4);
x5=q(5);
x6=q(6);
a = [0,154.1,0,0,0,0];
d =[118.1,0,0,115.3,0,206];
alpha =[pi/2,0,pi/2,-pi/2,pi/2,0];

A1 =[cos(x1) -sin(x1)*cos(alpha(1)) sin(x1)*sin(alpha(1)) a(1)*cos(x1); sin(x1) cos(x1)*cos(alpha(1)) -cos(x1)*sin(alpha(1)) a(1)*sin(x1);0 sin(alpha(1)) cos(alpha(1)) d(1); 0 0 0 1];
A2 =[cos(x2) -sin(x2)*cos(alpha(2)) sin(x2)*sin(alpha(2)) a(2)*cos(x2); sin(x2) cos(x2)*cos(alpha(2)) -cos(x2)*sin(alpha(2)) a(2)*sin(x2);0 sin(alpha(2)) cos(alpha(2)) d(2); 0 0 0 1];
A3 =[cos(x3) -sin(x3)*cos(alpha(3)) sin(x3)*sin(alpha(3)) a(3)*cos(x3); sin(x3) cos(x3)*cos(alpha(3)) -cos(x3)*sin(alpha(3)) a(3)*sin(x3);0 sin(alpha(3)) cos(alpha(3)) d(3); 0 0 0 1];
A4 =[cos(x4) -sin(x4)*cos(alpha(4)) sin(x4)*sin(alpha(4)) a(4)*cos(x4); sin(x4) cos(x4)*cos(alpha(4)) -cos(x4)*sin(alpha(4)) a(4)*sin(x4);0 sin(alpha(4)) cos(alpha(4)) d(4); 0 0 0 1];
A5 =[cos(x5) -sin(x5)*cos(alpha(5)) sin(x5)*sin(alpha(5)) a(5)*cos(x5); sin(x5) cos(x5)*cos(alpha(5)) -cos(x5)*sin(alpha(5)) a(5)*sin(x5);0 sin(alpha(5)) cos(alpha(5)) d(5); 0 0 0 1];
A6 =[cos(x6) -sin(x6)*cos(alpha(6)) sin(x6)*sin(alpha(6)) a(6)*cos(x6); sin(x6) cos(x6)*cos(alpha(6)) -cos(x6)*sin(alpha(6)) a(6)*sin(x6);0 sin(alpha(6)) cos(alpha(6)) d(6); 0 0 0 1];
%homogenous transformation from frame 6 to the world frame 0
T=A1*A2*A3*A4*A5*A6;

end

