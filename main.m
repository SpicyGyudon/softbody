% masspoint (potision, velocity, force, mass)
% update : every frame (F=0 -> F+=gravity,spring, etc)
%                       v+= F*dt/m
%                       x+= v*dt
%                       
% spring mass model 
%  Spring (Fs = Ks * (abs(B-A)-L0(평형길이)) )
%  Damping (Fd = Kd * 속도차)
%                      (B-A)/abs(B-A) dot (VB-VA)
% Ft = Ks * (abs(B-A)-L0) + Kd * dot((B-A)/abs(B-A),(VB-VA))
%      -> Fa = Ft * (B-A)/abs(B-A)
%      -> Fb = Ft * (A-B)/abs(A-B)
% collision (충돌감지 알고리즘) -> 벽의 X~Y 범위 설점 
%     -> Raycasting  -> 점들간의 교점 CCW(Ai,Ai+1,P)
% Ax*By-Bx*Ay + Bx*Cy -Cx*By + Cx+Ay -Ax*Cy;
% Cross(A,B) + Cross(B,,C) + Cross(C,A)

clear;clc;
L0 =0.3;
xi = -1.8; yi = 5;
width = 10;
height = 5;

point = [];
for j = 1 : height
    for i= 1 : width
        point = [point,[xi+i*L0;yi+j*L0]];
    end
end
connect = [];
for k = 1 : height*width
    connect=Conn(k,width,height,connect);
end

dof = length(point(1,:));
v = zeros(2,dof);

mass = 1;
Ks= 1300; Kd=200;
g = 9.81;
dt = 0.001;
tf = 5;

body(:,:,1) = [-10,0;-10,-10;10,-10;10,0;-10,0] ;
body(:,:,2) = [1,1; 2,2; 1,3 ; 0,2; 1,1];
body(:,:,3) = [-2,3; -1,4; -2,5 ; -3,4; -2,3];
body(:,:,4) = [-2,0.1; -1,0.1; -1,0.5 ; -2,1.7; -2,0.1];
body(:,:,5) = [-1.1, 0.1; 0,0.1;0,0.5 ; -1.1, 0.5; -1.1, 0.1];
interval_step = 30;
N=0;
idx=1;


for i = 0 : dt : tf
    F=force(point,v,Ks,Kd,L0,dof,mass,g,connect);
    v = v + F * dt/mass;
    point = point + v * dt;
    
    for k = 1 : length(point(1,:))
    for j = 1 : length(body(1,1,:))
        bool = Raycasting(point(:,k),body(:,:,j));
        if bool == 1
            [point(:,k),v(:,k)] = collision(point(:,k),v(:,k),body(:,:,j));
            break
        end
    end
    end
    if N == interval_step
        X(idx,:) = point(1,:); Y(idx,:) = point(2,:);
        idx = idx+1;
        N=0;
    end 
    N=N+1;
%     i/tf*100
end

for idx = 1 : length(X)

figure(1)
plot(body(:,1,1),body(:,2,1),'LineWidth',2)
hold on; 
plot(body(:,1,2),body(:,2,2),'LineWidth',2)
plot(body(:,1,3),body(:,2,3),'LineWidth',2)
plot(body(:,1,4),body(:,2,4),'LineWidth',2)
plot(body(:,1,5),body(:,2,5),'LineWidth',2)
plot(X(idx,:),Y(idx,:),'ro','LineWidth',2)
hold off; 
axis([-5 5 -2 8])

end
