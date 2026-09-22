clc;
close all;
clear all;

load n_axi.mat
addpath D:\2013 MATLAB\toolbox\m_map
addpath(genpath('D:\2013 MATLAB\toolbox\m_map'))

m_proj('stereographic','latitude',-90,'radius',60,'rotagnle',180);
m_coast('patch',[.7 .7 .7], 'edgecolor', 'none');
m_grid('xaxislocation','top');
% % m_elev('contour',[0:500:7000],'edgecolor','b');%µÈ¸ßÏß
% % m_line(100,-80,'marker','square','color','r');

%   m_line(n_axi(3,6),n_axi(2,6),'marker','.','markersize',19,'color','black');
% for n = [15 18 27 22 12 10 8 5 4 3 ];
%   m_line(n_axi(3,n),n_axi(2,n),'marker','o','markersize',5,'color','black');
% end
% for n = [25 24 23 14 11 9 7 ];
%   m_line(n_axi(3,n),n_axi(2,n),'marker','*','markersize',10,'color','black');
% end
% for n = [30 1 29 28 26 21 20 19 17 16 13];
%   m_line(n_axi(3,n),n_axi(2,n),'marker','+','markersize',10,'color','black');
% end
% 
%   m_line(n_axi(3,2),n_axi(2,2),'marker','x','markersize',10,'color','black');
for n = 1:30;
  m_line(n_axi(3,n),n_axi(2,n),'marker','.','markersize',15,'color','black');
end