%=========================KNN===========
clc
clear
close all
data_number_a=xlsread('or_data.xlsx','sheet1');
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
mdl = ClassificationKNN.fit(X_train,Y_train,'NumNeighbors',1);
predict_label   =   predict(mdl, X_test);
accuracy  =  length(find(predict_label == Y_test))/length(Y_test);

