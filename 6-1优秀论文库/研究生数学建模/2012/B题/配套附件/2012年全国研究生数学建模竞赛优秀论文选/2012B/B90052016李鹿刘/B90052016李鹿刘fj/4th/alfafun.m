function tempalfa=alfafun(t,dalfa)
tempalfa=t;
for i=1:length(t)
tempalfa(i)=0.000000000083256*t(i)^4-0.000000027930421*t(i)^3+0.000007591945569*t(i)^2+0.000649294482927*t(i)+0.211489163773973-dalfa;
end