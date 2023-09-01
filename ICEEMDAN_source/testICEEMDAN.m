clc
clear
close all
%ICEEMDAN方法的测试脚本程序
% %% 1.生成仿真信号
% % fs = 400;  %采样频率
% % t = 0:1/fs:0.75; %时间轴
% % x = sin(2*pi*4*t); %低频正弦信号
% % y = 0.5*sin(2*pi*120*t); %高频正弦信号
% % for i = 1:length(t) %将高频信号处理成间断性
% %     if mod(t(i),0.25)>0.11&&mod(t(i),0.25)<0.12
% %     else
% %         y(i) = 0;
% %     end
% % end
% % sig = x+y; %信号叠加
% % figure('color','white')
% % plot(t,sig,'k') %绘制原始信号
% fm = 1000;  %采样频率
% t = 0:1/fm:1; %时间轴
% x = sin(2*pi*40*t); %低频正弦信号
% y = 0.5*sin(pi*120*t); %高频正弦信号
% for i = 1:length(t) %将高频信号处理成间断性
%     if mod(t(i),0.25)>0.11&&mod(t(i),0.25)<0.12
%     else
%         y(i) = 0;
%     end
% end
% x2=0.4*cos(60*pi*t+sin(pi*10*t));
% x3=(1+0.3*cos(20*pi*5*t)).*sin(400*pi*t);
%  sig1= x+y+x2+x3
%  %%2.加噪声
% %  Y= x+y+x2+x3+randn(size(t));
%   [Y,NOISE] = noisegen(sig1,15)
% %   figure('color','w')
% % plot(Y);
% % 1.2真实振动信号，加载数据excel文件
fs = 1000;  %采样频率
% t = 0:1/fs:1; %时间轴
% Y=xlsread('Vibration.xls','A3500:A6500');%载入数据
Y=xlsread('yyy.xlsx','A1:ALL1');%载入数据
 t = (0:length(Y)-1)/fs; %横坐标轴值
figure
plot(t,Y)  %绘制原始信号图
xlabel('Time(s)') %横坐标标签
ylabel('A')
title('Test Signal')
%% 2.ICEEMDAN分解图
Nstd = 0.2; %Nstd为附加噪声标准差与Y标准差之比
NE = 100;   %NE为对信号的平均次数
MaxIter = 1000;% MaxIter 最大迭代次数
imf = pICEEMDAN(Y,t,Nstd,NE,MaxIter);
%%
% function imf = pICEEMDAN(data,FsOrT,Nstd,NE,MaxIter)
% 画信号ICEEMDAN分解图
% 输入：
% data为待分解信号
% FsOrT为采样频率或采样时间向量，如果为采样频率，该变量输入单个值；如果为时间向量，该变量为与y相同长度的一维向量。如果未知采样频率，可设置为1
% Nstd为附加噪声标准差与Y标准差之比
% NE为对信号的平均次数
% MaxIter：最大迭代次数
% 输出：
% imf为经ICEEMDAN分解后的各imf分量值
% 例1：（FsOrT为采样频率）
% fs = 100;
% t = 1/fs:1/fs:1;
% data = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDAN(data,fs,0.2,100);
% 例2：（FsOrT为时间向量，需要注意此时FsOrT的长度要与y相同）
% t = 0:0.01:1;
% data = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDAN(data,t,0.2,100);
%% 3.ICEEMDAN分解及频谱图
imf = pICEEMDANandFFT(Y,t,Nstd,NE,MaxIter);% 画信号EEMD分解与各IMF分量频谱对照图
% function imf = pICEEMDANandFFT(y,FsOrT,Nstd,NE,MaxIter)
% 画信号ICEEMDAN分解与各IMF分量频谱对照图
% 输入：
% y为待分解信号
% FsOrT为采样频率或采样时间向量，如果为采样频率，该变量输入单个值；如果为时间向量，该变量为与y相同长度的一维向量
% Nstd为附加噪声标准差与Y标准差之比
% NE为对信号的平均次数
% MaxIter：最大迭代次数
% 输出：
% imf为经ICEEMDAN分解后的各imf分量值
% 例1：（FsOrT为采样频率）
% fs = 100;
% t = 1/fs:1/fs:1;
% y = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDANandFFT(y,fs,0.2,100);
% 例2：（FsOrT为时间向量，需要注意此时FsOrT的长度要与y相同）
% t = 0:0.01:1;
% y = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDANandFFT(y,t,0.2,100);
%% 3.分析imf方差比，平均周期和Pearson相关系数
 [VarR,AvePer,PearsonCor] = imfClc(Y,imf(1:end-1,:));
% 对于“类EMD”方法分解后得到的各个分量计算评价指标
% 包括方差贡献率、平均周期和Pearson相关系数
% 输入：
% data：分解前的原数据
% imf：分解后得到的分量，注意imf需要沿行方向分布
% 输出：
% VarR：方差贡献率
% AvePer：平均周期
% PearsonCor：Pearson相关系数
disp(['各分量方差比为：',num2str(VarR)])       %最后一项为趋势项
disp(['各分量平均周期为：',num2str(AvePer)])   %最后一项为趋势项
disp(['各分量Pearson相关系数为：',num2str(PearsonCor)]) %最后一项为趋势项
%% 4.频率识别
[HighCom,LowCom,TrCom,HighIdx,LowIdx]=imfHLdif(Y,imf,'off');
% 根据重构算法将分解得出的IMF进行高低频的区分
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
disp(['高频IMF分量索引包括：',num2str(HighIdx)])
disp(['低频IMF分量索引包括：',num2str(LowIdx)])
%% 5.计算高低频分量和趋势项与原价格序列的相关系数与方差比
[VarR2,AvePer2,PearsonCor2] = imfClc(Y,[HighCom;LowCom;TrCom]);
disp(['高、低频分量和趋势项与原序列的相关系数：',num2str(PearsonCor2)])   
disp(['高、低频分量和趋势项与原序列的方差比：',num2str(VarR2)])   
%% 6.绘图
figure('color','w')
plot(Y);hold on
plot(HighCom);
plot(LowCom);
plot(TrCom);
legend('原始数据','高频分量','低频分量','趋势项')