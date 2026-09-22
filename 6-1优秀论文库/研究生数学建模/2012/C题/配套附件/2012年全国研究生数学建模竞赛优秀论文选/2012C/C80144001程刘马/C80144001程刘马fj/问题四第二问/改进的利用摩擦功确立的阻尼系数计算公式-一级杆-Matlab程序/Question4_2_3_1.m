clc;
clear;
format long;
result(1)=0;
for i=1:10
result(i+1)=C_func(result(i));
result(i);
end
result'
result(1)=1;
for i=1:10
result(i+1)=C_func(result(i));
result(i);
end
result'