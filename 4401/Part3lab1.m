%lab part 3

syms x1 x2 x3 x4 x5 x6;                 
a = [0,154.1,0,0,0,0];
d =[118.1,0,0,115.3,0,206];
alpha =[pi/2,0,pi/2,-pi/2,pi/2,0];
%Theta = [x1,x2,x3,x4,x5,x6];
A01 = [cos(x1) 0 sin(x1) 0; sin(x1) 0 -cos(x1) 0; 0 1 0 118.1; 0 0 0 1];
A12 = [cos(x2) -sin(x2) 0 154.1*cos(x2);sin(x2) cos(x2) 0 154.1*sin(x2); 0 0 1 0; 0 0 0 1];
A23 =[cos(x3) 0 sin(x3) 0;sin(x3) 0 -cos(x3) 0;0 1 0 0;0 0 0 1];
A34 = [cos(x4) 0 -sin(x4) 0; sin(x4) 0 cos(x4) 0; 0 -1 0 115.3; 0 0 0 1];
A45 = [cos(x5) 0 sin(x5) 0; sin(x5) 0 -cos(x5) 0; 0 1 0 0;  0 0 0 1];
A56 = [cos(x6) -sin(x6) 0 0; sin(x6) cos(x6) 0 0; 0 0 1 206; 0 0 0 1];



%homogenous transformation from frame 6 to the world frame 0
vpa(A01,3);

T=A01*A12*A23*A34*A45*A56;

%multiplications
A2 = A01*A12;
A3 = A2*A23;
A4 = A3*A34;
A5 = A4*A45;


%For Jw in revolute joints, Jw = [z0 z1 z2 z3 z4 z5]

z0 = [ 0; 0; 1];
z1 = [sin(x1);  -cos(x1); 0];
z2 = [sin(x1);-cos(x1); 0];
z3 = A3(1:3,3);
z4 = A4(1:3,3);
z5 = A5(1:3,3);

Jw = [z0 z1 z2 z3 z4 z5];

%Jor Jv we need zi-1 and Oi-1
%from definition
o0 = [ 0; 0; 0];
o1 = [0; 0; 1181/10];
o2 = A2(1:3,4);
o3 = A3(1:3,4);
o4 = A4(1:3,4);
o5 = A5(1:3,4);
o6 = T(1:3,4);

%cross product
C0 = cross(z0, (o6-o0));
C1 = cross(z1,(o6-o1));
C2= cross(z2,(o6-o2));
C3 = cross(z3,(o6-o3));
C4 = cross(z4,(o6-o4));
C5 = cross(z5, (o6-o5));

Jv = [ C0 C1 C2 C3 C4 C5];

%Jacobian matrix as function of Jv and Jw
J = [Jv; Jw];
%singularities come from det(Jv) = 0
sing = det(J);
singularity = simplify(sing);
theta2 = solve(singularity ==0, x2)
theta3 = solve(singularity ==0, x3)
theta5 = solve(singularity ==0, x5)
subs(singularity, x3, pi/2)