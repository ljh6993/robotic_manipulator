function [T1,T2,T3] = fkinRPR(Thetaq)

% Thetaq=[x1 l1 d3]

% define value of l2 and l3

l2=30;
l3=30;

x1 =Thetaq(1);
x2=1.5708;
x3=Thetaq(3);
l1=Thetaq(2);
a = [0,l2,l3];

d =[0,l1,0];
alpha =[0,1.5708, -1.5708];


A1=[cos(x1) -sin(x1)*cos(alpha(1)) sin(x1)*sin(alpha(1)) a(1)*cos(x1); ...
 sin(x1) cos(x1)*cos(alpha(1)) -cos(x1)*sin(alpha(1)) a(1)*sin(x1);...
0 sin(alpha(1)) cos(alpha(1)) d(1); 0 0 0 1];
A2=[cos(x2) -sin(x2)*cos(alpha(2)) sin(x2)*sin(alpha(2)) a(2)*cos(x2); ...
sin(x2) cos(x2)*cos(alpha(2)) -cos(x2)*sin(alpha(2)) a(2)*sin(x2);...
0 sin(alpha(2)) cos(alpha(2)) d(2); 0 0 0 1];
A3=[cos(x3) -sin(x3)*cos(alpha(3)) sin(x3)*sin(alpha(3)) a(3)*cos(x3);...
 sin(x3) cos(x3)*cos(alpha(3)) -cos(x3)*sin(alpha(3)) a(3)*sin(x3);...
0 sin(alpha(3)) cos(alpha(3)) d(3); 0 0 0 1];
T1=A1;
T2=(A1*A2);
T3=(A1*A2*A3);

end

