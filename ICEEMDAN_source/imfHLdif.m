function [HighCom,LowCom,TrCom,HighIdx,LowIdx]=imfHLdif(data,imf,figflag)
%% 根据重构算法将分解得出的IMF进行高低频的区分
% 参考《基于EEMD模型的中国碳市场价格形成机制研究》
% 该方法将IMF1记为指标1，IMF1＋IMF2为指标2，以此类推，
% 前i个IMF的和加成为指标i，并对该均值是否显著区别于0进行t检验。
% 输入：
% data：分解前的原始数据
% imf：经过模态分解方法得到的分量，每一行为一个分量
% figflag：设置是否画图的参数，'on'为画图，'off'为不画图
% 输出：
% HighCom：重构后的高频分量
% LowCom：重构后的低频分量
% TrCom：趋势项
% HighIdx：高频分量对索引
% LowIdx：低频分量对索引


[m,n] = size(imf);
% ind(1,:) = imf(1,:);
% for i = 2:m-1
%     ind(i,:) = sum(imf(1:i,:));
% end
ttval = ttest(imf'); %进行t检验
k = find(ttval==1);  %k(1)即为第一次未通过检验的索引
HighIdx = 1:k(1)-1; %高频分量对索引
LowIdx = k(1):m-1; %低频分量对索引
if length(HighIdx) == 1
    HighCom = imf(HighIdx,:);
else
    HighCom = sum(imf(HighIdx,:)); %高频分量重构
end
if length(LowIdx) == 1
    LowCom  = imf(LowIdx,:);  %低频分量重构
else
    LowCom  = sum(imf(LowIdx,:));  %低频分量重构
end
TrCom   = imf(m,:); %趋势项分量
%% 画图
figure('color','w','Visible',figflag)
plot(data);hold on
plot(HighCom);
plot(LowCom);
plot(TrCom);
legend('原始数据','高频分量','低频分量','趋势项')
end