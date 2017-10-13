function [dist,mypath,dists,paths]=myfloyd(a,sb,db)
% 输入：
% a--邻接矩阵；元素a(i.j)--顶点i到j之间的直达距离，可以是有向的
% sb--起点的标号
% db--终点的标号

% 输出：
% dist--最短路的距离
% mypath--最短路的路径

n=size(a,1);paths=zeros(n);
for k=1:n
    for i=1:n
        for j=1:n
            if a(i,j)>a(i,k)+a(k,j)
                a(i,j)=a(i,k)+a(k,j);
                paths(i,j)=k;
            end
        end
    end
end
dists = a;
dist=a(sb,db);
parent=paths(sb,:); %从起点sb到终点db的最短路上各顶点的前驱顶点
parent(parent==0)=sb; %path中的分量为0，表示该顶点的前驱是起点
mypath=db;t=db;
while t~=sb
    p=parent(t);mypath=[p mypath];
    t=p;
end