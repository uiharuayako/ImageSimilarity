function corr_cal_para2()
% CORR_CAL_PARA2 并行计算2，用于计算夹角余弦距离
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat_2=zeros(numImg,numImg,8);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值
warning off;
for i=1:numImg
    for j=1:numImg
        %夹角余弦
        corr_mat_2(i,j,1)=pdist2(feat.Hists{i}',feat.Hists{j}','cosine');
        corr_mat_2(i,j,2)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'cosine');
        corr_mat_2(i,j,3)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'cosine');
        corr_mat_2(i,j,4)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'cosine');
        corr_mat_2(i,j,5)=pdist2(feat.GGs{i},feat.GGs{j},'cosine');
        corr_mat_2(i,j,6)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','cosine');
        corr_mat_2(i,j,7)=pdist2(feat.LBPs{i},feat.LBPs{j},'cosine');
        corr_mat_2(i,j,8)=pdist2(feat.TMRs{i},feat.TMRs{j},'cosine');
    end
    disp("第"+num2str(i)+"处理完毕");
end
%保存矩阵到硬盘
save('corr2.mat','corr_mat_2','-v7.3');
end

