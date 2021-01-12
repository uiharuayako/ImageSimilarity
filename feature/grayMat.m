function gMat = grayMat(image)
%GRAYMAT 输入一个灰度图像，输出其在0°，45°，90°，135°的灰度共生矩阵，最终会将其拼成一个大矩阵
%   该方式用于简单纹理分析
    gm = graycomatrix(image, 'offset', [0 1], 'Symmetric', true);
    gm = sqrt(gm);
    vector1 = reshape(gm, [1 8*8]);
    vector1 = vector1 / max(vector1);
    gm = graycomatrix(image, 'offset', [-1 1], 'Symmetric', true);
    gm = sqrt(gm);
    vector2 = reshape(gm, [1 8*8]);
    vector2 = vector2 / max(vector2);
    gm = graycomatrix(image, 'offset', [-1 0], 'Symmetric', true);
    gm = sqrt(gm);
    vector3 = reshape(gm, [1 8*8]);
    vector3 = vector3 / max(vector3);
    gm = graycomatrix(image, 'offset', [-1 -1], 'Symmetric', true);
    gm = sqrt(gm);
    vector4 = reshape(gm, [1 8*8]);
    vector4 = vector4 / max(vector4);
    gMat = [vector1 vector2 vector3 vector4];
end