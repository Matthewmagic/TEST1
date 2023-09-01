function imf = kICEEMDAN(data,Nstd,NE,MaxIter)
% 统一封装后的ICEEMDAN函数，原始代码来源：http://bioingenieria.edu.ar/grupos/ldnlys/metorres/re_inter.htm

% 
% 输入：
% data：待分解的数据
% Nstd：为附加噪声标准差与data标准差之比
% NE：对信号的平均次数
% MaxIter：最大迭代次数
% 
% 输出：
% imf：内涵模态分量，统一为n*m格式，其中n为模态数，m为数据点数。例如 imf(1,:)即IMF1，imf(emd,:)即为残差

% 注意：在使用该代码之前，请务必安装工具箱：http://www.khscience.cn/docs/index.php/2020/04/09/1/

%%
rng(12345); %随机种子，保证每次运行结果一致
[imf]=iceemdan(data,Nstd,NE,MaxIter,1); %调用函数
end