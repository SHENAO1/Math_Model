%% 数据 
% PointA = [0.006719, 0.2843];
% PointB = [0.2425,   0.9633];
% PointC = [0.9991,   0.5821];
% PointD = [0.8151,   0.0572];

[u_area u_trans] = GuiYiHua(u_xm);
[F_area F_trans] = GuiYiHua(F_xm);
Points = [u_area' F_area'];

chongcheng1 = (PointC(1) - PointB(1)) * u_trans(1);
chongcheng2 = (PointD(1) - PointA(1)) * u_trans(1);
fprintf('上有效冲程(米) = %f\n', chongcheng1);
fprintf('下有效冲程(米) = %f\n', chongcheng2);
fprintf('有效冲程(米)   = %f\n', min([chongcheng1, chongcheng2]));

%% 求出两条直线方程, 和两条直线的交点
PmidAB = (PointA+PointB)/2;
PmidBC = (PointB+PointC)/2;
line1 = BuildLine(PmidAB, PointC-PointB);
line2 = BuildLine(PmidBC, PointB-PointA);
PointE = LineCross(line1, line2);

%% 搜索两条直线与示功图的交点
len = length(u_area);   
l1State = 0;    l2State = 0;
crosses1 = [];  crosses1_index = [];
crosses2 = [];  crosses2_index = [];
for i = 1:len
    point = [u_area(i) F_area(i)];
    l1State_new = evalLine(line1, point);
    l2State_new = evalLine(line2, point);
    if i>1
        if l1State*l1State_new <= 0 
            tmpLine = BuildLine(point, point-lastPoint);
            crosses1 = [crosses1; LineCross(tmpLine, line1)];
            crosses1_index = [crosses1_index i];
        end
        if l2State*l2State_new <= 0 
            tmpLine = BuildLine(point, point-lastPoint);
            crosses2 = [crosses2; LineCross(tmpLine, line2)];
            crosses2_index = [crosses2_index i];
        end
    end
    l1State = l1State_new;
    l2State = l2State_new;
    lastPoint = point;
end
% 保证crosses1(1)在crosses1(2)的左侧
if crosses1(1,1) > crosses1(2,1)
    crosses1 = crosses1([2 1],:);
    crosses1_index = crosses1_index([2 1]);
end
% 保证crosses2(1)在crosses2(2)的上侧
if crosses2(1,2) < crosses2(2,2)
    crosses2 = crosses2([2 1],:);
    crosses2_index = crosses2_index([2 1]);
end

%% 求出四个不规则形状的边界
arc1 = crosses2_index(2) : (crosses1_index(1)-1);
if isempty(arc1)
    arc1 = [crosses2_index(2):len, 1:(crosses1_index(1)-1)];
end
arc2 = crosses1_index(1) : (crosses2_index(1)-1);
if isempty(arc2)
    arc2 = [crosses2_index(1):len, 1:(crosses2_index(1)-1)];
end
arc3 = crosses2_index(1) : (crosses1_index(2)-1);
if isempty(arc3)
    arc3 = [crosses2_index(1):len, 1:(crosses1_index(2)-1)];
end
arc4 = crosses1_index(2) : (crosses2_index(2)-1);
if isempty(arc4)
    arc4 = [crosses1_index(2):len, 1:(crosses2_index(2)-1)];
end

shape1 = [PointE; crosses2(2,:); Points(arc1,:); crosses1(1,:); ];
shape2 = [PointE; crosses1(1,:); Points(arc2,:); crosses2(1,:); ];
shape3 = [PointE; crosses2(1,:); Points(arc3,:); crosses1(2,:); ];
shape4 = [PointE; crosses1(2,:); Points(arc4,:); crosses2(2,:); ];

area1 = polyarea(shape1(:,1), shape1(:,2));
area2 = polyarea(shape2(:,1), shape2(:,2));
area3 = polyarea(shape3(:,1), shape3(:,2));
area4 = polyarea(shape4(:,1), shape4(:,2));
fprintf('--------------------------------\n');
fprintf('面积1 = %f \n', area1);
fprintf('面积2 = %f \n', area2);
fprintf('面积3 = %f \n', area3);
fprintf('面积4 = %f \n', area4);

%% 画
figure; hold on;
WHITE = [1 1 1];
fill(shape1(:,1), shape1(:,2), WHITE*0.4);
fill(shape2(:,1), shape2(:,2), WHITE*0.5);
fill(shape3(:,1), shape3(:,2), WHITE*0.7);
fill(shape4(:,1), shape4(:,2), WHITE*0.8);
plot(u_area, F_area, '-' ,'linewidth',2);
plot([PointA(1) PointB(1) PointC(1) PointD(1) PointE(1)],     ...
        [PointA(2) PointB(2) PointC(2) PointD(2) PointE(2)],  ...
        'r*', 'markersize',12, 'linewidth',2);
plot(crosses1(:,1), crosses1(:,2), 'r', crosses1(:,1), crosses1(:,2), 'bo','linewidth',2);
plot(crosses2(:,1), crosses2(:,2), 'r', crosses2(:,1), crosses2(:,2), 'bo','linewidth',2);
legend('\fontsize{12}区域1', '\fontsize{12}区域2', '\fontsize{12}区域3', '\fontsize{12}区域4', '\fontsize{12}泵示功图');
text(PointA(1)+0.02, PointA(2), 'A', 'FontSize',18);
text(PointB(1)+0.02, PointB(2), 'B', 'FontSize',18);
text(PointC(1)+0.02, PointC(2), 'C', 'FontSize',18);
text(PointD(1)+0.02, PointD(2), 'D', 'FontSize',18);
text(PointE(1)+0.02, PointE(2), 'E', 'FontSize',18);
xlabel('\fontsize{12}归一化位移'); ylabel('\fontsize{12}归一化载荷');
title('\fontsize{15}一级杆油井泵示功图');
xlim([-0.1, 1.1]);
ylim([-0.1, 1.1]);
grid on; box on;



