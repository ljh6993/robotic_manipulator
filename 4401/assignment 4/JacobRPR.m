
function [Jv] = JacobRPR(Thetq)

% define the variable l1 l2 l3 x1 x2 x3 for degree
l2=5;l3=5;

x1=Thetq(1);
%x2=1.5708;
x3=Thetq(3);
l1=Thetq(2);

A01 = [cos(x1) -sin(x1) 0 0; sin(x1) cos(x1) 0 0; 0 0 1 0; 0 0 0 1];
A12 = [0 0 1 0;1 0 0 l2; 0 1 0 l1; 0 0 0 1];
A23 =[cos(x3) 0 -sin(x3) l3*cos(x3);sin(x3) 0 cos(x3) l3*sin(x3);0 -1 0 0; 0 0 0 1];


T01 = A01;
T02 = T01*A12;
T03 = T02*A23;

z0 = [0;0;1];
z1 = T01(1:3, 3);
z2 = T02(1:3, 3);
%z3 = T03(1:3, 3);

O0 = [0;0;0];
O1 = T01(1:3, 4);
O2 = T02(1:3, 4);
O3 = T03(1:3, 4);

% J = [cross(z0, O3-O0), z1, cross(z2, O3-O2);z0, 0, z2];
% 
% J = simplify([cross(z0, O3-O0), z1, cross(z2, O3-O2);z0, 0, z2]);
Jv={};

% show the calculate for intermiate jacobian
Jv{1}=[cross(z0, O1-O0), [0;0;0], [0;0;0]];
Jv{2}=[cross(z0, O2-O0), z1, [0;0;0]];
Jv{3}=[cross(z0, O3-O0), z1, cross(z2, O3-O2)];
end

