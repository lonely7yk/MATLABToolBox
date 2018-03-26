%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%淇濆瓨鍥剧墖
function m_savePicture(titleName,xlabelName,ylabelName,path)
set(gcf,'position',[0,0,1920,1080]);
set(gca,'FontSize',20);%先修改所有字体大小，包括刻度字体
title(titleName,'fontsize',36,'fontname','Microsoft YaHei UI');
xlabel(xlabelName,'fontsize',36,'fontname','Microsoft YaHei UI');
ylabel(ylabelName,'fontsize',36,'fontname','Microsoft YaHei UI');
%set(pic,'linewidth',3.5);修改线条粗细
%set(gca,'xtick',1:21);
%变成百分制
%set(gca,'yticklabel',labels_modif);
%去除白边
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
%保存
path=[BackPath(3),'\02数据\matlab输出\',path];
saveas(gcf,strcat(path,'\',titleName,'.png'));
saveas(gcf,strcat(path,'\',titleName,'.fig'));
close all

%路径回退
function [str_temp]=BackPath(BackNum)
BackNum=BackNum+1;
str_temp = mfilename('fullpath');
for i=1:BackNum
    index_dir=findstr(str_temp,'\');
    str_temp=str_temp(1:index_dir(end)-1);
end
