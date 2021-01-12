function minIndex = min6(matIn)
%找到输入数组中不是最小（最小永远是原图）且最小的6个数字，返回他们的下标
    [~,i]=min(matIn);
    minIndex=1:6;%预分配个内存空间
    matIn(i)=max(matIn);
    for j=1:6
        [~,i]=min(matIn);
        minIndex(j)=i;%记录位置
        matIn(i)=max(matIn);%把最小的变成最大的
    end
end

