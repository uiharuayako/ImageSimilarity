function TMR=Tamura(image)
% 计算图像的Tamura特征
Fcrs=coarseness(image,5);%计算粗糙度
Fcon=contrastTMR(image);  %计算对比度
[Fdir,sita]=directionality(image);%计算方向度
[Flin,Flin8]=linelikeness(image,sita,4);%计算线性度
Freg=regularity(image,64);%计算规则度
Frgh=Fcrs+Fcon;%计算粗略度
TMR=[Fcrs,Fcon,Fdir,Flin8,Freg,Frgh];
end