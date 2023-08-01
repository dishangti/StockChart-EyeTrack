
%批量将图片下采样 
shunxu= xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\shunxu_finetune.xlsx');
 for i=1:30  
     Img_orig = imread(['E:\research\k_eyetracker\Eye movement_ data\experimental data\fixmaps\0_1280x1024\' num2str(shunxu(i)) '.jpg']);
     Img_revise=imresize(Img_orig,0.5);
     imwrite(Img_revise,['E:\research\k_eyetracker\Eye movement_ data\experimental data\fixmaps\' num2str(0) '\' num2str(shunxu(i)) '.jpg']);
 end