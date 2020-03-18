function [Ttorque] = potentialfield(q,qf,e,d,n,p0)

%get the transformation matrix from fkinRPR
[T11,T21,T31]=fkinRPR(q);
% the robot is three joint.
[T12,T22,T32]=fkinRPR(qf);

o11=T11(1:3,4);
o21=T21(1:3,4);
o31=T31(1:3,4);

o12=T12(1:3,4);
o22=T22(1:3,4);
o32=T32(1:3,4);

% calculate the difference between each oiqs and oipf
B{1}=(o11-o12);
B{2}=(o21-o22);
B{3}=(o31-o32);


Fatt={};

for i=1:3

    if norm(B{i})<=d
        Fatt{i}=-e{i}*B{i};
    else
        Fatt{i}=-d*e{i}*B{i}/norm(B{i});
       
    end

end 
% disp(Fatt{3});

%repulsive force 
Frep={};
Frep=repulsiveforce(q,n,p0);


Jv={};
Jv=JacobRPR(q);

%total joint torques acting on the manipulator is

Ttorque=transpose(Jv{1})*Fatt{1}+transpose(Jv{2})*Fatt{2}+transpose(Jv{3})*Fatt{3}+...
transpose(Jv{1})*Frep{1}+transpose(Jv{2})*Frep{2}+transpose(Jv{3})*Frep{3};
%Ttorque=transpose(Jv{3})*Fatt{3}+transpose(Jv{3})*Frep{3};
end