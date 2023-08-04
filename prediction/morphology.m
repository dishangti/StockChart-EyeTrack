shunxu= xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\shunxu_finetune.xlsx');
for i=1:30
    FixationPoints =  imread(['E:\research\k_eyetracker\Eye movement_ data\experimental data\saliency map\Sam-Vgg\' num2str(shunxu(i)) '.jpg']);
    elem = strel("square",10);
    eroded = imerode(FixationPoints, elem)
    imwrite(eroded,['E:\research\k_eyetracker\Eye movement_ data\experimental data\Sam_vgg\' num2str(shunxu(i)) '.jpg']);
end