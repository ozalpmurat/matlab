% Uğur'un verdiği kodlar. Gayet sade ve anlaşılır olmuş. Teşekkürler.

clc
clear  all
load fisheriris
tree = fitctree(meas,species);

view(tree,'mode','graph')

tahmin1= predict(tree,meas(1,:))


TestVeri=[2.3 1.9 4.5 2];
tahmin2= predict(tree,TestVeri)
