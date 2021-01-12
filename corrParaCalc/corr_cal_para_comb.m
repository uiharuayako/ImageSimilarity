function corr_cal_para_comb()
% CORR_CAL_COMB ��������Ѿ�������ľ������Ϣ
corr_para1=load('corr1.mat');
corr_para2=load('corr2.mat');
corr_para3=load('corr3.mat');
numImg=length(corr_para1.corr_mat_1);
corr_mat=zeros(numImg,numImg,8,3);
% �ƣ�һά�Ǵ���ͼ�񣬶�ά�Ǳ���ͼ���飬��ά��ʹ������ֵ����ά�Ǽ������ķ�ʽ
corr_sum_nor=zeros(numImg,numImg);
warning off;
for i=1:numImg
    for j=1:numImg
        %ŷʽ����
        corr_mat(i,j,1,1)=corr_para1.corr_mat_1(i,j,1);
        corr_mat(i,j,2,1)=corr_para1.corr_mat_1(i,j,2);
        corr_mat(i,j,3,1)=corr_para1.corr_mat_1(i,j,3);
        corr_mat(i,j,4,1)=corr_para1.corr_mat_1(i,j,4);
        corr_mat(i,j,5,1)=corr_para1.corr_mat_1(i,j,5);
        corr_mat(i,j,6,1)=corr_para1.corr_mat_1(i,j,6);
        corr_mat(i,j,7,1)=corr_para1.corr_mat_1(i,j,7);
        corr_mat(i,j,8,1)=corr_para1.corr_mat_1(i,j,8);
        %�н�����
        corr_mat(i,j,1,2)=corr_para2.corr_mat_2(i,j,1);
        corr_mat(i,j,2,2)=corr_para2.corr_mat_2(i,j,2);
        corr_mat(i,j,3,2)=corr_para2.corr_mat_2(i,j,3);
        corr_mat(i,j,4,2)=corr_para2.corr_mat_2(i,j,4);
        corr_mat(i,j,5,2)=corr_para2.corr_mat_2(i,j,5);
        corr_mat(i,j,6,2)=corr_para2.corr_mat_2(i,j,6);
        corr_mat(i,j,7,2)=corr_para2.corr_mat_2(i,j,7);
        corr_mat(i,j,8,2)=corr_para2.corr_mat_2(i,j,8);
        %���ϵ�����޷�����laws��������
        corr_mat(i,j,1,3)=corr_para3.corr_mat_3(i,j,1);
        corr_mat(i,j,2,3)=corr_para3.corr_mat_3(i,j,2);
        corr_mat(i,j,3,3)=corr_para3.corr_mat_3(i,j,3);
        corr_mat(i,j,4,3)=corr_para3.corr_mat_3(i,j,4);
        corr_mat(i,j,5,3)=corr_para3.corr_mat_3(i,j,5);
        corr_mat(i,j,6,3)=corr_para3.corr_mat_3(i,j,6);
        corr_mat(i,j,7,3)=corr_para3.corr_mat_3(i,j,7);
        corr_mat(i,j,8,3)=corr_para3.corr_mat_3(i,j,8);
    end
    disp("��"+num2str(i)+"�������");
end
%ʹ�üн����ҽ��ж�������ͬ���㣬Ϊ�˱�֤����������Ȩ�ػ������ȣ�ʹ�þ�����������ֵ����
for methods=1:8
    tmpSeqM=corr_mat(:,:,methods,2);
    norM=tmpSeqM/max(tmpSeqM(:));% ����ȫ���Ȼ�����normalize�����ĺ������ƻ��������Ϣ
    corr_sum_nor=corr_sum_nor+norM;
end
%�������Ӳ��
save('corr.mat','corr_mat','corr_sum_nor', '-v7.3');
end

