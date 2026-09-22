function ln=qiuln(a,b) %a转化后的方向向量，b卫星运行轨道坐标%求方向导数对应的线性方程
stt=a(:,1);
stotx=a(:,2);
stoty=a(:,3);
stotz=a(:,4);%方向向量
stx=b(:,1);
sty=b(:,2);
stz=b(:,3);%卫星运行轨道坐标
lna=stoty./stotx;
lnc=stotz./stotx;
lnb=sty-lna.*stx;
lnd=stz-lnc.*stx;
n=length(stx);
ln=zeros(n,5);
ln(:,1)=stt;ln(:,2)=lna;ln(:,3)=lnb;ln(:,4)=lnc;ln(:,5)=lnd;