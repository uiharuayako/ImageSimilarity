function corr_cal_para1()
% 计算图像相似度，用于多个电脑并行运算，对于单用户并不需要使用这个函数。
feat=load('features.mat');% 加载特征文件
numImg=length(feat.Hists);
corr_mat_1=zeros(numImg,numImg,8);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值
warning off;
for i=1:numImg
    for j=1:numImg
        %欧式距离
        corr_mat_1(i,j,1)=pdist2(feat.Hists{i}',feat.Hists{j}','euclidean');
        corr_mat_1(i,j,2)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'euclidean');
        corr_mat_1(i,j,3)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'euclidean');
        corr_mat_1(i,j,4)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'euclidean');
        corr_mat_1(i,j,5)=pdist2(feat.GGs{i},feat.GGs{j},'euclidean');
        corr_mat_1(i,j,6)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','euclidean');
        corr_mat_1(i,j,7)=pdist2(feat.LBPs{i},feat.LBPs{j},'euclidean');
        corr_mat_1(i,j,8)=pdist2(feat.TMRs{i},feat.TMRs{j},'euclidean');
    end
    disp("第"+num2str(i)+"处理完毕");
end
%保存矩阵到硬盘
save('corr1.mat','corr_mat_1','-v7.3');
end