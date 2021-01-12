function [T] = GLCMfeature(IMG)
    %灰度共生矩阵
    [m,n]=size(IMG);
    I1=zeros(m,n);
    I2=zeros(m,n);
    I3=zeros(m,n);
    I4=zeros(m,n);
    b1=zeros(m,n);
    b2=zeros(m,n);
    b3=zeros(m,n);
    b4=zeros(m,n);
    T=zeros(400,4);
    %灰度共生矩阵和4个特征
    [glcms,~]=graycomatrix(IMG,'NumLevels',16,'G',[],'offset',[0,1;-1,1;-1,0;-1,-1]);
    %计算灰度共生矩阵四个方向四个特征值
    stats = graycoprops(glcms,'all');
    Con=[stats.Contrast];%对比度
    H=[stats.Homogeneity];%同质性
    Cor=[stats.Correlation];%相关性
    En=[stats.Energy];%能量
    I1=mean(Con);%均值
    I2=mean(H);
    I3=mean(Cor);
    I4=mean(En);
    b1=sqrt(cov(Con));%标准差
    b2=sqrt(cov(H));
    b3=sqrt(cov(Cor));
    b4=sqrt(cov(En));
    T=[I1,I2,I3,I4,b1,b2,b3,b4];
end

