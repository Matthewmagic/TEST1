clc
clear
close all
%ICEEMDAN�����Ĳ��Խű�����
% %% 1.���ɷ����ź�
% % fs = 400;  %����Ƶ��
% % t = 0:1/fs:0.75; %ʱ����
% % x = sin(2*pi*4*t); %��Ƶ�����ź�
% % y = 0.5*sin(2*pi*120*t); %��Ƶ�����ź�
% % for i = 1:length(t) %����Ƶ�źŴ���ɼ����
% %     if mod(t(i),0.25)>0.11&&mod(t(i),0.25)<0.12
% %     else
% %         y(i) = 0;
% %     end
% % end
% % sig = x+y; %�źŵ���
% % figure('color','white')
% % plot(t,sig,'k') %����ԭʼ�ź�
% fm = 1000;  %����Ƶ��
% t = 0:1/fm:1; %ʱ����
% x = sin(2*pi*40*t); %��Ƶ�����ź�
% y = 0.5*sin(pi*120*t); %��Ƶ�����ź�
% for i = 1:length(t) %����Ƶ�źŴ���ɼ����
%     if mod(t(i),0.25)>0.11&&mod(t(i),0.25)<0.12
%     else
%         y(i) = 0;
%     end
% end
% x2=0.4*cos(60*pi*t+sin(pi*10*t));
% x3=(1+0.3*cos(20*pi*5*t)).*sin(400*pi*t);
%  sig1= x+y+x2+x3
%  %%2.������
% %  Y= x+y+x2+x3+randn(size(t));
%   [Y,NOISE] = noisegen(sig1,15)
% %   figure('color','w')
% % plot(Y);
% % 1.2��ʵ���źţ���������excel�ļ�
fs = 1000;  %����Ƶ��
% t = 0:1/fs:1; %ʱ����
% Y=xlsread('Vibration.xls','A3500:A6500');%��������
Y=xlsread('yyy.xlsx','A1:ALL1');%��������
 t = (0:length(Y)-1)/fs; %��������ֵ
figure
plot(t,Y)  %����ԭʼ�ź�ͼ
xlabel('Time(s)') %�������ǩ
ylabel('A')
title('Test Signal')
%% 2.ICEEMDAN�ֽ�ͼ
Nstd = 0.2; %NstdΪ����������׼����Y��׼��֮��
NE = 100;   %NEΪ���źŵ�ƽ������
MaxIter = 1000;% MaxIter ����������
imf = pICEEMDAN(Y,t,Nstd,NE,MaxIter);
%%
% function imf = pICEEMDAN(data,FsOrT,Nstd,NE,MaxIter)
% ���ź�ICEEMDAN�ֽ�ͼ
% ���룺
% dataΪ���ֽ��ź�
% FsOrTΪ����Ƶ�ʻ����ʱ�����������Ϊ����Ƶ�ʣ��ñ������뵥��ֵ�����Ϊʱ���������ñ���Ϊ��y��ͬ���ȵ�һά���������δ֪����Ƶ�ʣ�������Ϊ1
% NstdΪ����������׼����Y��׼��֮��
% NEΪ���źŵ�ƽ������
% MaxIter������������
% �����
% imfΪ��ICEEMDAN�ֽ��ĸ�imf����ֵ
% ��1����FsOrTΪ����Ƶ�ʣ�
% fs = 100;
% t = 1/fs:1/fs:1;
% data = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDAN(data,fs,0.2,100);
% ��2����FsOrTΪʱ����������Ҫע���ʱFsOrT�ĳ���Ҫ��y��ͬ��
% t = 0:0.01:1;
% data = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDAN(data,t,0.2,100);
%% 3.ICEEMDAN�ֽ⼰Ƶ��ͼ
imf = pICEEMDANandFFT(Y,t,Nstd,NE,MaxIter);% ���ź�EEMD�ֽ����IMF����Ƶ�׶���ͼ
% function imf = pICEEMDANandFFT(y,FsOrT,Nstd,NE,MaxIter)
% ���ź�ICEEMDAN�ֽ����IMF����Ƶ�׶���ͼ
% ���룺
% yΪ���ֽ��ź�
% FsOrTΪ����Ƶ�ʻ����ʱ�����������Ϊ����Ƶ�ʣ��ñ������뵥��ֵ�����Ϊʱ���������ñ���Ϊ��y��ͬ���ȵ�һά����
% NstdΪ����������׼����Y��׼��֮��
% NEΪ���źŵ�ƽ������
% MaxIter������������
% �����
% imfΪ��ICEEMDAN�ֽ��ĸ�imf����ֵ
% ��1����FsOrTΪ����Ƶ�ʣ�
% fs = 100;
% t = 1/fs:1/fs:1;
% y = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDANandFFT(y,fs,0.2,100);
% ��2����FsOrTΪʱ����������Ҫע���ʱFsOrT�ĳ���Ҫ��y��ͬ��
% t = 0:0.01:1;
% y = sin(2*pi*5*t)+2*sin(2*pi*20*t);
% imf = pICEEMDANandFFT(y,t,0.2,100);
%% 3.����imf����ȣ�ƽ�����ں�Pearson���ϵ��
 [VarR,AvePer,PearsonCor] = imfClc(Y,imf(1:end-1,:));
% ���ڡ���EMD�������ֽ��õ��ĸ���������������ָ��
% ����������ʡ�ƽ�����ں�Pearson���ϵ��
% ���룺
% data���ֽ�ǰ��ԭ����
% imf���ֽ��õ��ķ�����ע��imf��Ҫ���з���ֲ�
% �����
% VarR���������
% AvePer��ƽ������
% PearsonCor��Pearson���ϵ��
disp(['�����������Ϊ��',num2str(VarR)])       %���һ��Ϊ������
disp(['������ƽ������Ϊ��',num2str(AvePer)])   %���һ��Ϊ������
disp(['������Pearson���ϵ��Ϊ��',num2str(PearsonCor)]) %���һ��Ϊ������
%% 4.Ƶ��ʶ��
[HighCom,LowCom,TrCom,HighIdx,LowIdx]=imfHLdif(Y,imf,'off');
% �����ع��㷨���ֽ�ó���IMF���иߵ�Ƶ������
% �ο�������EEMDģ�͵��й�̼�г��۸��γɻ����о���
% �÷�����IMF1��Ϊָ��1��IMF1��IMF2Ϊָ��2���Դ����ƣ�
% ǰi��IMF�ĺͼӳ�Ϊָ��i�����Ըþ�ֵ�Ƿ�����������0����t���顣
% ���룺
% data���ֽ�ǰ��ԭʼ����
% imf������ģ̬�ֽⷽ���õ��ķ�����ÿһ��Ϊһ������
% figflag�������Ƿ�ͼ�Ĳ�����'on'Ϊ��ͼ��'off'Ϊ����ͼ
% �����
% HighCom���ع���ĸ�Ƶ����
% LowCom���ع���ĵ�Ƶ����
% TrCom��������
% HighIdx����Ƶ����������
% LowIdx����Ƶ����������
disp(['��ƵIMF��������������',num2str(HighIdx)])
disp(['��ƵIMF��������������',num2str(LowIdx)])
%% 5.����ߵ�Ƶ��������������ԭ�۸����е����ϵ���뷽���
[VarR2,AvePer2,PearsonCor2] = imfClc(Y,[HighCom;LowCom;TrCom]);
disp(['�ߡ���Ƶ��������������ԭ���е����ϵ����',num2str(PearsonCor2)])   
disp(['�ߡ���Ƶ��������������ԭ���еķ���ȣ�',num2str(VarR2)])   
%% 6.��ͼ
figure('color','w')
plot(Y);hold on
plot(HighCom);
plot(LowCom);
plot(TrCom);
legend('ԭʼ����','��Ƶ����','��Ƶ����','������')