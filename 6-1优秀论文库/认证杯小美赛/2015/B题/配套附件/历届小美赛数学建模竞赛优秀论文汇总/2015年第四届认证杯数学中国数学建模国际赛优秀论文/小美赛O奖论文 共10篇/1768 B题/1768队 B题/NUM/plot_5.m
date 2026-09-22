clear;    %两张季节图
load NUM_ALL.mat
NU = NUM_ALL;
key_ = 13/28;  %
NU(:,:,30) = NU(:,:,30)*key_;
NU(:,:,1:29) = NU(:,:,1:29)*((1-key_)/29);

X = 1991:2015;
x = 1:6;
T = NU(:,[1:2,9:12],:);
t =  mean(sum(T,3),2)';  
t(25) = -21;  %
plot(1991:2015,t,'*--');
hold on;
A1 = polyfit(X,t,1);
Y1 = polyval(A1,X);
plot(1991:2015,Y1,'LineWidth',3);
A1 = polyfit(X,t,5);
Y1 = polyval(A1,X);
plot(1991:2015,Y1,'LineWidth',2);


figure(2);
T1 = NU(:,3:8,:);
t1 =  mean(sum(T1,3),2)'; 
t1(25) = -31;
plot(1991:2015,t1,'*--');
hold on;
A2 = polyfit(X,t1,1);
Y2 = polyval(A2,X);
plot(1991:2015,Y2,'LineWidth',3);
A2 = polyfit(X,t1,5);
Y2 = polyval(A2,X);
plot(1991:2015,Y2,'LineWidth',2);


% T_ = mean(T(:,[6]),2)';
% x = 1:25;
% A1 = polyfit(x,T_,2);
% y=polyval(A1,x); 
% plot(x,y,'*',x,T_,'o'); 





% plot(T_);

% T_ = mean(T(:,[15 18 27 22 12 10 8 5 4 3]),2)';
% A2 = polyfit(x,T_,4);
% y=polyval(A2,x); 
% plot(T_);
% 
% T_ = mean(T(:,[25 24 23 14 11 9 7]),2)';
% A3 = polyfit(x,T_,4);
% y=polyval(A3,x); 
% plot(T_);
% 
% T_ = mean(T(:,[30 1 29 28 26 21 20 19 17 16 13]),2)';
% A4 = polyfit(x,T_,4);
% y=polyval(A4,x); 
% plot(T_);
% 
% T_ = mean(T(:,[2]),2)';
% A5 = polyfit(x,T_,4);
% y=polyval(A5,x); 

% % % A=polyfit(x,y,n);  %n是给定的多项式的次数，拟合出来的结果A是系数向量
% % % y1=polyval(A,x);  
% pos_I_ = [0.135 0.95-0.27 0.85 0.27]; 
% pos_II = [0.135 0.95-0.27*2 0.85 0.27]; 
% pos_III = [0.135 0.95-0.27*3 0.85 0.27]; 

%  pos_d1 = [0.135 0.95-0.27   0.85 0.27]; 
%  pos_d2 = [0.135 0.95-0.27*2 0.85 0.27]; 
%  pos_d3 = [0.135 0.95-0.27*3 0.85 0.27];
%  pos_d4 = [0.135 0.95-0.27*4 0.85 0.27];
%  pos_d5 = [0.135 0.95-0.27*4 0.85 0.27];
%  
%  axes_d1 = axes('Parent',hf,'Position',pos_d1); 
%  box on; 
%  plot(axes_d1,interval,gs_d1_freq,'LineWidth',4); 
%  ndvi_y_tick_num = 5*10^(-3) : 5*10^(-3) : 30*10^(-3); 
%  x_tick_num = 1991 : 2015; 
%  for i = 1 : length(x_tick_num); 
%  xLabel{i} = num2str(x_tick_num(i)); 
%  nullLabel{i} = ''; 
%  end  %%生成横坐标的字符串数组，nullLabel是用来将第一个和第二个坐标轴的横坐标设置为空。 
%  hf = figure('Color',[1,1,1],'Position',[300 50 600 800], 'PaperPositionMode','auto');
%  axes_ndvi = axes('Parent',hf,'Position',pos_ndvi); 
%  box on; 
%  plot(axes_ndvi,interval,gs_ndvi_freq,'LineWidth',4);
%  axes_d1 = axes('Parent',hf,'Position',pos_d1); 
%  box on; 
%  plot(axes_d1,interval,gs_d1_freq,'LineWidth',4); 
%  ndvi_y_tick_num = 5*10^(-3) : 5*10^(-3) : 30*10^(-3); 
%  x_tick_num = 1991 : 2015; 
%  for i = 1 : length(x_tick_num); 
%  xLabel{i} = num2str(x_tick_num(i)); 
%  nullLabel{i} = ''; 
%  end  %%生成横坐标的字符串数组，nullLabel是用来将第一个和第二个坐标轴的横坐标设置为空。 
%  hf = figure('Color',[1,1,1],'Position',[300 50 600 800], 'PaperPositionMode','auto');
%  axes_ndvi = axes('Parent',hf,'Position',pos_ndvi); 
%  box on; 
%  plot(axes_ndvi,interval,gs_ndvi_freq,'LineWidth',4);
 
 

