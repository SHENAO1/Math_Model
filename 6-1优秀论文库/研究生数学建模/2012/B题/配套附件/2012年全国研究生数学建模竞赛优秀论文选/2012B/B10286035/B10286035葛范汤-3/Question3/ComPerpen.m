function [com_org com_dir] = ComPerpen( org1,dir1, org2,dir2 )%均为3*1矩阵 求两直线的公垂线

A = dir1(2)*dir2(3) - dir2(2)*dir1(3);
B = dir1(3)*dir2(1) - dir2(3)*dir1(1);
C = dir1(1)*dir2(2) - dir2(1)*dir1(2);
com_dir = [A B C]';

fenmu_mx = [com_dir dir1 dir2];
fenmu = det(fenmu_mx);
if fenmu==0
    com_org=0;
    com_dir=0;
else
    fenzi_mx = [com_dir org2-org1 dir2];
    fenzi = det(fenzi_mx);
    t1 = fenzi/fenmu;
    com_org = [org1(1)+dir1(1)*t1 org1(2)+dir1(2)*t1 org1(3)+dir1(3)*t1]';
end