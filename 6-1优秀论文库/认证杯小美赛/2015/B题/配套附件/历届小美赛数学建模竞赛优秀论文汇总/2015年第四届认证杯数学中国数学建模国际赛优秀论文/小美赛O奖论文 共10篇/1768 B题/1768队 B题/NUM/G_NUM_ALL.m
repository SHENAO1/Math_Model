clear;
clc;
for n = 1:30;
 eval(['load NUM',num2str(n),'.mat;']);
 for i = 1:12
 eval(['NUM_',num2str(n),'(:,i) = mean(NUM',num2str(n),'(:,(1+(i-1)*4):(i*4) ),2 );']);
 end;
 eval(['save NUM_',num2str(n),'.mat']);
 eval(['NUM_ALL(:,:,',num2str(n),') = NUM_',num2str(n),';']);
end;
save NUM_ALL.mat
% load n_axi.mat
% x = -(90+n_axi(2,:)).*cos( n_axi(3,:)*pi/180 )*10.5+338;
% y = (90+n_axi(2,:)).*sin( n_axi(3,:)*pi/180 )*10.5+337;

% 
% for i = 1:25;
%     for j = 1:12;
%        t(1,:) =  NUM_ALL(i,j,:);
%        [X,Y,T] = griddata(x,y,t,linspace(min(x),max(x)),linspace(min(y),max(y))','nearest');
%        maen_month_year(i,j) = mean(mean(T));
%     end;
% end;




