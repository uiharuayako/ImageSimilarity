function corr_cal_para_cos1()
% 使用余弦算法计算余弦的前三项
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat_cos1=zeros(numImg,numImg,3);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值
warning off;
for i=1:numImg
    for j=1:numImg
        %夹角余弦
        corr_mat_cos1(i,j,1)=pdist2(feat.Hists{i}',feat.Hists{j}','cosine');
        corr_mat_cos1(i,j,2)=pdist2(feat.GLCMfs{i},feat.GLCMfs{j},'cosine');
        corr_mat_cos1(i,j,3)=pdist2(feat.GLCMs{i},feat.GLCMs{j},'cosine');
    end
    disp("第"+num2str(i)+"处理完毕");
end
%保存矩阵到硬盘
save('corrCos1.mat','corr_mat_cos1','-v7.3');
end

