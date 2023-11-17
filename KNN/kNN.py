from numpy import*
import operator
def createDataSet():
    group=array([[1.0,1.1],[1.0,1.0],[0,0],[0,0.1]])
    labels=['A','A','B','B']
    return group,labels
def classify0(inx,dataSet,labels,k):
    dataSetSize= dataSet.shape[0]
    diffMat= tile(inx,(dataSetSize,1)) - dataSet
    sqDiffMat=diffMat**2
    sqDistances=sqDiffMat.sum(axis=1)
    distances=sqDistances**0.5
    sortedDistIndicies = distances.argsort()
    classCount={}
    for i in range(k):
        voteIlabel=labels[sortedDistIndicies[i]]
        classCount[voteIlabel] = classCount.get(voteIlabel,0) +1
    sortedClassCount = sorted(classCount.items(),key=operator.itemgetter(1),reverse=True)#注意，python3中已经没有 “iteritems” 这个属性了，现在属性是：“ items ”
    return sortedClassCount[0][0]