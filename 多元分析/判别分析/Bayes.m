%% Bayes: 贝叶斯判别

% input
% meas : 训练样本   (m * n) m 个对象，每行代表一个对象，每列代表一个指标
% species : 训练样本对应类别    (m * 1) 每行代表一个类别
% x : 预测样本

% output
% pre1 : 预测结果
% err_percent : 错误率
% err_id : 错误序号
% err_condition : 错误情况
% CLMat : 混淆矩阵

function [pre1,err_percent,err_id,err_condition,CLMat] = Bayes( meas,species,x )



%*********************************贝叶斯判别********************************
% 用meas和species作为训练样本，创建一个朴素贝叶斯分类器对象ObjBayes
ObjBayes = NaiveBayes.fit(meas, species);
% 利用所创建的朴素贝叶斯分类器对象对训练样本进行判别，返回判别结果pre0，pre0也是字符串元胞向量
pre0 = ObjBayes.predict(meas);
% 利用confusionmat函数，并根据species和pre0创建混淆矩阵（包含总的分类信息的矩阵）
[CLMat, order] = confusionmat(species, pre0);
display('混淆矩阵')
% 以元胞数组形式查看混淆矩阵
CLMat = [[{'From/To'},order'];order, num2cell(CLMat)]


% 查看误判样品编号
gindex1 = grp2idx(pre0);  % 根据分组变量pre0生成一个索引向量gindex1
gindex2 = grp2idx(species);  % 根据分组变量species生成一个索引向量gindex2
display('误判样品序号')
err_id = find(gindex1 ~= gindex2)  % 通过对比两个索引向量，返回误判样品的观测序号向量
err_percent = length(err_id) ./ length(species);

% 查看误判样品的误判情况
head1 = {'Obj', 'From', 'To'};  % 设置表头
display('误判情况')
% 用num2cell函数将误判样品的观测序号向量err_id转为元胞向量，然后以元胞数组形式查看误判结果
err_condition = [head1; num2cell(err_id), species(err_id), pre0(err_id)]


display('预测结果')
% 利用所创建的朴素贝叶斯分类器对象对未判样品进行判别，返回判别结果pre1，pre1也是字符串元胞向量
pre1 = ObjBayes.predict(x)

