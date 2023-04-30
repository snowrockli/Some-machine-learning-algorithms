%=========================CART===========
clc
clear
close all
data_number_a=xlsread('or_data.xlsx','sheet1');
%data_number_a=xlsread('chaguan_anya.xlsx','���');
[total_num,cd_num]=size(data_number_a);
X=data_number_a(:,1:cd_num-1);
Y=data_number_a(:,cd_num);
%rng(1);%�ɸ���
indices = crossvalind('Kfold', total_num, 5);%��k�۷��෨�����������Ϊ5����
i=1; %�ķ�����ѵ����һ�ݽ��в���
test = (indices == i);
train = ~test;
X_train=X(train, :);
Y_train=Y(train, :);
X_test=X(test, :);
Y_test=Y(test, :);
%����CART�㷨������
tree=fitctree(X_train,Y_train);
view(tree,'Mode','graph');%������ͼ
rules_num=(tree.IsBranchNode==0);
rules_num=sum(rules_num);%��ȡ��������
Cart_result=predict(tree,X_test);%ʹ�ò�������������֤
%Cart_result=cell2mat(Cart_result);
%Y_test=cell2mat(Y_test);
Cart_result1=(Cart_result==Y_test);
Cart_length=size(Cart_result1,1);%ͳ��׼ȷ��
Cart_rate=(sum(Cart_result1))/Cart_length;
%==================��������=================
expected=Y_test;
labels=Cart_result;
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
    if TP(s)==0||FP(s)==0
        fscore(s)=0;
    else
        precision(s)=TP(s)/(TP(s)+FP(s));
        recall(s)=TP(s)/(TP(s)+FN(s));
        fscore(s)=2*precision(s)*recall(s)/(precision(s)+recall(s));
    end
end

er=1-mean(fscore);

disp(['��������' num2str(rules_num)]);
disp(['��������ʶ��׼ȷ�ʣ�' num2str(Cart_rate)]);

