%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%初始化
m_NameCell={'';'';};
m_NameChar=m_NameCell';
m_NameCell=char(m_NameChar);
m_NameNum=length(m_NameCell);
%%保存变量为txt
save('GenerateSolution.txt','Solution','-ascii');%变量名要为字符串

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%粗线
plot(x,y,'linewidth',6);
%%误差图
stem(index,100*delta(:,4),'filled','linewidth',4);
%三维拟合
[X,Y,Z] = griddata(x,y,z,linspace(min(x),max(x),100)',linspace(min(y),max(y),100),'v4');
%%三维图
surf(X,Y,Z);
%%等高图
[c,h]= contourf(X,Y,Z);
colorbar;
clabel(c,h);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%标注
p1=plot(x,y,'b*');
p2=plot(x,y,'m*');
p3=plot(x,y,'r*');
p4=plot(x,y,'k*');
p5=plot(x,y,'g*');
legend([p1,p2,p3,p4,p5],'1','2','3','4','5');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%矩阵技巧
%any all
a(any(a==1,2),:)=[];%按行删除存在1的行
any(A,1)%列向判断是否全零
any(A,2)%行向判断是否全零
B = all(A(:) < 3)%检查它的任何元素是否小于3
B = any(A(:) < 3)%检查它是否含有元素小于3
array(and(array>1,array<3))=0;%把大于1小于3的变成0。
%find
find(a(:,2)==0)%查找第二列含零行的位置
a(find(a(:,2)==0),:)=[]%删除第二列含零的行
a(a(:,2)==0,:)=[]%删除第二列含零的行

%accumarray 使用累加构造数组@@@@@@@@@@@@@@
A = accumarray(subs,1)%可计算 subs 中相同下标的数目。%subs是下标 val是待求数组 %val按照sub分配的下标归类求和

cumsum();%累加和
unique(A);%删除重复元素并排序
unique(A(j,:),'stable') %'stable'保持元素位置不变，j是行
%删除重复元素所在行
A = [1 3; 1 4; 2 10; 2 9; 3 1];
[a,b]=unique(A(:,1),'first');
A(b,:)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%三角转换
%sin2cos
f_sin2cos=@(sinx)(cos(asin(sinx)));
%cos2sin
f_cos2sin=@(cosx)(sin(acos(cosx)));
%sin2tan
f_sin2tan=@(sinx)(tan(asin(sinx)));
%tan2sin
f_tan2sin=@(tanx)(sin(atan(tanx)));
%cos2tan
f_cos2tan=@(cosx)(tan(acos(cosx)));
%tan2cos
f_tan2cos=@(tanx)(cos(atan(tanx)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%求极值坐标
peakpoint_arr=imregionalmax(z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%命令技巧
dbstop if error%如果运行出现错误，matlab会自动停在出错的那行，并且保存所有相关变量。
global%可以将变量变为全局变量，在各函数之间共享。不过这不太好用，尽量慎用吧。
surf、mesh都很漂亮，不过surf之后记得用shading interp，看起来更漂亮。
FileFullName{i}%{}括号可以选取整个元胞数组

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%数据处理
%极差归一化
[R,xmin,xrange] = rscore(x)
%极大值极小值
IndMin=find(diff(sign(diff(data)))>0)+1
IndMax=find(diff(sign(diff(data)))<0)+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%多元线性回归&残差
x=[143 145 146 147 149 150 153 154 155 156 157 158 159 160 162 164]';
X=[ones(16,1) x];
Y=[88 85 88 91 92 93 93 95 96 98 97 96 98 99 100 102]';
[b,bint,r,rint,stats]=regress(Y,X)
rcoplot(r,rint)