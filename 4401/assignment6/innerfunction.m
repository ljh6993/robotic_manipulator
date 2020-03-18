% l2=5 cm, l3= 5 cm; link lengths lc1=l1*/2, lc2=l2/2, and lc3=l2+(l3/2);
% distance from the origin of each link to the center of mass of each link.
% ml1=ml2= ml3=0.250 Kg; mass of each link (assume that this includes the
% motor) Il1=Il2= Il3= 0.005 Kgm2; inertia of each link and motor about the
% z direction in the body attached frame.
function [Tor]=innerfunction(qq,dq,ddq)

syms y1 y2 y3 v1 v2 v3 a1 a2 a3

q =[y1,y2,y3];  % q= position of each joint

qv= [v1,v2,v3]; % qv= velocity of each joint

qa= [a1,a2,a3]; %qa = acceleration of each joint 

%variable  unit m kg kgm^2
x1 =q(1);
x2=1.5708;
x3=q(3);
l1=q(2);

l2=0.05;% the unit is m, 5 cm = 0.05 m
l3=0.05;
lc1=l1/2;
lc2=l1;
lc3=l1+sin(x3)*(l3/2);
ml1=0.25;
ml2=0.25;
ml3=0.25;
Il1=0.005;
g=9.81;

lc = [0 0.05 0.05]; 
A01 = [
    cos(q(1)) -sin(q(1)) 0 0 ;
    sin(q(1)) cos(q(1)) 0 0;
    0 0 1 0;
    0 0 0 1
    ];
A12 = [
    0 0 1 0;
    1 0 0 lc(2);
    0 1 0 q(2);
    0 0 0 1;
    ];
A23 = [
    cos(q(3)) 0 -sin(q(3)) lc(3)*cos(q(3));
    sin(q(3)) 0 cos(q(3)) lc(3)*sin(q(3));
    0 -1 0 0;
    0 0 0 1;
    ];
T_2 = A01 * A12;
T_3 = T_2 * A23;
lc = [0 0.05 0.025]; 
A23 = [
    cos(q(3)) 0 -sin(q(3)) lc(3)*cos(q(3));
    sin(q(3)) 0 cos(q(3)) lc(3)*sin(q(3));
    0 -1 0 0;
    0 0 0 1;
    ];
Tc_3 = T_2 * A23;
lc = [0 0.025 0];
A12 = [
    0 0 1 0;
    1 0 0 lc(2);
    0 1 0 q(2);
    0 0 0 1;
    ];
Tc_2=A01*A12;


z0 = [0;0;1];
z1=A01(1:3,3);  % this is for z1
z2=T_2(1:3,3);  % this is for z2
z3=T_3(1:3,3); % this is for z3
R1=A01(1:3,1:3);
R2=T_2(1:3,1:3);
R3=T_3(1:3,1:3);

o0 = [0;0;0];
o1 = A01(1:3, 4);
o2 = T_2(1:3, 4);
o3 = T_3(1:3, 4);
oc1 = A01(1:3, 4);
oc2 = Tc_2(1:3, 4);
oc3 = Tc_3(1:3, 4);

Jvc={};
Jvc{1}=[cross(z0, oc1-o0), [0;0;0], [0;0;0]];
Jvc{2}=[cross(z0, oc2-o0), z1, [0;0;0]];
Jvc{3}=[cross(z0, oc3-o0), z1, cross(z2, oc3-o2)];
Jwc={};
Jwc{1}=[z0, [0;0;0], [0;0;0]];
Jwc{2}=[z0, [0;0;0], [0;0;0]];
Jwc{3}=[z0, [0;0;0], z2];

%kinetic linear energy 
% kl=1/2 * qv*(ml1*Jvc{1}'*Jvc{1}+ml2*Jvc{2}'*Jvc{2} + ml3*Jvc{3}'*Jvc{3})*qv';

I=[0 0 0; 0 0 0;0 0 Il1]; % the inertia is same for I1 I2 I3

% kw=1/2 * qv*(Jwc{1}'*R1*I*R1'*Jwc{1}+Jwc{2}'*R2*I*R2'*Jwc{2}+Jwc{3}'*R3*I*R3'*Jwc{3})*qv';

%inertia matrix D(q)
D= ml1*Jvc{1}'*Jvc{1}+ml2*Jvc{2}'*Jvc{2} + ml3*Jvc{3}'*Jvc{3}+...
Jwc{1}'*R1*I*R1'*Jwc{1}+Jwc{2}'*R2*I*R2'*Jwc{2}+Jwc{3}'*R3*I*R3'*Jwc{3};


%Christoffel Symbols
% cijk=1/2*(ddkj/dqi+ddki/dqj-ddij/dqk) 1-3
    for j=1:3
        for i=1:3
            ck1(i,j)=1/2*(diff(D(1,j),q(i))+diff(D(1,i),q(j))-diff(D(i,j),q(1)));
        end
    end


   for j=1:3
        for i=1:3
            ck2(i,j)=1/2*(diff(D(2,j),q(i))+diff(D(2,i),q(j))-diff(D(i,j),q(2)));
        end
    end
   for j=1:3
        for i=1:3
            ck3(i,j)=1/2*(diff(D(3,j),q(i))+diff(D(3,i),q(j))-diff(D(i,j),q(3)));
        end
    end
C=sym(zeros(3,3));
    
        C(1,1)=ck1(1,1)*qv(1)+ck1(2,1)*qv(2)+ck1(3,1)*qv(3);


        C(1,2)=ck2(1,2)*qv(1)+ck2(2,2)*qv(2)+ck2(3,2)*qv(3);


        C(1,3)=ck2(1,3)*qv(1)+ck2(2,3)*qv(2)+ck2(3,3)*qv(3);
% potential energy 
p1=l1/2*ml1*g;  % first centre of mass
p2=l1*ml2*g;
p3=(lc3)*ml3*g; 
P=p1+p2+p3;
%gk
g1=diff(P,y1);      % dP/dq1
g2= diff(P,y2);       %dP/dl1
g3= diff(P,y3);             %dP/dx3

g13=[g1, g2 g3]';
% when k=1





y1=qq(1); 
y2=qq(2);
y3=qq(3);
v1=dq(1); v2=dq(2); v3=dq(3); a1=ddq(1); a2=ddq(2); a3=ddq(3);

torque=D*qa'+C*qv'+g13;
Tor= zeros(3,1);
Tor=double(subs(torque));

end 


