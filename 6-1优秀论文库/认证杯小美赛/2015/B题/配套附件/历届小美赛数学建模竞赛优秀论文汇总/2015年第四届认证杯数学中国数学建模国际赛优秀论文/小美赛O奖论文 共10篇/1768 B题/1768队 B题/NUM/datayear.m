clear;
load exm1.mat
data_year = [];
for n = 1:size(amundsenscottS2,1);
    temp = amundsenscottS2(n,2:13);
    temp(temp==90) = mean(temp(temp~=90));
    data_year = [ data_year,temp ];
end
