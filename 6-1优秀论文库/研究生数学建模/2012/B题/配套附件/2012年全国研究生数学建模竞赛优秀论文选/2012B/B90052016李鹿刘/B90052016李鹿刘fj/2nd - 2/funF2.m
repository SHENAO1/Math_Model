function F=funF2(xcoff,ycoff,zcoff,t)
        F=[1 0 0 0 0 0 ;xcoff(1)+xcoff(2)*(t) -1 0 0 0 0; 0 0 1 0 0 0;0 0 ycoff(1)+ycoff(2)*(t) -1 0 0;0 0 0 0 1 0;0 0 0 0 zcoff(1)+zcoff(2)*(t) -1];
