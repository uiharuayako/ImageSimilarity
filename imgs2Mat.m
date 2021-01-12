function imgs2Mat(path)
%imgs2Mat(path) 本函数是将所有图片文件包含的数据读入一个矩阵，该矩阵实际上为一个结构体数组。
% 结构体包含如下字段：
% 图像基本信息：文件名name，图像信息矩阵data，data是个m*n*3的矩阵，图像类型type
% 图像特征信息：计算此项必须需要wavelet toolbox
% 其中，图像类型是该图像对应的子文件夹名。该函数仅适用本题及一些简单的拓展情况（限定了tif格式），输入参数path是图像的根目录。
% 图像文件必须具有形如 path/子文件夹/文件名.tif 的文件结构，否则将无法正常读取和正确分类
subfolder=dir(path);
%遍历子文件夹，这里从3开始，因为dir获取到的第一个和第二个文件夹是非常特殊的。
imgTotNum=0;%标识图片总数
nowTotnum=0;
for i=3:length(subfolder)
    imgTotNum=imgTotNum+length(dir(fullfile(subfolder(i).folder,subfolder(i).name,'/*.tif')));
end
imgMat=repmat(imgInClass,1,imgTotNum);
for i=3:length(subfolder)
    type=subfolder(i).name;
    tmpDir=fullfile(subfolder(i).folder,type);
    tmpImgs=dir(fullfile(tmpDir,'/*.tif'));
    parfor j=1:length(tmpImgs)%遍历子文件夹中的每一个图片
        inputName=tmpImgs(j).name;
        inputPath=fullfile(tmpImgs(j).folder,tmpImgs(j).name);
        inputData=imread(inputPath);
        sizeTMP=size(inputData);
        if sizeTMP(1)~=256 || sizeTMP(2)~=256
            inputData=imresize(inputData,[256 256]);
        end
        inputType=type;
        inputFeats=imgFeats(inputData);
        imgMat(j+nowTotnum)=imgInClass(j+nowTotnum,inputName,inputData,inputType,inputPath,inputFeats);
    end
    nowTotnum=nowTotnum+length(tmpImgs);
end
parfor i=1:length(imgMat)
    Hists{i}=imgMat(i).feats.Hist;%灰度直方图
    GLCMfs{i}=imgMat(i).feats.GLCMf;%灰度共生矩阵特征，是对于图像的整体计算。8个变量，分别为4种特性的均值和标准差。matlab能产生GLCM的四种互不相关的特征
    GLCMs{i}=imgMat(i).feats.GLCMf;%GLCM本体
    GLDSs{i}=imgMat(i).feats.GLDS;%灰度差分统计，产生4个特征
    GGs{i}=imgMat(i).feats.GG;%灰度梯度共生矩阵，产生15个特征
    Lawss{i}=imgMat(i).feats.Laws;%LAWS纹理特征提取
    LBPs{i}=imgMat(i).feats.LBP;%Local Binary Pattern（局部二值模式）特征提取
    TMRs{i}=imgMat(i).feats.TMR;%基于人类对纹理的视觉感知的心理学的研究的Tamura特征提取,6个不同特征，但有些相互关联
end
save('imgWithFeatures.mat','imgMat','-v7.3');
save('features.mat','Hists','GLCMfs','GLCMs','GLDSs','GGs','Lawss','LBPs','TMRs','-v7.3');
end   

