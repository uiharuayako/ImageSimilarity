function minIndex = min6Super(matIn,oriType,imgData)
%�ҵ����������в�����С����С��Զ��ԭͼ������С��6�����֣��������ǵ��±꣬���������о�
    [~,i]=min(matIn);
    minIndex=1:6;%Ԥ������ڴ�ռ�
    matIn(i)=max(matIn);
    numIndex=0;% ��ʼ�ҵ����±�����Ϊ0
    while numIndex~=6
        [~,i]=min(matIn);
        if strcmp(oriType,imgData(i).type)
            numIndex=numIndex+1;%�±�����+1
            minIndex(numIndex)=i;%��¼λ��
            matIn(i)=max(matIn);%����С�ı������
        else            
            matIn(i)=max(matIn);%����С�ı������
        end
    end
end

