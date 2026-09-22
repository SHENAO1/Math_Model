% 获取第s号卫星的运行轨迹，下标从0开始
function ys = sat_moving(s, tspan)
% s：satinfo.txt中对应的卫星编号，下标从0开始
% tspan：积分区域，数据文件中的数据从零时刻开始，故tspan从零开始
s = s + 1;
sdata = importdata('satinfo.txt');
y0 = (sdata(s,:))';
[tt, Y] = ode45(@sat, tspan, y0);
ys =Y;
end

function  dydt = sat( t, y)
% y = [r; rdot]
% dydt = [rdot; rdotdot]
Gm = 3.986005e14;
dydt = zeros(6,1);
dydt(1:3) = y(4:6);
dydt(4:6) = - (Gm/(sqrt(y(1)^2+y(2)^2+y(3)^2))^3).*[y(1);y(2);y(3) ];
end
