function [VarR,AvePer,PearsonCor] = imfClc(data,imf)
%%
% ���ڡ���EMD�������ֽ��õ��ĸ���������������ָ��
% ����������ʡ�ƽ�����ں�Pearson���ϵ��
% ���룺
% data���ֽ�ǰ��ԭ����
% imf���ֽ��õ��ķ�����ע��imf��Ҫ���з���ֲ�
% �����
% VarR���������
% AvePer��ƽ������
% PearsonCor��Pearson���ϵ��
%% 1.���㷽�����
VarR = var(imf')/var(data);
%% 2.����ƽ������
%IMFƽ�����ڵ��ڸ�IMF�����������伫��ֵ�㣨��Сֵ�㣩�����ı�ֵ
%��ָ�����������ʾ�۸�Ӱ�����ص����ڳ���
[m,~] = size(imf);
for i = 1:m
    [pks] = findpeaks(imf(i,:));
    AvePer(i) = length(data)/length(pks);
end
%% 3.����Pearson���ϵ��
[m,~] = size(imf);
for i = 1:m
    r = corrcoef(data(:)',imf(i,:));
    PearsonCor(i) = r(1,2);
end

%%
end