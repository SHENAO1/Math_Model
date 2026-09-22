cla reset;
load topo;
[x y z] = sphere;
x=6400000*x;y=6400000*y;z=6400000*z;
s = surface(x,y,z,'facecolor','texturemap','cdata',topo);

