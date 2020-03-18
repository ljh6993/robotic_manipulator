function [q1] = invkinRPR(T)

l2=30;l3=30;
% from T, we can get the final position.x y z
if size(T) == [1 3] 
x = T(1);
y = T(2); 
z = T(3); 
end

if size(T)~=[1 3]

x=T(4,1);
y=T(4,2);
z=T(4,3);
end

c3=(sqrt(x^2+y^2)-l2)/l3;
s31=sqrt(1-c3^2);
%s32= - sqrt(1-c3^2);
theta31=atan2(s31,c3);
%theta32=atan2(s32,c3);
c1=y/(l3*c3+l2);
s1=-x/(l3*c3+l2);
theta1=atan2(s1,c1);
l11=z-l3*s31;
%l12=z-l3*s32;

%in this case, we only keep position value
q1=[theta1,l11,theta31];
%q2=[theta1,l12,theta32];

end

