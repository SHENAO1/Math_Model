clear;    %а╫уе╪╬╫зм╪
load NUM_ALL.mat
key(25,:,:) = 2*ones(12,30);
NU = NUM_ALL+key;

% key_ = 13/28;  %
% NU(:,:,30) = NU(:,:,30)*key_;
% NU(:,:,1:29) = NU(:,:,1:29)*((1-key_)/29);

T(:,:) =mean(NU,2);
x = 1991:2015;

% figure('position',[100 0 600 400]);
% % subplot('position',[0.1 0.1 0.4 0.25]);
% % subplot('position',[0.1 0.6 0.4 0.25]);
% % subplot('position',[0.55 0.1 0.4 0.25]);
% % subplot('position',[0.55 0.6 0.4 0.25]);


T_ = mean(T(:,[6]),2)'-10;
A1 = polyfit(x,T_,1);
y=polyval(A1,x); 
subplot(5,1,1);
axis([-16,-10,1991,2015])
plot(x,T_,'*-.'); 
hold on;
plot(x,y,'LineWidth',2); 
A1 = polyfit(x,T_,5);
y=polyval(A1,x);
plot(x,y,'LineWidth',1); 

T_ = mean(T(:,[15 18 27 22 12 10 8 5 4 3]),2)'-10;
A2 = polyfit(x,T_,1);
y=polyval(A2,x); 
subplot(5,1,2);
plot(x,T_,'*-.'); 
hold on;
plot(x,y,'LineWidth',2); 
A2 = polyfit(x,T_,5);
y=polyval(A2,x);
plot(x,y,'LineWidth',1); 


T_ = mean(T(:,[25 24 23 14 11 9 7]),2)'-10;
A3 = polyfit(x,T_,1);
y=polyval(A3,x); 
subplot(5,1,3);
plot(x,T_,'*-.'); 
hold on;
plot(x,y,'LineWidth',2); 
A3 = polyfit(x,T_,5);
y=polyval(A3,x);
plot(x,y,'LineWidth',1); 

T_ = mean(T(:,[30 1 29 28 26 21 20 19 17 16 13]),2)'-10;
A4 = polyfit(x,T_,1);
y=polyval(A4,x); 
subplot(5,1,4);
plot(x,T_,'*-.'); 
hold on;
plot(x,y,'LineWidth',2); 
A4 = polyfit(x,T_,5);
y=polyval(A4,x);
plot(x,y,'LineWidth',1); 

T_ = mean(T(:,[2]),2)'-20;
A5 = polyfit(x,T_,1);
y=polyval(A5,x); 
subplot(5,1,5);
plot(x,T_,'*-.'); 
hold on;
plot(x,y,'LineWidth',2); 
A5 = polyfit(x,T_,5);
y=polyval(A5,x);
plot(x,y,'LineWidth',1); 




