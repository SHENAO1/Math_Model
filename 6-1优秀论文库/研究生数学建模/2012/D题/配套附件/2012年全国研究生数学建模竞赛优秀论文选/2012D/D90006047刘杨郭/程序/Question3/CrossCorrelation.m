function r = CrossCorrelation(I, gI, J, gJ)

k=0.5;

meangI = mean(mean(gI));
meangJ = mean(mean(gJ));
gI = gI - meangI;
gJ = gJ - meangJ;

meanI = mean(mean(I));
meanJ = mean(mean(J));

I = I - meanI;
J = J - meanJ;

r1 = sum(sum(I .* J)) / sqrt(sum(sum( I .* I)) * sum(sum( J .* J)));
r2  = sum(sum(gI .* gJ)) / sqrt(sum(sum( gI .* gI)) * sum(sum( gJ .* gJ)));

r = (1 - k) * r1 + k * r2;
