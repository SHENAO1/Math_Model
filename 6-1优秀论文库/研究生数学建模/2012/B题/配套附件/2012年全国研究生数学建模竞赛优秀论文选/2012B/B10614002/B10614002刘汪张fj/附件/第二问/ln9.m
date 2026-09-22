%求09号卫星观测00号飞行器的方向直线

st9t=st9ot(:,1);
st9otx=st9ot(:,2);
st9oty=st9ot(:,3);
st9otz=st9ot(:,4);%方向向量
st9x=mea09lc(:,1);
st9y=mea09lc(:,2);
st9z=mea09lc(:,3);
ln9a=st9oty./st9otx;
ln9c=st9otz./st9otx;
ln9b=st9y-ln9a.*st9x;
ln9d=st9z-ln9c.*st9x;
st9t=st9t';
ln9a=ln9a';
ln9b=ln9b';
ln9c=ln9c';
ln9d=ln9d';
n=length(st9x);
i=1:n;
yy=[st9t(i);ln9a(i);ln9b(i);ln9c(i);ln9d(i)];
fid=fopen('ln9.txt','w');
fprintf(fid,'%2.16f %7.16f %7.16f %7.16f %7.16f\n',yy);
fclose(fid);