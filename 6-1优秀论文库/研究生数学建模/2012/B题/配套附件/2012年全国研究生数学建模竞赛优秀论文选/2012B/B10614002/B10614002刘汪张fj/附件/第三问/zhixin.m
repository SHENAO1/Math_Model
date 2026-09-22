%求第二问与第三问的优化模型位移置信区间
load cuixianduan.txt
zhixin2_x=0.5*(cuixianduan(1,[1:50:600,600])-cuixianduan(4,[1:50:600,600]));
zhixin2_y=0.5*(cuixianduan(2,[1:50:600,600])-cuixianduan(5,[1:50:600,600]));
zhixin2_z=0.5*(cuixianduan(3,[1:50:600,600])-cuixianduan(6,[1:50:600,600]));

load cuixianduan3.txt

zhixin3_x=0.5*(cuixianduan3(1,[1:50:600,600])-cuixianduan3(4,[1:50:600,600]));
zhixin3_y=0.5*(cuixianduan3(2,[1:50:600,600])-cuixianduan3(5,[1:50:600,600]));
zhixin3_z=0.5*(cuixianduan3(3,[1:50:600,600])-cuixianduan3(6,[1:50:600,600]));