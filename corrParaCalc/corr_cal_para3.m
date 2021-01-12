function corr_cal_para3()
% CORR_CAL_PARA2 ���м���2�����ڼ���н����Ҿ���
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat_3=zeros(numImg,numImg,8);
% �ƣ�һά�Ǵ���ͼ�񣬶�ά�Ǳ���ͼ���飬��ά��ʹ������ֵ
warning off;
for i=1:numImg
    for j=1:numImg
        %�н�����
        corr_mat_3(i,j,1)=1-abs(corr(feat.Hists{i},feat.Hists{j}));
        corr_mat_3(i,j,2)=1-abs(corr(feat.GLCMfs{i}',feat.GLCMfs{j}'));
        corr_mat_3(i,j,3)=1-abs(corr(feat.GLCMs{i}',feat.GLCMs{j}'));
        corr_mat_3(i,j,4)=1-abs(corr(feat.GLDSs{i}',feat.GLDSs{j}'));
        corr_mat_3(i,j,5)=1-abs(corr(feat.GGs{i}',feat.GGs{j}'));
        corr_mat_3(i,j,6)=corr_mat_3(i,j,5);
        corr_mat_3(i,j,7)=1-abs(corr(feat.LBPs{i}',feat.LBPs{j}'));
        corr_mat_3(i,j,8)=1-abs(corr(feat.TMRs{i}',feat.TMRs{j}'));
    end
    disp("��"+num2str(i)+"�������");
end
%�������Ӳ��
save('corr3.mat','corr_mat_3','-v7.3');
end