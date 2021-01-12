function minIndex = min6Super(matIn,oriType,imgData)
%找到输入数组中不是最小（最小永远是原图）且最小的6个数字，返回他们的下标，加入类型判据
    [~,i]=min(matIn);
    minIndex=1:6;%预分配个内存空间
    matIn(i)=max(matIn);
    numIndex=0;% 初始找到的下标数量为0
    while numIndex~=6
        [~,i]=min(matIn);
        if strcmp(oriType,imgData(i).type)
            numIndex=numIndex+1;%下标数量+1
            minIndex(numIndex)=i;%记录位置
            matIn(i)=max(matIn);%把最小的变成最大的
        else            
            matIn(i)=max(matIn);%把最小的变成最大的
        end
    end
end

