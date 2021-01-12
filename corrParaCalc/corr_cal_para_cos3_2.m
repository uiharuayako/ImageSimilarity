function corr_cal_para_cos3_2()
% 使用余弦算法计算余弦的后两项
feat=load('features.mat');
numImg=length(feat.Hists);
corr_mat_cos3_2=zeros(numImg,numImg,3);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值
warning off;
for i=701:1400
    for j=1:numImg
        %夹角余弦
        corr_mat_cos3_2(i,j,1)=pdist2(feat.Lawss{i}(:)',feat.Lawss{j}(:)','cosine');
        corr_mat_cos3_2(i,j,2)=pdist2(feat.LBPs{i},feat.LBPs{j},'cosine');
        corr_mat_cos3_2(i,j,3)=pdist2(feat.TMRs{i},feat.TMRs{j},'cosine');
    end
    disp("第"+num2str(i)+"处理完毕");
end
%保存矩阵到硬盘
save('corrCos3_2.mat','corr_mat_cos3_2','-v7.3');
end

