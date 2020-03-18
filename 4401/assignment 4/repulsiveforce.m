
function [force] = repulsiveforce(q,n,p0)

 % radius is set to be 3
    r=3;

% the o1 is position of each joint
[T_random1,T_random2,T_random3]=fkinRPR(q);
force={0,0,0};
o1={};
o1{1}=T_random1(1:3,4);
o1{2}=T_random2(1:3,4);
o1{3}=T_random3(1:3,4);


b={};
   % the gradient of the distance function
    % A is the matrix of direction of repulsive force

A={};


%i is for three joint
for i=1:3

    % the distance is for three different obstacle
    % because all the 3 obstacles is sphere and have radius of 3
    distance_1{i} = norm(o1{i}-[0;0;25])-r;
    distance_2{i} = norm(o1{i}-[-10;-10;30])-r;
    distance_3{i} = norm(o1{i}-[20;30;10])-r;

    %do the calculate to get the position on sphere surface
    %o{i}=(x,y,z);this is the current position of joint
    % I try to find the closest point on the obstacle 
    %1, 2, 3 is for different obstacle
    %the obstacle position: [0,0,25];[-10,-10,30];[20,30,10]
        x01=o1{i}(1);
        y01=o1{i}(2);
        z01=o1{i}(3)-25;
    

        x02=o1{i}(1)+10;
        y02=o1{i}(2)+10;
        z02=o1{i}(3)-30;


        x03=o1{i}(1)-20;
        y03=o1{i}(2)-30;
        z03=o1{i}(3)-10;

    

    % calculate theta 1 2 
    % they are for different obstacle
    th11= atan2(z01, sqrt(x01^2+y01^2));
    th12=atan2(y01,x01);
    th21= atan2(z02, sqrt(x02^2+y02^2));
    th22=atan2(y02,x02);
    th31= atan2(z03, sqrt(x03^2+y03^2));
    th32=atan2(y03,x03);
   
    
    
        z11=r*sin(th11);
        y11=r*cos(th11)*sin(th12);
        x11=r*cos(th11)*cos(th12)-25;
  

        z21=r*sin(th21)+10;
        y21=r*cos(th21)*sin(th22)+10;
        x21=r*cos(th21)*cos(th22)-30;

        z31=r*sin(th31)-20;
        y31=r*cos(th31)*sin(th32)-30;
        x31=r*cos(th31)*cos(th32)-10;
   

    %b is the colsest point on the obstacle
    b{i}(:,1)=[x11;y11;z11];
    b{i}(:,2)=[x21;y21;z21];
    b{i}(:,3)=[x31;y31;z31];

%gradient of p(x)
    A{i}(:,1)= (o1{i}(1) - b{i}(:,1))/(norm(o1{i}(1) - b{i}(:,1)));
    A{i}(:,2)= (o1{i}(2) - b{i}(:,2))/(norm(o1{i}(2) - b{i}(:,2)));
    A{i}(:,3)= (o1{i}(3) - b{i}(:,3))/(norm(o1{i}(3) - b{i}(:,3)));

% because we have three obstacle, so we have three repulsive force

    if distance_1{i} > p0
        force1=[0;0;0];
    else
        force1=n{i} *(1/(distance_1{i})-1/p0)*(1/(distance_1{i})^2)*A{i}(:,1);
    end

    if distance_2{i} > p0
        force2=[0;0;0];
    else
        force2= n{i} *(1/(distance_2{i})-1/p0)*(1/(distance_2{i})^2)*A{i}(:,2);
    end

    if distance_3{i} > p0
        force3=[0;0;0];
    else
        force3= n{i} *(1/(distance_3{i})-1/p0)*(1/(distance_3{i})^2)*A{i}(:,3);
    end
        force{i}= force1+force2+force3;



end

