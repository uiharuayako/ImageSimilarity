function corr_cal_para_cosComb()
% 结合三个已经计算完的cos的信息
corr_para1=load('corrCos1.mat');
corr_para2=load('corrCos2.mat');
corr_para3=load('corrCos3.mat');
numImg=length(corr_para1.corr_mat_cos1);
corr_mat_2=zeros(numImg,numImg,8);
warning off;
for i=1:numImg
    for j=1:numImg
        %夹角余弦
        corr_mat_2(i,j,1)=corr_para1.corr_mat_cos1(i,j,1);
        corr_mat_2(i,j,2)=corr_para1.corr_mat_cos1(i,j,2);
        corr_mat_2(i,j,3)=corr_para1.corr_mat_cos1(i,j,3);
        corr_mat_2(i,j,4)=corr_para2.corr_mat_cos2(i,j,1);
        corr_mat_2(i,j,5)=corr_para2.corr_mat_cos2(i,j,2);
        corr_mat_2(i,j,6)=corr_para3.corr_mat_cos3(i,j,1);
        corr_mat_2(i,j,7)=corr_para3.corr_mat_cos3(i,j,2);
        corr_mat_2(i,j,8)=corr_para3.corr_mat_cos3(i,j,3);
    end
    disp("第"+num2str(i)+"处理完毕");
end
%保存矩阵到硬盘
save('corr2.mat','corr_mat_2','-v7.3');
end