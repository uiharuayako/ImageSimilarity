function minIndex = min6(matIn)
%�ҵ����������в�����С����С��Զ��ԭͼ������С��6�����֣��������ǵ��±�
    [~,i]=min(matIn);
    minIndex=1:6;%Ԥ������ڴ�ռ�
    matIn(i)=max(matIn);
    for j=1:6
        [~,i]=min(matIn);
        minIndex(j)=i;%��¼λ��
        matIn(i)=max(matIn);%����С�ı������
    end
end

