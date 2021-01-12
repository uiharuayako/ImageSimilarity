function [T] = GLCMfeature(IMG)
    %�Ҷȹ�������
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
    %�Ҷȹ��������4������
    [glcms,~]=graycomatrix(IMG,'NumLevels',16,'G',[],'offset',[0,1;-1,1;-1,0;-1,-1]);
    %����Ҷȹ��������ĸ������ĸ�����ֵ
    stats = graycoprops(glcms,'all');
    Con=[stats.Contrast];%�Աȶ�
    H=[stats.Homogeneity];%ͬ����
    Cor=[stats.Correlation];%�����
    En=[stats.Energy];%����
    I1=mean(Con);%��ֵ
    I2=mean(H);
    I3=mean(Cor);
    I4=mean(En);
    b1=sqrt(cov(Con));%��׼��
    b2=sqrt(cov(H));
    b3=sqrt(cov(Cor));
    b4=sqrt(cov(En));
    T=[I1,I2,I3,I4,b1,b2,b3,b4];
end

