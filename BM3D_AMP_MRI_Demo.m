%% BM3D-AMP-MRI Matlab Code
% If you utilize this code, please cite the related paper: 
% E.M. Eksioglu and A.K. Tanc, "Denoising AMP for MRI Reconstruction: 
% BM3D-AMP-MRI," SIAM Journal on Imaging Sciences, DOI: 10.1137/18M1169655
% Code written by Ender M. Eksioglu and A. Korhan Tanc; August, 2018

clear all;
close all;

addpath(genpath(pwd))

%% Select Example %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (example=1 for real-valued MR, example=2 for complex-valued MR) %%%%%%%%

example=2;

%% Original MRI, k-space Mask and Relative Noise Power in dB  %%%%%%%%%%%%%

if example==1
    filename='Bust.jpg';x_0 = double(imread(filename))/255;
    load Q_Radial20.mat;OMEGA = find(Q1(:));
    RNP=-20;                       % For noiseless case, select RNP as -200
    disp(['Real Bust MRI with 20% Radial Sampling and ',...
        num2str(RNP) ' dB Relative Noise Power...']);
elseif example==2
    load Brain2.mat;x_0=(im_ori);
    load Q_Radial20.mat;OMEGA = find(Q1(:));
    RNP=-20;                       % For noiseless case, select RNP as -200
    disp(['Complex Brain2 MRI with 20% Radial Sampling and ',...
        num2str(RNP) ' dB Relative Noise Power']);
end

%% Threshold Parameter, Number of Iterations and Affine Transform Parameter

lambda_thr3D=2.7;
if example==1
    iters=50;
    ymin=-1;  % This means that the Affine Transform has been cancelled out 
elseif example==2
    iters=100;
    ymin=0.2;                                      %% Note that ymax=1-ymin 
end

%%

[m,n]=size(x_0); 

f = x_0(:);
k = length(OMEGA);
SamplingRate=k/(m*n);

%% Define the subsampled FFT transform for the given mask and its adjoint %

FT = @(x) A_fhp_vec(x, OMEGA, m, n);
IFT = @(x) At_fhp_vec(x, OMEGA, m, n);

%% Generate noisy MR k-space data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y=FT(f);
rng('default');
noise=randn(2*k,1);
cons_1=sum(noise.^2);
cons_2=sum(y.^2)*10^(RNP/10);
noise=sqrt(cons_2/cons_1)*noise;
y=y+noise;

%% MRI Reconstruction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Zero-filling reconstruction
x_ZF=reshape(IFT(y),[m n]);
performance_ZF=SNR_C((x_ZF(:)),(x_0(:)));
disp(['ZF Reconstruction SNR is ',num2str(performance_ZF) ' dB']);

% BM3D-IT-MRI reconstruction
tstart=tic;[x_BM3D,PSNR_BM3D] = BM3D_CMRI(y,iters,m,n,FT,IFT,ymin,...
    lambda_thr3D);toc(tstart)
performance_BM3D=SNR_C((x_BM3D(:)),(x_0(:)));
disp(['BM3D-IT Reconstruction SNR is ',num2str(performance_BM3D) ' dB']);

% BM3D-AMP-MRI reconstruction
tstart=tic;[x_DAMP,PSNR_DAMP] = DAMP_CMRI(y,iters,m,n,FT,IFT,ymin,...
    lambda_thr3D);toc(tstart)
performance_DAMP=SNR_C((x_DAMP(:)),(x_0(:)));
disp(['BM3D-AMP Reconstruction SNR is ',num2str(performance_DAMP) ' dB']);

%%

figure;
subplot(2,2,1);
imagesc(abs(x_0));title('Original MRI');colormap(gray);
subplot(2,2,2);
imagesc(abs(x_ZF));title('ZF-MRI');colormap(gray);
subplot(2,2,3);
imagesc(abs(x_BM3D));title('BM3D-IT-MRI');colormap(gray);
subplot(2,2,4);
imagesc(abs(x_DAMP));title('BM3D-AMP-MRI');colormap(gray);
