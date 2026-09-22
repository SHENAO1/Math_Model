function Equ = Trans( Pin,x )%5*1æÿ’Û
ptemp=Pin;
Equ=0;
[m n]=size(ptemp);
for i=1:n;
    Equ=Equ+Pin(n-i+1)*x^(i-1);
end
    



