function [x,v] = collision(point,v_point,body)

for i = 1 : length(body)-1
    x0=body(i,1); y0 = body(i,2);
    x1=body(i+1,1); y1 = body(i+1,2);
    xd =x1-x0; yd = y1 - y0;
    A = [yd -xd;xd yd];
    C = [x0*yd-y0*xd ; point(1)*xd+point(2)*yd];
    B(:,i) = A\C;
    normB(i) = norm(B(:,i)-point);
end
[size, arg] = min(normB);
x = B(:,arg); n = (x-point)/norm(x-point);
V=norm(v_point); d = v_point/V;
v = V*(d-2*(d'*n)*n);
end