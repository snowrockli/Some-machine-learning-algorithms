import xlrd
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.tree import plot_tree
book = pd.read_excel("D:\\Research work\\python\\Machine Learning\\RandomForest\\new_or_data_py.xlsx",sheet_name='Sheet3')#设置excel文件路径
nrows=book.shape[0]#数据的行数
ncols=book.shape[1]#数据的列数
datamatrix=book.values#转化为矩阵
x=datamatrix[:,0:ncols-1]#条件属性
y=datamatrix[:,ncols-1:ncols]#决策属性，标签
X_train,X_test,y_train,y_test = train_test_split(x,y,test_size=0.2,random_state=123)#划分训练集与测试集
model = DecisionTreeClassifier(max_depth=3,random_state=123)
model.fit(X_train,y_train)
y_pred=model.predict(X_test)
score=accuracy_score(y_pred,y_test)
print(score)
plt.figure(figsize=(6, 2), dpi=150)
plot_tree(model)
plt.show()