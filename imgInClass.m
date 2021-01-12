classdef imgInClass
    %图片类，包含图片名称，内容，类型，完整路径和特征
    
    properties
        ID;
        name;
        data;
        type;
        path;
        feats;
    end  
    methods
        function obj = imgInClass(id,inputName,inputData,inputType,inputPath,inputFeats)
            %构造函数
            if nargin==6
                obj.ID=id;
                obj.name=inputName;
                obj.data=inputData;
                obj.type=inputType;
                obj.path=inputPath;
                obj.feats=inputFeats;
            else
                obj.ID=0;
                obj.name=0;
                obj.data=0;
                obj.type=0;
                obj.path=0;
                obj.feats=0;
            end
        end     
    end
end

