# -*- coding: utf-8 -*-
"""
Created on Sat Aug 14 22:14:14 2021

@author: 淞
"""
import xlrd
import numpy as np
from sklearn.cluster import k_means
from sklearn.decomposition import SparsePCA
import matplotlib.pyplot as plt
from scipy import io

data = io.loadmat('reduction.mat')
feature = data['reduction']
    
Feature = np.array(feature)

clf = k_means(Feature,2)
from sklearn.decomposition import SparsePCA
transformer = SparsePCA(n_components=2, random_state=0)
transformer.fit(Feature)
X_transformed = transformer.transform(Feature)

np.mean(transformer.components_ == 0)
predict = clf[1]

for i in range(402):
     plt.scatter(X_transformed[i][0],X_transformed[i][1],color='orange')
plt.show() 
j = 0
for i in range(402):
    if predict[i] == 0:
       j = j+1
       plt.scatter(X_transformed[i][0],X_transformed[i][1],color='firebrick',marker = '2')
    elif predict[i] == 1:
       plt.scatter(X_transformed[i][0],X_transformed[i][1],color='forestgreen',marker = '*')

print(j)
io.savemat("./predict.mat", {'predict':predict})
    
    
    
    
