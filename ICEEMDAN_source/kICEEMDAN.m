function imf = kICEEMDAN(data,Nstd,NE,MaxIter)
% ͳһ��װ���ICEEMDAN������ԭʼ������Դ��http://bioingenieria.edu.ar/grupos/ldnlys/metorres/re_inter.htm

% 
% ���룺
% data�����ֽ������
% Nstd��Ϊ����������׼����data��׼��֮��
% NE�����źŵ�ƽ������
% MaxIter������������
% 
% �����
% imf���ں�ģ̬������ͳһΪn*m��ʽ������nΪģ̬����mΪ���ݵ��������� imf(1,:)��IMF1��imf(emd,:)��Ϊ�в�

% ע�⣺��ʹ�øô���֮ǰ������ذ�װ�����䣺http://www.khscience.cn/docs/index.php/2020/04/09/1/

%%
rng(12345); %������ӣ���֤ÿ�����н��һ��
[imf]=iceemdan(data,Nstd,NE,MaxIter,1); %���ú���
end