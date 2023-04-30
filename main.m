%=========================CART===========
clc
clear
close all
data_number_a=xlsread('or_data.xlsx','sheet1');
%data_number_a=xlsread('chaguan_anya.xlsx','插管');
[total_num,cd_num]=size(data_number_a);
X=data_number_a(:,1:cd_num-1);
Y=data_number_a(:,cd_num);
%rng(1);%可复现
indices = crossvalind('Kfold', total_num, 5);%用k折分类法将样本随机分为5部分
i=1; %四份用来训练，一份进行测试
test = (indices == i);
train = ~test;
X_train=X(train, :);
Y_train=Y(train, :);
X_test=X(test, :);
Y_test=Y(test, :);
%构建CART算法分类树
tree=fitctree(X_train,Y_train);
view(tree,'Mode','graph');%生成树图
rules_num=(tree.IsBranchNode==0);
rules_num=sum(rules_num);%求取规则数量
Cart_result=predict(tree,X_test);%使用测试样本进行验证
%Cart_result=cell2mat(Cart_result);
%Y_test=cell2mat(Y_test);
Cart_result1=(Cart_result==Y_test);
Cart_length=size(Cart_result1,1);%统计准确率
Cart_rate=(sum(Cart_result1))/Cart_length;
%==================混淆矩阵=================
expected=Y_test;
labels=Cart_result;
%=========分类==========
[m,~]=size(labels);
leibie=unique(expected);
k=size(leibie,1);%分类数

%==============计算混淆矩阵 ==================
for s=1:k
    TP(s)=0;
    FP(s)=0;
    FN(s)=0;
    for i=1:m
        if expected(i)==leibie(s)&&labels(i)==leibie(s)
            TP(s)=TP(s)+1;
        elseif expected(i)~=leibie(s)&&labels(i)==leibie(s)
            FP(s)=FP(s)+1;
        elseif expected(i)==leibie(s)&&labels(i)~=leibie(s)
            FN(s)=FN(s)+1;
        end
    end
    if TP(s)==0||FP(s)==0
        fscore(s)=0;
    else
        precision(s)=TP(s)/(TP(s)+FP(s));
        recall(s)=TP(s)/(TP(s)+FN(s));
        fscore(s)=2*precision(s)*recall(s)/(precision(s)+recall(s));
    end
end

er=1-mean(fscore);

disp(['规则数：' num2str(rules_num)]);
disp(['测试样本识别准确率：' num2str(Cart_rate)]);

