%==================元胞遗传算法筛选条件属性=============
clc
clear
close all
%=================决策矩阵====================
CD=xlsread('data.xlsx','sheet1');%读入数据
[~,cn]=size(CD);
C=CD(:,1:cn-1);
D=CD(:,cn);
%load data C D
[m,n]=size(C);
[p,q]=size(D);
%=================参数=============
cellnum=225;%元胞数目
spacelength=sqrt(cellnum);%元胞空间边长
pc=0.7;%交叉概率
pm=0.01;%变异概率
T=10;%迭代次数
%=================产生初始种群==========
for i=1:spacelength
    for j=1:spacelength
        for k=1:n
            cpopx(i,j,k)=randi([0 1],1,1);%产生初始群体
        end
    end
end
%=========遗传操作===============
for t=1:T
    for i=1:spacelength
        for j=1:spacelength
            if sum(cpopx(i,j,:))==0
                cpopy(i,j)=0;
            else
                for k=1:n
                    popxc(k)=cpopx(i,j,k);
                end
                cpopy(i,j)=relys(popxc,C,D);%计算依赖度
                %cpopy(i,j)=rely_g(popxc,C,D);%计算依赖度
            end
        end
    end
    meanfit(t)=mean(mean(cpopy(2:spacelength-1,2:spacelength-1)));%计算平均适应度（函数值）
    maxfit(t)=max(max(cpopy(:,:)));%计算最大适应度值
    min_cpopy=min(min(cpopy(:,:)));
    for i=1:spacelength
        for j=1:spacelength
           %适应度
            %fit(i,j)=cpopy(i,j)-min(min(cpopy(:,:)));
            fit(i,j)=cpopy(i,j)-min_cpopy;
        end
    end
    %===================选择、交叉==================
    fitstar=max(max(fit(:,:)));%全局最优
    [xnstar,ynstar]=find(fit==max(max(fit(:,:))));%全局最优的位置
    for i=2:spacelength-1
        for j=2:spacelength-1
            [xn,yn]=find(fit==max(max(fit(i-1:i+1,j-1:j+1))));%邻居中最优的
            for k=1:n
                if rand<=pc
                    cpopx(i,j,k)=cpopx(xn(1),yn(1),k);%交叉
                end
                if rand<=pm
                    cpopx(i,j,randi([1,n],1,1))=randi([0,1],1,1);%变异
                end
            end
        end
    end
    
end
figure;
plot(1:T,meanfit(1:T));
