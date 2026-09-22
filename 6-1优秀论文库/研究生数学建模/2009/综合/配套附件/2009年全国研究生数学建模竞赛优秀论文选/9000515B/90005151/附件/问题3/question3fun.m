function [D,x_val]=question3fun(x1,x2)
% % N=400; % 取第N个剖面,如果N=N1:N2,则取这些面的平均剖面
% % M=40:400; % 只要M里包含的x值所对应的剖面,目的是为了手工地去掉没有刻痕的部分
% 二维变换的四个参数:(K为X方向上的拉伸)
K=1;deltax=0;deltaz=0;theta=0;
% K的范围:1/2~2,步长0.02
% deltax,deltaz的范围:-22*0.00275~22*0.00275,步长0.00275
% theta的范围:0.4/180*pi,步长0.4/180*pi/10
D=inf;K_val=1;deltax_val=0;deltaz_val=0;theta_val=0;
% 下面是data1与data2的最小均方差
% for K=[1/10:0.5:0,0:0.5:2]
     for deltax=-0.6:0.2:0.6
        for deltaz=-0.6:0.2:0.6
            for theta=-0.4/180*pi:0.04/180*pi:0.4/180*pi
                R=[cos(theta),-sin(theta);sin(theta),cos(theta)];
%                 x2(1,:)=100*x2(1,:);
                x2s=R*x2+repmat([deltax;deltaz],1,size(x1,2));
%                 x2s(1,:)=x2s(1,:)/100;x2(1,:)=x2(1,:)/100;
                x2t=interp1(x2s(1,:),K*x2s(2,:),x1(1,:),'linear');
                ndx=find(~isnan(x2t)); %  这里我多加了个1:maxindex-10，指的是手动剃掉屑痕(maxindex应该就代表屑痕
                tmpD=sum((x2t(ndx).*256-x1(2,ndx).*256).^2)/length(ndx);
                if(tmpD<D)
                    D=tmpD;
                    K_val=K;deltax_val=deltax;deltaz_val=deltaz;theta_val=theta;x_val=[x1(2,:);x2t];
                end
            end
        end
     end
% end
% 1
% figure,plot(x1,'b');hold on;plot(x2_val,'r');