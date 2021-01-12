imds = imageDatastore('Images', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames', ...
     'ReadFcn',@readImages);  % 读入图片作为训练对象
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.8); % 将80%的图像用于训练，20%的图像用于验证
net=googlenet;% 载入预训练数据集，选用有1000个分类的googlenet
% 判断输入的卷积网络模板
if isa(net,'SeriesNetwork') 
  lgraph = layerGraph(net.Layers); 
else
  lgraph = layerGraph(net);
end
% 在大多数网络中，具有可学习权重的最后一层是全连接层。
% 将此全连接层替换为新的全连接层，其中输出数量等于新数据集中类的数量（在作业中为21）。
% 而在某些网络（如 SqueezeNet）中，最后一个可学习层是一个 1×1 卷积层。
% 在这种情况下，请将该卷积层替换为新的卷积层，其中过滤器的数量等于类的数量。
[learnableLayer,classLayer] = findLayersToReplace(lgraph);
inputSize = net.Layers(1).InputSize;
numClasses = numel(categories(imdsTrain.Labels));

if isa(learnableLayer,'nnet.cnn.layer.FullyConnectedLayer')
    newLearnableLayer = fullyConnectedLayer(numClasses, ...
        'Name','new_fc', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
    
elseif isa(learnableLayer,'nnet.cnn.layer.Convolution2DLayer')
    newLearnableLayer = convolution2dLayer(1,numClasses, ...
        'Name','new_conv', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
end

lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);

newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,classLayer.Name,newClassLayer);

% 让前十层不学习
layers = lgraph.Layers;
connections = lgraph.Connections;

layers(1:10) = freezeWeights(layers(1:10));
lgraph = createLgraphUsingConnections(layers,connections);
% 改变被训练的图像以防止出现类似作弊的现象，同时防止网络过拟合和记忆训练图像的具体细节。
pixelRange = [-30 30];
scaleRange = [0.9 1.1];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange, ...
    'RandXScale',scaleRange, ...
    'RandYScale',scaleRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
% 选择用于验证的图像
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);
% 指定最小的batch
miniBatchSize = 100;
valFrequency = floor(numel(augimdsTrain.Files)/miniBatchSize);
% 指定数据
options = trainingOptions('sgdm', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',20, ...
    'InitialLearnRate',3e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',valFrequency, ...
    'Verbose',false, ...
    'Plots','training-progress');
% 开始训练
net = trainNetwork(augimdsTrain,lgraph,options);
% 使用全部图像重新计算准确度
[YPred,probs] = classify(net,imds);
accuracy = mean(YPred == imds.Labels);
deepLearningRes = struct('accuracy',accuracy,'type',YPred,'allTypeRate',probs);
% save('myNet.mat','net','-v7.3');
% save('deep.mat','deepLearningRes','-v7.3');