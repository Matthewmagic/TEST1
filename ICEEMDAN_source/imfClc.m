function [VarR,AvePer,PearsonCor] = imfClc(data,imf)
%%
% 对于“类EMD”方法分解后得到的各个分量计算评价指标
% 包括方差贡献率、平均周期和Pearson相关系数
% 输入：
% data：分解前的原数据
% imf：分解后得到的分量，注意imf需要沿行方向分布
% 输出：
% VarR：方差贡献率
% AvePer：平均周期
% PearsonCor：Pearson相关系数
%% 1.计算方差贡献率
VarR = var(imf')/var(data);
%% 2.计算平均周期
%IMF平均周期等于该IMF的样本数与其极大值点（或极小值点）个数的比值
%该指标可以用来显示价格影响因素的周期长短
[m,~] = size(imf);
for i = 1:m
    [pks] = findpeaks(imf(i,:));
    AvePer(i) = length(data)/length(pks);
end
%% 3.计算Pearson相关系数
[m,~] = size(imf);
for i = 1:m
    r = corrcoef(data(:)',imf(i,:));
    PearsonCor(i) = r(1,2);
end

%%
end