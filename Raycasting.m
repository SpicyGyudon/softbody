function data=Raycasting(point,body)
count = 0;
c = point;
d = [0 330.123];
for i = 1 : length(body)-1
    a=body(i,:); b=body(i+1,:);
    intersect_first = CCW(a,b,c)*CCW(a,b,d);
    intersect_second = CCW(c,d,a)*CCW(c,d,b);
    count = count + intersect(intersect_first,intersect_second);
end

data=rem(count,2);

end