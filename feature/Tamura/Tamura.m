function TMR=Tamura(image)
% ����ͼ���Tamura����
Fcrs=coarseness(image,5);%����ֲڶ�
Fcon=contrastTMR(image);  %����Աȶ�
[Fdir,sita]=directionality(image);%���㷽���
[Flin,Flin8]=linelikeness(image,sita,4);%�������Զ�
Freg=regularity(image,64);%��������
Frgh=Fcrs+Fcon;%������Զ�
TMR=[Fcrs,Fcon,Fdir,Flin8,Freg,Frgh];
end