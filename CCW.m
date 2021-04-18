function data = CCW(a,b,c)
data = a(1)*b(2)+b(1)*c(2)+c(1)*a(2)-b(1)*a(2)-c(1)*b(2)-a(1)*c(2);

if data > 0
    data = 1;
elseif data < 0
    data = -1;
else
    data = 0;
end

end