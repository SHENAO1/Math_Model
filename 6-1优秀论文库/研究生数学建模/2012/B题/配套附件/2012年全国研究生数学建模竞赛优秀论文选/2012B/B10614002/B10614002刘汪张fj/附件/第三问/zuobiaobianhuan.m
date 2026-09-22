function stot=zuobiaobianhuan(a,b) %坐标变换NEU系到笛卡尔坐标
stx=a(:,1);
sty=a(:,2);
stz=a(:,3);%卫星运行轨道坐标
stt=b(:,1);
sta=b(:,2);
stb=b(:,3);%卫星测量飞行器角度-观测坐标系
n=length(stt);
r1=(stx.*stx+sty.*sty+stz.*stz).^0.5;
r2=(stx.*stx+sty.*sty).^0.5;
stotx=stx./r1-sta.*sty./r2-stb.*stx.*stz./(r1.*r2);
stoty=sty./r1+sta.*stx./r2-stb.*sty.*stz./(r1.*r2);
stotz=stz./r1+stb.*(stx.*stx+sty.*sty)./(r1.*r2);
stot=zeros(n,4);
stot(:,1)=stt;stot(:,2)=stotx;stot(:,3)=stoty;stot(:,4)=stotz;
