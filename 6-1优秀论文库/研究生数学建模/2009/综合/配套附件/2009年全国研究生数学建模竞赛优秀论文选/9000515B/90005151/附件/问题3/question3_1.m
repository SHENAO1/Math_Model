
% for i=1:6
%     for j=1:2
%         eval(sprintf('load a%d_%d;',i,j));
%         for k=1:4
%             eval(sprintf('data1=a%d_%d_%d(:,3);',i,j,k));
%             data1=normit(data1);data1=reshape(data1,564,756)';
%             data1=medfilt2(data1); % 中值滤波
%             [d1 ds1]=wavedec2(data1,1,'db1');y1a=detcoef2('a',d1,ds1,1);
%             y1aa=resizephoto(y1a,2,1);
%             data11=data1-normit(y1aa);
%             data{i,j,k}=data11;
%         end
%         eval('clear(''-regexp'',''^a'')');
%         clear data1 data11;
%     end
% end
% % 画图
% for i=1:6
%     figure,
%     index=0;
%     for j=1:2
%         for k=1:4
%             index=index+1;
%             subplot(2,4,index);imshow(imadjust(data{i,j,k}));
%         end
%     end
% end
% save question3_1mat
%% 第二步:截图,仿射变换,变后后再裁剪
% 仿射变换参数
% tmp1=[61,0;169,0;204,557;73,557];
% tmp2=[73,0;204,0;204,557;73,557];
% h=maketform('projective',tmp1,tmp2);
% % 数据1_1_1:           截区域
% for i=1:6
%     figure,index=0;
%     for j=1:2
%         for k=1:4
%             % 截取一部分图像,存入xx
%             xx=data{i,j,k};
% %             figure,imshow(imadjust(xx));
%             tmpx=55;tmpy=350;indexx=tmpx+[0:300];indexy=tmpy+[0:300];
%             xx=xx(indexy,indexx);
%             % hough变换
%             data_2=imtransform(xx,h);
%             data_2=data_2(:,1:300); % x取1:300
% %             figure,imshow(imadjust(data_2));
%             data2{i,j,k}=data_2;
%             % 画出图
%             index=index+1;subplot(2,4,index);imshow(imadjust(data_2));
%         end
%     end
% end
% save question3_2mat data2
% 第三步 画出剖面图,得到剖面数据data3
% for i=1:6
%     figure,index=0;
%     for k=1:4
%         index=index+1;subplot(2,2,index);hold on;title(sprintf('%d',k));
%         for j=1:2
%             data3{i,j,k}=mean(data2{i,j,k},1);
%             if(j==1)
%                 plot(data3{i,j,k},'b');
%             else
%                 plot(data3{i,j,k},'r');
%             end
%         end
%     end
% end
% save question3_3mat data3
% % 第四步,求出第i枪的第1个子弹与第2个子弹的距离,存于DD{i,i}中,并将矫正后的曲线2
% D=zeros(6,4);
for i=1:6
    for j=i:6
        D=zeros(4,4);    
        for k=1:4
            for l=1:4
                fprintf('i=%d,j=%d,k=%d,l=%d\n',i,j,k,l);
                [D(k,l),data4{i,j,k,l}]=question3fun([[1:300-5];data3{i,1,k}(6:end)],[[1:300-5];data3{j,2,l}(6:end)]);
                fprintf('D(%d,%d)=%f',k,l,D(k,l));
            end
        end
        DD{i,j}=D;
    end
end
% save question3_4mat  DD data4          
% % 画出曲线
for i=1:6
    for j=i:6
        D1=min(sum(DD{i,j},2));
        D2=min(DD{i,j}(1,2)+DD{i,j}(2,3)+DD{i,j}(3,4)+DD{i,j}(4,1));
        D3=min(DD{i,j}(1,3)+DD{i,j}(2,4)+DD{i,j}(3,1)+DD{i,j}(4,2));
        D4=min(DD{i,j}(1,4)+DD{i,j}(2,1)+DD{i,j}(3,2)+DD{i,j}(4,3));
        [tmp1,tmp2]=min([D1,D2,D3,D4]);
        define1(i)=tmp2; % 这个代表方案
        DDD(i,j)=tmp1/4; % 这个代表最小距离
%     T{i,i}=[data4{i,1,round(mod(1+tmp2-1,4.1))};data4{i,2,round(mod(2+tmp2-1,4.1))};data4{i,3,round(mod(3+tmp2-1,4.1))};data4{i,4,round(mod(4+tmp2-1,4.1))}];
    end
end
% % DDD=[DDD;zeros(1,6)];
% % DDD(find(DDD==0))=inf;
% % for i=1:6
% %     figure,
% %     for j=1:4
% %         subplot(2,2,j);hold on;
% %         plot(T{i,i}((j-1)*2+1,:),'b');plot(T{i,i}((j-1)*2+2,:),'r');
% %     end
% % end
% save question3_5mat

% 算出各个图像与谁匹配,匹配方案是什么
% DDD2=[DDD;zeros(1,6)]'+[DDD;zeros(1,6)]+diag(inf*ones(1,6)); % 将对角线置为inf,并将矩阵与其转置求个和
DDD2=DDD'+DDD;
for i=1:6
    DDD2(i,i)=DDD2(i,i)-DDD(i,i);
end
[tmp1,tmp2]=sort(DDD2,2);
question3result1=tmp2; % 与其最匹配的前5个图象
question3result2=tmp1; % 与最匹配的5个图象的距离