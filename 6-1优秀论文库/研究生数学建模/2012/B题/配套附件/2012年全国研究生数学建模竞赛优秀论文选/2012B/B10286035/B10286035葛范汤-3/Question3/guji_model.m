load('target_step1')

GM=3.986005e14;
NUM = 600;
mod_target_step1 = 0;
for i=1:NUM
    mod_target_step1(i) = sqrt(sum(target_step1(i,1:3).^2));
end
mod_target_step1 = mod_target_step1';

temp = GM./(mod_target_step1.^3);
first_term = 0;
for i=1:NUM
    first_term(i,1:3) = -temp(i)*target_step1(i,1:3);
end

guji = dd_target_step1 - first_term;

guji_modl = 0;
for i = 3:NUM
    guji_modl(i,1:3) = guji(i,1:3)./d_target_step1(i,1:3);
end