paraz=[1500 500 8000 4000;1200 350 8000 4000;1300 500 8000 4000];
l=[300 200];
[xm1 fm1 xm2 fm2 phase]=linecon(paraz,l)
sumnew1=sum(fm1)
sumnew2=sum(fm2)