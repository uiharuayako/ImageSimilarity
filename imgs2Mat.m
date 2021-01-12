function imgs2Mat(path)
%imgs2Mat(path) �������ǽ�����ͼƬ�ļ����������ݶ���һ�����󣬸þ���ʵ����Ϊһ���ṹ�����顣
% �ṹ����������ֶΣ�
% ͼ�������Ϣ���ļ���name��ͼ����Ϣ����data��data�Ǹ�m*n*3�ľ���ͼ������type
% ͼ��������Ϣ��������������Ҫwavelet toolbox
% ���У�ͼ�������Ǹ�ͼ���Ӧ�����ļ��������ú��������ñ��⼰һЩ�򵥵���չ������޶���tif��ʽ�����������path��ͼ��ĸ�Ŀ¼��
% ͼ���ļ������������ path/���ļ���/�ļ���.tif ���ļ��ṹ�������޷�������ȡ����ȷ����
subfolder=dir(path);
%�������ļ��У������3��ʼ����Ϊdir��ȡ���ĵ�һ���͵ڶ����ļ����Ƿǳ�����ġ�
imgTotNum=0;%��ʶͼƬ����
nowTotnum=0;
for i=3:length(subfolder)
    imgTotNum=imgTotNum+length(dir(fullfile(subfolder(i).folder,subfolder(i).name,'/*.tif')));
end
imgMat=repmat(imgInClass,1,imgTotNum);
for i=3:length(subfolder)
    type=subfolder(i).name;
    tmpDir=fullfile(subfolder(i).folder,type);
    tmpImgs=dir(fullfile(tmpDir,'/*.tif'));
    parfor j=1:length(tmpImgs)%�������ļ����е�ÿһ��ͼƬ
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
    Hists{i}=imgMat(i).feats.Hist;%�Ҷ�ֱ��ͼ
    GLCMfs{i}=imgMat(i).feats.GLCMf;%�Ҷȹ��������������Ƕ���ͼ���������㡣8���������ֱ�Ϊ4�����Եľ�ֵ�ͱ�׼�matlab�ܲ���GLCM�����ֻ�����ص�����
    GLCMs{i}=imgMat(i).feats.GLCMf;%GLCM����
    GLDSs{i}=imgMat(i).feats.GLDS;%�ҶȲ��ͳ�ƣ�����4������
    GGs{i}=imgMat(i).feats.GG;%�Ҷ��ݶȹ������󣬲���15������
    Lawss{i}=imgMat(i).feats.Laws;%LAWS����������ȡ
    LBPs{i}=imgMat(i).feats.LBP;%Local Binary Pattern���ֲ���ֵģʽ��������ȡ
    TMRs{i}=imgMat(i).feats.TMR;%���������������Ӿ���֪������ѧ���о���Tamura������ȡ,6����ͬ����������Щ�໥����
end
save('imgWithFeatures.mat','imgMat','-v7.3');
save('features.mat','Hists','GLCMfs','GLCMs','GLDSs','GGs','Lawss','LBPs','TMRs','-v7.3');
end   

