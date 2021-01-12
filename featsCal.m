function featsCal()
%FEATSCAL ����ͼ�����ƶȲ�����
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat=zeros(numImg,numImg,8,3);
% �ƣ�һά�Ǵ���ͼ�񣬶�ά�Ǳ���ͼ���飬��ά��ʹ������ֵ����ά�Ǽ������ķ�ʽ
corr_sum_nor=zeros(numImg,numImg);
warning off;
for i=1:numImg
    for j=1:numImg
        %ŷʽ����
        corr_mat(i,j,1,1)=pdist2(feat.Hists{i}',feat.Hists{j}','euclidean');
        corr_mat(i,j,2,1)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'euclidean');
        corr_mat(i,j,3,1)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'euclidean');
        corr_mat(i,j,4,1)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'euclidean');
        corr_mat(i,j,5,1)=pdist2(feat.GGs{i},feat.GGs{j},'euclidean');
        corr_mat(i,j,6,1)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','euclidean');
        corr_mat(i,j,7,1)=pdist2(feat.LBPs{i},feat.LBPs{j},'euclidean');
        corr_mat(i,j,8,1)=pdist2(feat.TMRs{i},feat.TMRs{j},'euclidean');
        %�н�����
        corr_mat(i,j,1,2)=pdist2(feat.Hists{i}',feat.Hists{j}','cosine');
        corr_mat(i,j,2,2)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'cosine');
        corr_mat(i,j,3,2)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'cosine');
        corr_mat(i,j,4,2)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'cosine');
        corr_mat(i,j,5,2)=pdist2(feat.GGs{i},feat.GGs{j},'cosine');
        corr_mat(i,j,6,2)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','cosine');
        corr_mat(i,j,7,2)=pdist2(feat.LBPs{i},feat.LBPs{j},'cosine');
        corr_mat(i,j,8,2)=pdist2(feat.TMRs{i},feat.TMRs{j},'cosine');
        %���ϵ�����޷�����laws��������
        corr_mat(i,j,1,3)=1-abs(corr(feat.Hists{i},feat.Hists{j}));
        corr_mat(i,j,2,3)=1-abs(corr(feat.GLCMfs{i}',feat.GLCMfs{j}'));
        corr_mat(i,j,3,3)=1-abs(corr(feat.GLCMs{i}',feat.GLCMs{j}'));
        corr_mat(i,j,4,3)=1-abs(corr(feat.GLDSs{i}',feat.GLDSs{j}'));
        corr_mat(i,j,5,3)=1-abs(corr(feat.GGs{i}',feat.GGs{j}'));
        corr_mat(i,j,6,3)=corr_mat(i,j,6,2);
        corr_mat(i,j,7,3)=1-abs(corr(feat.LBPs{i}',feat.LBPs{j}'));
        corr_mat(i,j,8,3)=1-abs(corr(feat.TMRs{i}',feat.TMRs{j}'));
    end
    disp("��"+num2str(i)+"�������");
end
%ʹ�üн����ҽ��ж�������ͬ���㣬Ϊ�˱�֤����������Ȩ�ػ������ȣ�ʹ�þ�����������ֵ����
for methods=1:8
    tmpSeqM=corr_mat(:,:,methods,2);
    norM=tmpSeqM/max(tmpSeqM(:));% ����ȫ���Ȼ�����normalize�����ĺ������ƻ��������Ϣ
    corr_sum_nor=corr_sum_nor+norM;
end
%�������Ӳ��
save('corr.mat','corr_mat','corr_sum_nor', '-v7.3');
end