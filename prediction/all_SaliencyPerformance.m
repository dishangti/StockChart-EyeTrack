% -------------------------------------------------------------------------
% calculate the saliency prediction performance
% run AUC_Judd, AUC_shuffled, NSS, CC
% -------------------------------------------------------------------------
clc
clear all
%Add folders to the top of the search path
addpath('E:\research\k_eyetracker\Eye movement_ data\datapre+metrics\MIT-Saliency\saliency-master\code_forMetrics') 
% data preparation

ASD_FixationPtsPath = 'E:\research\k_eyetracker\Eye movement_ data\experimental data\png\1280x1024\fpTest\';
% % add the path of the files named groundtruth
ASD_FixationMapsPath = 'E:\research\k_eyetracker\Eye movement_ data\experimental data\png\1280x1024\fmTest\';
% %add the path of the files named saliency
saliencyMapsPath = 'E:\research\k_eyetracker\Eye movement_ data\experimental data\saliency map\png\handledImgs\samVgg\';
% %add the path of the files named order
shunxu=xlsread ('E:\research\k_eyetracker\Eye movement_ data\dataset\shunxu_finetune.xlsx');%file named 'shunxu',get!

%% data number
startNum = 1;
totalNum = 30;

%% initial results
ASD_AUC_Borji= [];
ASD_NSS_score = [];
ASD_CC_score = [];

for cnt = startNum:totalNum
    ASD_FixationPts = im2double(imread([ASD_FixationPtsPath, num2str(shunxu(cnt)), '.png']));
    ASD_FixationMap = im2double(imread([ASD_FixationMapsPath, num2str(shunxu(cnt)), '.png'])); 
    saliencyMap = im2double(imread([saliencyMapsPath, num2str(shunxu(cnt)),'.png']));
    
    tic
    disp('AUC_Judd');
    [temp_ASD_AUC_Judd_score,tp,fp,allthreshes] = AUC_Judd(saliencyMap, ASD_FixationPts);
    ASD_AUC_Judd_score(cnt - startNum + 1) = temp_ASD_AUC_Judd_score;
    toc
    
    %% NSS
    tic
    disp('NSS');
    temp_ASD_NSS_score = NSS(saliencyMap, ASD_FixationPts);
    ASD_NSS_score(cnt - startNum + 1) = temp_ASD_NSS_score;
    toc
    
    %% CC
    tic
    disp('CC');
    temp_ASD_CC_score = CC(saliencyMap, ASD_FixationMap);
    %temp_Normal_CC_score = CC(saliencyMap, Normal_FixationMap);
    ASD_CC_score(cnt - startNum + 1) = temp_ASD_CC_score;
    %Normal_CC_score(cnt - startNum + 1) = temp_Normal_CC_score;
    toc
    
    %% SIM
    tic
    disp('SIM');
    temp_ASD_SIM_score = similarity(saliencyMap, ASD_FixationMap);
    ASD_SIM_score(cnt - startNum + 1) = temp_ASD_SIM_score;
    toc
    %%SSIM
    tic
    disp('SSIM');
    temp_ASD_SSIM_score = ssim(saliencyMap, ASD_FixationMap);
    ASD_SSIM_score(cnt - startNum + 1) = temp_ASD_SSIM_score;
    toc
end

%% average
ave_ASD_AUC_Judd_score = sum(ASD_AUC_Judd_score,2)/(totalNum - startNum);
ave_ASD_NSS_score = sum(ASD_NSS_score,2)/(totalNum - startNum);
ave_ASD_CC_score = sum(ASD_CC_score,2)/(totalNum - startNum);
ave_ASD_SSIM_score = sum(ASD_SSIM_score,2)/(totalNum - startNum);
ave_ASD_SIM_score = sum(ASD_SIM_score,2)/(totalNum - startNum);
Results = [ave_ASD_AUC_Judd_score ave_ASD_CC_score  ave_ASD_NSS_score ave_ASD_SIM_score ave_ASD_SSIM_score ]
