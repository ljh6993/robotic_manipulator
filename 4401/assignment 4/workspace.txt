
clear all; 
clc;
figure
hold on 

% Part 2 of Assignement
%Creating a workspace and obstacles

%define the length of robot
% l1 is considered to be variable d2
l2=30;l3=30;

%define workspace according to robot link lengths and dx,dy,dz equations
% generate 30 piont between -180 degree and 180 degree. 
% generate 10 point between 0 to 20, which is the ability of prismatic joint
% the order is for first joint, second joint and third joint
t1=linspace(-180,180,30)*pi/180;
d2=linspace(0,20,10);
t3=linspace(-180,180,30)*pi/180;

[T1,D2,T3]=ndgrid(t1,d2,t3);


xM=round(-sin(T1).*(l3*cos(T3)+l2));

yM=round(cos(T1).*(l3*cos(T3)+l2));

zM=round(abs(l3*sin(T3)+D2));


plot3(xM(:),yM(:),zM(:),'-b','LineWidth',1)

hold on 
%define obstacles
% build a sphere with 50 surface
[x,y,z] = sphere(50);
% the  obstacle is in pisitions [0,0,25];[-10,-10,30];[20,30,10]
% make all this sphere with a radiu of 3
r=3;
surf(r*x+0,r*y+0,r*z+25);
surf(r*x-10,r*y-10,r*z+30);
surf(r*x+20,r*y+30,r*z+10);

%assign a starting point to be qs=[-pi/2,10,0] 60 -3 3
a=-sin(-pi/2).*(l3*cos(0)+l2);
b=cos(-pi/2).*(l3*cos(0)+l2);
c=abs(l3*sin(0)+10);
surf(x+a, y+b,z+c);
%the ending point is qf=[pi/2,5,pi/2] 30 0 30
%surf(x-sin(pi/2).*(l3*cos(pi/2)+l2),y+cos(pi/2).*(l3*cos(pi/2)+l2),z+abs(l3*sin(pi/2)+5));



