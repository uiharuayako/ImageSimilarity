function corr_cal_para_cos3Comb()
%把cos3结合起来
cos1=load('corrCos3_1.mat');
cos2=load('corrCos3_2.mat');
cos3=load('corrCos3_3.mat');
numImg=2100;
corr_mat_cos3=zeros(numImg,numImg,3);
% 计：一维是待查图像，二维是被查图像组，三维是使用特征值
warning off;
for i=1:700
    for j=1:numImg
        %夹角余弦
        corr_mat_cos3(i,j,1)=cos1.corr_mat_cos3_1(i,j,1);
        corr_mat_cos3(i,j,2)=cos1.corr_mat_cos3_1(i,j,2);
        corr_mat_cos3(i,j,3)=cos1.corr_mat_cos3_1(i,j,3);
    end
    disp("第1-"+num2str(i)+"处理完毕");
end
for i=701:1400
    for j=1:numImg
        %夹角余弦
        corr_mat_cos3(i,j,1)=cos2.corr_mat_cos3_2(i,j,1);
        corr_mat_cos3(i,j,2)=cos2.corr_mat_cos3_2(i,j,2);
        corr_mat_cos3(i,j,3)=cos2.corr_mat_cos3_2(i,j,3);
    end
    disp("第2-"+num2str(i)+"处理完毕");
end
for i=1401:2100
    for j=1:numImg
        %夹角余弦
        corr_mat_cos3(i,j,1)=cos3.corr_mat_cos3_3(i,j,1);
        corr_mat_cos3(i,j,2)=cos3.corr_mat_cos3_3(i,j,2);
        corr_mat_cos3(i,j,3)=cos3.corr_mat_cos3_3(i,j,3);
    end
    disp("第3-"+num2str(i)+"处理完毕");
end
%保存矩阵到硬盘
save('corrCos3.mat','corr_mat_cos3','-v7.3');
end

