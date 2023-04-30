%=========================RF===========
clc
clear
close all
data_number_a=xlsread('new_or_data.xlsx','FB�ؼ�ָ��');
%data_number_a=xlsread('chaguan_anya.xlsx','���');
[total_num,cd_num]=size(data_number_a);
X=data_number_a(:,31:65);
%X=data_number_a(:,1:cd_num-1);
Y=data_number_a(:,66);
%rng(1);%�ɸ���
for tt=1:1000
    indices = crossvalind('Kfold', total_num, 5);%��k�۷��෨�����������Ϊ5����
    
    i=1; %�ķ�����ѵ����һ�ݽ��в���
    test = (indices == i);
    train = ~test;
    X_train=X(train, :);
    Y_train=Y(train, :);
    X_test=X(test, :);
    Y_test=Y(test, :);
    nTree = 200;
    
    Factor = TreeBagger(nTree, X_train, Y_train);
    [predict_label,Scores] = predict(Factor, X_test);
    predict_label=str2num(cell2mat(predict_label));
    accuracy(tt)  =  length(find(predict_label == Y_test))/length(Y_test);
    
    %==================��������=================
    expected=Y_test;
    labels=predict_label;
    %=========����==========
    [m,~]=size(labels);
    leibie=unique(expected);
    k=size(leibie,1);%������
    
    %==============����������� ==================
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
        %     if TP(s)==0||FP(s)==0
        %         fscore(s)=0;
        %     else
        precision(s)=TP(s)/(TP(s)+FP(s));
        recall(s)=TP(s)/(TP(s)+FN(s));
        fscore(s)=2*precision(s)*recall(s)/(precision(s)+recall(s));
        %     end
    end
    F(tt)=mean(fscore);
end
