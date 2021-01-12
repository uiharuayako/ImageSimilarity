function corr_cal_para2()
% CORR_CAL_PARA2 ���м���2�����ڼ���н����Ҿ���
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat_2=zeros(numImg,numImg,8);
% �ƣ�һά�Ǵ���ͼ�񣬶�ά�Ǳ���ͼ���飬��ά��ʹ������ֵ
warning off;
for i=1:numImg
    for j=1:numImg
        %�н�����
        corr_mat_2(i,j,1)=pdist2(feat.Hists{i}',feat.Hists{j}','cosine');
        corr_mat_2(i,j,2)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'cosine');
        corr_mat_2(i,j,3)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'cosine');
        corr_mat_2(i,j,4)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'cosine');
        corr_mat_2(i,j,5)=pdist2(feat.GGs{i},feat.GGs{j},'cosine');
        corr_mat_2(i,j,6)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','cosine');
        corr_mat_2(i,j,7)=pdist2(feat.LBPs{i},feat.LBPs{j},'cosine');
        corr_mat_2(i,j,8)=pdist2(feat.TMRs{i},feat.TMRs{j},'cosine');
    end
    disp("��"+num2str(i)+"�������");
end
%�������Ӳ��
save('corr2.mat','corr_mat_2','-v7.3');
end

