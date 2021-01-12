function gMat = grayMat(image)
%GRAYMAT ����һ���Ҷ�ͼ���������0�㣬45�㣬90�㣬135��ĻҶȹ����������ջὫ��ƴ��һ�������
%   �÷�ʽ���ڼ��������
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