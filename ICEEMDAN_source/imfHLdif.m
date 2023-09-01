function [HighCom,LowCom,TrCom,HighIdx,LowIdx]=imfHLdif(data,imf,figflag)
%% �����ع��㷨���ֽ�ó���IMF���иߵ�Ƶ������
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


[m,n] = size(imf);
% ind(1,:) = imf(1,:);
% for i = 2:m-1
%     ind(i,:) = sum(imf(1:i,:));
% end
ttval = ttest(imf'); %����t����
k = find(ttval==1);  %k(1)��Ϊ��һ��δͨ�����������
HighIdx = 1:k(1)-1; %��Ƶ����������
LowIdx = k(1):m-1; %��Ƶ����������
if length(HighIdx) == 1
    HighCom = imf(HighIdx,:);
else
    HighCom = sum(imf(HighIdx,:)); %��Ƶ�����ع�
end
if length(LowIdx) == 1
    LowCom  = imf(LowIdx,:);  %��Ƶ�����ع�
else
    LowCom  = sum(imf(LowIdx,:));  %��Ƶ�����ع�
end
TrCom   = imf(m,:); %���������
%% ��ͼ
figure('color','w','Visible',figflag)
plot(data);hold on
plot(HighCom);
plot(LowCom);
plot(TrCom);
legend('ԭʼ����','��Ƶ����','��Ƶ����','������')
end