function [com_mid] = ComPerpenMid( org1,dir1, org2,dir2 )%均为3*1矩阵 求两直线的公垂线中点

[com_beg com_dir] = ComPerpen( org1,dir1, org2,dir2 );
[com_end com_dir] = ComPerpen( org2,dir2, org1,dir1 );

com_mid = (com_beg+com_end)/2;