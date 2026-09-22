clear all %主函数 6点系统误差求最优
clc
load meadata_09_00.txt
load new06.txt
load mea09lc.txt
load mea06lc.txt
dg61=-0.02;dg62=0.01;dg63=0.02;
da61=-0.02;da62=0.01;da63=0.02;
db61=0;db62=0.001;db63=0.004;
dg91=-0.02;dg92=0.01;dg93=0.02;
da91=-0.02;da92=0.01;da93=0.02;
db91=-0.02;db92=0.01;db93=0.02;
for i=1:10
minlnds=10^12;count=0;
for dg6=dg61:dg62:dg63
    for da6=da61:da62:da63
        for db6=db61:db62:db63
            for dg9=dg91:dg92:dg93
                for da9=da91:da92:da93
                    for db9=db91:db92:db93
[g6 r6]=abjiaodu(new06);
[g9 r9]=abjiaodu(meadata_09_00);%ab平面转角
n=length(meadata_09_00(:,1));
new06n=zeros(n,3);
new06n(:,1)=meadata_09_00(:,1);
new06n(:,2)=r6.*cos(g6+dg6)+da6;
new06n(:,3)=r6.*sin(g6+dg6)+db6;%6观测角系统误差加入

meadata_09_00n=zeros(n,3);
meadata_09_00n(:,1)=meadata_09_00(:,1);
meadata_09_00n(:,2)=r9.*cos(g9+dg9)+da9;
meadata_09_00n(:,3)=r9.*sin(g9+dg9)+db9;

stot6=zuobiaobianhuan(mea06lc,new06n);
stot9=zuobiaobianhuan(mea09lc,meadata_09_00n);
ln6=qiuln(stot6,mea06lc);
ln9=qiuln(stot9,mea09lc);
lnds=line_distance(ln6,ln9);
sumlnds=sum(lnds(:,2));
if sumlnds<minlnds
    minlnds=sumlnds;
    d=[dg6 da6 db6;dg9 da9 db9];
    opt_ln6=ln6;
    opt_ln9=ln9;
end
                    end
                end
            end
        end
count=count+1 
    end
end
minlnds
d
dg61=d(1,1)-dg62;dg63=d(1,1)+dg62;dg62=dg62/2;
da61=d(1,2)-da62;da63=d(1,2)+da62;da62=da62/2;
db61=d(1,3)-db62;db63=d(1,3)+db62;db62=db62/2;
dg91=d(2,1)-dg92;dg93=d(2,1)+dg92;dg92=dg92/2;
da91=d(2,2)-da92;da93=d(2,2)+da92;da92=da92/2;
db91=d(2,3)-db92;db93=d(2,3)+db92;db92=db92/2;
i
end
minlnds
d
d6jd=[dg62 da62 db62]*2
d9jd=[dg92 da92 db92]*2
d6=[dg61 dg62 dg63;da61 da62 da63;db61 db62 db63];
d9=[dg91 dg92 dg93;da91 da92 da93;db91 db92 db93];