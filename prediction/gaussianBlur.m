shunxu= xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\shunxu_finetune.xlsx');
for i=1:30
    FixationPoints =  imread(['E:\research\k_eyetracker\Eye movement_ data\experimental data\saliency map\Sam_vgg\' num2str(shunxu(i)) '.jpg']);
    window = fspecial('gaussian', 36*6, 36);
    window = window/sum(sum(window));
    FixationMapTemp = imfilter(FixationPoints, window, 'conv');
    FixationMap = mat2gray(FixationMapTemp);
    imwrite( FixationMap,['E:\research\k_eyetracker\Eye movement_ data\experimental data\filter\' num2str(shunxu(i)) '.jpg']);
end