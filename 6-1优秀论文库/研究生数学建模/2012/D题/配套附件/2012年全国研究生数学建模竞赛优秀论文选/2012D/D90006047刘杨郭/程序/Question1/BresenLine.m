
function [P,Num]=BresenLine(sP,eP)

Num=0;
P=[];
Num=Num+1;
P(Num,:)=[sP.x sP.y];

if sP.x==eP.x && sP.y==eP.y
    return
end;

iTag=0;
dx=abs(eP.x-sP.x);
dy=abs(eP.y-sP.y);

if(dx<dy)
    iTag=1;
    [sP.x,sP.y]=iSwap(sP.x,sP.y);
    [eP.x,eP.y]=iSwap(eP.x,eP.y);
    [dx,dy]=iSwap(dx,dy);
end;

if eP.x-sP.x > 0
    tx=1;
else
    tx=-1;
end;

if eP.y-sP.y > 0
    ty=1;
else
    ty=-1;
end;

curx=sP.x;cury=sP.y;
inc1=2*dy;inc2=2*(dy-dx);
d=inc1-dx;

while(curx ~= eP.x)
    curx=curx+tx;
    if d<0
        d=d+inc1;
    else
        cury=cury+ty;
        d=d+inc2;
    end;
    if(iTag==1)
        Num=Num+1;
        P(Num,:)=[cury curx];
    else
        Num=Num+1;
        P(Num,:)=[curx cury];
    end;
end;

return

function [a,b]=iSwap(a,b)
    c=a;a=b;b=c;
return