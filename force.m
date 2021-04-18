function F = force(x,v,Ks,Kd,L0,dof,mass,g,connect)
F = zeros(2,dof);

for i = 1 : dof
    A = x(:,i); Va = v(:,i);
    temp_connect = nonzeros(connect(i,:));
    tempB = A; tempVb=Va;
    for k = 1 : length(temp_connect)
        tempB = [tempB,x(:,(temp_connect(k)))];
        tempVb = [tempVb,v(:,(temp_connect(k)))];
    end
    tempB(:,1) = [] ; tempVb(:,1) = [];
    for j = 1 : length(tempB(1,:))
        B = tempB(:,j); Vb = tempVb(:,j);
        Ft = Ks * (norm(B-A)-L0) + Kd * ((B-A)/norm(B-A))'*(Vb-Va);
        Fa = Ft * (B-A)/norm(B-A);
        F(:,i) = F(:,i) + Fa;
    end
F(:,i) = F(:,i) + [0; -mass * g];
end

end