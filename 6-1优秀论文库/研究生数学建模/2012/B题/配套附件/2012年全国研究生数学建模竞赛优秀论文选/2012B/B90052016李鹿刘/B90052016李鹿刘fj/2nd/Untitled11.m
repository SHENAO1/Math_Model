%%%%%求解级数方程
xigma0=0;
xigma1=0;
xigma2=0;

xigma0k1=0;
xigma1k1=0;
xigma2k1=0;

xigma3=0;
xigma4=0
for t=50:170
    xigma0=xigma0+1;
    xigma1=xigma1+t;
    xigma2=xigma2+t^2;
    xigma3=xigma3+t^3;
    xigma4=xigma4+t^4;
    tempk=kxyz(1);
    xigma0k1=xigma0k1+k1;
    xigma1k1=xigma0k1+k1*t;
    xigma2k1=xigma0k1+k1*t^2;
end