function F=funF4(xcoff,ycoff,zcoff,t)
        F=[1 0 0 0 0 0 ;xcoff(1)+xcoff(2)*(t)+xcoff(3)*(t)^2+xcoff(4)*t^3 -1 0 0 0 0; 0 0 1 0 0 0;0 0 ycoff(1)+ycoff(2)*(t)+ycoff(3)*(t)^2+ycoff(4)*t^3 -1 0 0;0 0 0 0 1 0;0 0 0 0 zcoff(1)+zcoff(2)*(t)+zcoff(3)*(t)^2+zcoff(4)*t^3 -1];
