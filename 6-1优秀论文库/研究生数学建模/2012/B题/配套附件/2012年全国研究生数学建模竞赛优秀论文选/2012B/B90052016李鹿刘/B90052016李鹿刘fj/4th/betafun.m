function  tempbeta=betafun(t,dbeta)
tempbeta=t;
for i=1:length(t)
tempbeta(i)=-0.000000000005334*t(i)^4+0.000000001680819*t(i)^3-0.000001272374580*t(i)^2+0.000763425262121*t(i)+0.233667941454019-dbeta;
end