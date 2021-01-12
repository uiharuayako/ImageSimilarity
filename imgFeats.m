classdef imgFeats
    %图像特征类
    properties
        Hist;%灰度直方图
        GLCMf;%灰度共生矩阵特征，是对于图像的整体计算。8个变量，分别为4种特性的均值和标准差。matlab能产生GLCM的四种互不相关的特征
        GLCM;%GLCM本体
        GLDS;%灰度差分统计，产生4个特征
        GG;%灰度梯度共生矩阵，产生15个特征
        Laws;%LAWS纹理特征提取
        LBP;%Local Binary Pattern（局部二值模式）特征提取
        TMR;%基于人类对纹理的视觉感知的心理学的研究的Tamura特征提取,6个不同特征，但有些相互关联
    end
    
    methods
        function obj = imgFeats(image)
            if length(size(image))==3%是彩色就灰度化
                image=rgb2gray(image);%灰度化原图像，这里的features都是灰度的
            end
            %构造函数，需要输入图片名称，数据，类型
            obj.Hist=imhist(image);%灰度直方图
            obj.GLCMf=GLCMfeature(image);%灰度共生矩阵特征，是对于图像的整体计算。8个变量，分别为4种特性的均值和标准差。matlab能产生GLCM的四种互不相关的特征
            obj.GLCM=grayMat(image);%GLCM本体
            obj.GLDS=GLDSfeature(image);%灰度差分统计，产生4个特征
            obj.GG=GrayGradinet(image);%灰度梯度共生矩阵，产生15个特征
            obj.Laws=cell2mat(laws(image));%LAWS纹理特征提取
            obj.LBP=lbp(image);%Local Binary Pattern（局部二值模式）特征提取
            obj.TMR=Tamura(image);%基于人类对纹理的视觉感知的心理学的研究的Tamura特征提取,6个不同特征，但有些相互关联
        end
        function obj=plus(obj1,obj2)%运算符+重载
            obj.Hist=(obj1.Hist+obj2.Hist)/2;
            obj.GLCMf=(obj1.GLCMf+obj2.GLCMf)/2;
            obj.GLCM=(obj1.GLCM+obj2.GLCM)/2;
            obj.GLDS=(obj1.GLDS+obj2.GLDS)/2;
            obj.GG=(obj1.GG+obj2.GG)/2;
            obj.Laws=(obj1.Laws+obj2.Laws)/2;
            obj.LBP=(obj1.LBP+obj2.LBP)/2;
            obj.TMR=(obj1.TMR+obj2.TMR)/2;
        end
    end
end

