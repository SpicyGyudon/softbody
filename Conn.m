function connect=Conn(n,width,height,connect)
dx = [-1,0,1,-1,1,-1,0,1];
dy = [-1,-1,-1,0,0,1,1,1];
temp = [];
x = rem(n,width); 
if x == 0
    x = width;
end
y = (n-x)/width+1;

for i = 1 : length(dx)
    nx = x + dx(i);
    ny = y + dy(i);
    if and(and(0<nx,nx<width+1),and(0<ny,ny<height+1))
        temp = [temp,[nx+(ny-1)*width]];
    else
        temp = [temp,[0]];
    end
end
connect = vertcat(connect,temp);
end