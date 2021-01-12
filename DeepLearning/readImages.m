function data = readImages(filename)
%READIMAGES ¶ÁÈ¡²¢Ëõ·ÅÍ¼Ïñ
data=imresize(imread(filename),[224 224]);
end