function data = readImages(filename)
%READIMAGES ��ȡ������ͼ��
data=imresize(imread(filename),[224 224]);
end