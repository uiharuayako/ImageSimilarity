function corr_cal_para_comb()
% CORR_CAL_COMB 结合三个已经计算完的矩阵的信息
corr_para1=load('corr1.mat');
corr_para2=load('corr2.mat');
corr_para3=load('corr3.mat');
numImg=length(corr_para1.corr_mat_1);
corr_mat=zeros(numImg,numImg,8,3);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值，四维是计算距离的方式
corr_sum_nor=zeros(numImg,numImg);
warning off;
for i=1:numImg
    for j=1:numImg
        %欧式距离
        corr_mat(i,j,1,1)=corr_para1.corr_mat_1(i,j,1);
        corr_mat(i,j,2,1)=corr_para1.corr_mat_1(i,j,2);
        corr_mat(i,j,3,1)=corr_para1.corr_mat_1(i,j,3);
        corr_mat(i,j,4,1)=corr_para1.corr_mat_1(i,j,4);
        corr_mat(i,j,5,1)=corr_para1.corr_mat_1(i,j,5);
        corr_mat(i,j,6,1)=corr_para1.corr_mat_1(i,j,6);
        corr_mat(i,j,7,1)=corr_para1.corr_mat_1(i,j,7);
        corr_mat(i,j,8,1)=corr_para1.corr_mat_1(i,j,8);
        %夹角余弦
        corr_mat(i,j,1,2)=corr_para2.corr_mat_2(i,j,1);
        corr_mat(i,j,2,2)=corr_para2.corr_mat_2(i,j,2);
        corr_mat(i,j,3,2)=corr_para2.corr_mat_2(i,j,3);
        corr_mat(i,j,4,2)=corr_para2.corr_mat_2(i,j,4);
        corr_mat(i,j,5,2)=corr_para2.corr_mat_2(i,j,5);
        corr_mat(i,j,6,2)=corr_para2.corr_mat_2(i,j,6);
        corr_mat(i,j,7,2)=corr_para2.corr_mat_2(i,j,7);
        corr_mat(i,j,8,2)=corr_para2.corr_mat_2(i,j,8);
        %相关系数，无法计算laws纹理特征
        corr_mat(i,j,1,3)=corr_para3.corr_mat_3(i,j,1);
        corr_mat(i,j,2,3)=corr_para3.corr_mat_3(i,j,2);
        corr_mat(i,j,3,3)=corr_para3.corr_mat_3(i,j,3);
        corr_mat(i,j,4,3)=corr_para3.corr_mat_3(i,j,4);
        corr_mat(i,j,5,3)=corr_para3.corr_mat_3(i,j,5);
        corr_mat(i,j,6,3)=corr_para3.corr_mat_3(i,j,6);
        corr_mat(i,j,7,3)=corr_para3.corr_mat_3(i,j,7);
        corr_mat(i,j,8,3)=corr_para3.corr_mat_3(i,j,8);
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

