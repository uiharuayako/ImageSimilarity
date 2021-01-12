function featsCal()
%FEATSCAL 计算图像相似度并保存
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat=zeros(numImg,numImg,8,3);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值，四维是计算距离的方式
corr_sum_nor=zeros(numImg,numImg);
warning off;
for i=1:numImg
    for j=1:numImg
        %欧式距离
        corr_mat(i,j,1,1)=pdist2(feat.Hists{i}',feat.Hists{j}','euclidean');
        corr_mat(i,j,2,1)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'euclidean');
        corr_mat(i,j,3,1)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'euclidean');
        corr_mat(i,j,4,1)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'euclidean');
        corr_mat(i,j,5,1)=pdist2(feat.GGs{i},feat.GGs{j},'euclidean');
        corr_mat(i,j,6,1)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','euclidean');
        corr_mat(i,j,7,1)=pdist2(feat.LBPs{i},feat.LBPs{j},'euclidean');
        corr_mat(i,j,8,1)=pdist2(feat.TMRs{i},feat.TMRs{j},'euclidean');
        %夹角余弦
        corr_mat(i,j,1,2)=pdist2(feat.Hists{i}',feat.Hists{j}','cosine');
        corr_mat(i,j,2,2)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'cosine');
        corr_mat(i,j,3,2)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'cosine');
        corr_mat(i,j,4,2)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'cosine');
        corr_mat(i,j,5,2)=pdist2(feat.GGs{i},feat.GGs{j},'cosine');
        corr_mat(i,j,6,2)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','cosine');
        corr_mat(i,j,7,2)=pdist2(feat.LBPs{i},feat.LBPs{j},'cosine');
        corr_mat(i,j,8,2)=pdist2(feat.TMRs{i},feat.TMRs{j},'cosine');
        %相关系数，无法计算laws纹理特征
        corr_mat(i,j,1,3)=1-abs(corr(feat.Hists{i},feat.Hists{j}));
        corr_mat(i,j,2,3)=1-abs(corr(feat.GLCMfs{i}',feat.GLCMfs{j}'));
        corr_mat(i,j,3,3)=1-abs(corr(feat.GLCMs{i}',feat.GLCMs{j}'));
        corr_mat(i,j,4,3)=1-abs(corr(feat.GLDSs{i}',feat.GLDSs{j}'));
        corr_mat(i,j,5,3)=1-abs(corr(feat.GGs{i}',feat.GGs{j}'));
        corr_mat(i,j,6,3)=corr_mat(i,j,6,2);
        corr_mat(i,j,7,3)=1-abs(corr(feat.LBPs{i}',feat.LBPs{j}'));
        corr_mat(i,j,8,3)=1-abs(corr(feat.TMRs{i}',feat.TMRs{j}'));
    end
    disp("第"+num2str(i)+"处理完毕");
end
%使用夹角余弦进行多特征共同计算，为了保证各个特征的权重基本均等，使用矩阵除以其最大值处理
for methods=1:8
    tmpSeqM=corr_mat(:,:,methods,2);
    norM=tmpSeqM/max(tmpSeqM(:));% 不完全均等化，用normalize这样的函数会破坏本身的信息
    corr_sum_nor=corr_sum_nor+norM;
end
%保存矩阵到硬盘
save('corr.mat','corr_mat','corr_sum_nor', '-v7.3');
end