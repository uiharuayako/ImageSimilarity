function corr_cal_para_cos2()
% 使用余弦算法计算余弦的4 5项
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat_cos2=zeros(numImg,numImg,2);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值
warning off;
for i=1:numImg
    for j=1:numImg
        %夹角余弦
        corr_mat_cos2(i,j,1)=pdist2(feat.GLDSs{i},feat.GLDSs{j},'cosine');
        corr_mat_cos2(i,j,2)=pdist2(feat.GGs{i},feat.GGs{j},'cosine');
    end
    disp("第"+num2str(i)+"处理完毕");
end
%保存矩阵到硬盘
save('corrCos2.mat','corr_mat_cos2','-v7.3');
end

