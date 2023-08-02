% -------------------------------------------------------------------------
% This code is used to read the data from the text file,
% and generate the saliency map, heat map for ASD children and TD children.
% Eye tracker: Tobii T120 17 inch
% -------------------------------------------------------------------------
clc
clear all
order = xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\orderThirdStage.xlsx');
%存放眼动数据的路径
PathASDFirst = 'E:\research\k_eyetracker\Eye movement_ data\experimental data\eyeMovementTwo';
%存放刺激材料的路径
PathImage = 'E:\research\k_eyetracker\Eye movement_ data\dataset\thirdStage\datasetOne\';
%存放实验结果的路径
PathFixPtsASD = 'E:\research\k_eyetracker\Eye movement_ data\dataHandleTwo\result\FixPts\';
PathFixMapsASD = 'E:\research\k_eyetracker\Eye movement_ data\dataHandleTwo\result\FixMaps\';
PathHeatMapsASD = 'E:\research\k_eyetracker\Eye movement_ data\dataHandleTwo\result\HeatMaps\';
%存放图片名字的数组
FilesNameOrder=[];
X_ASD= struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[]);
Y_ASD = struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[]);
%获取该文件夹中所有png格式的图像
Files = dir(strcat(PathImage,'*.png'));
%获取文件中所有图片的名称数字部分，并存放到FilesNameOrder数组
for i = 1:length(Files)
    filename = Files(i).name;
    filename(end-3:end) = [];
    filenmeOrder = str2num(filename);
    FilesNameOrder = [FilesNameOrder filenmeOrder];
end
FilesNameOrder = FilesNameOrder';

for particient = 1:10
    for round= 1:3
        %刺激材料路径下的所有材料
        PathASD=[PathASDFirst '\' num2str(particient) '\' num2str(round) '\'];
        for cnt = 1:50
            %读取眼动数据
            DataASD = importdata([PathASD,'data',num2str(cnt),'.txt']);
            dataASD = DataASD;
            %如果眼动数据为空，则不为该张图生成热力图等
            if(isempty(dataASD))
                continue;
            end
            x = dataASD(:,1)';
            y = dataASD(:,2)';
            %% ASD
            % fixation map initialization
            if(particient == 1)
                X_ASD.p1(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p1(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 2)
                X_ASD.p2(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p2(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 3)
                X_ASD.p3(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p3(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 4)
                X_ASD.p4(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p4(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 5)
                X_ASD.p5(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p5(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 6)
                X_ASD.p6(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p6(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 7)
                X_ASD.p7(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p7(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 8)
                X_ASD.p8(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p8(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 9)
                X_ASD.p9(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p9(cnt+50*(round-1),1:size(y,2)) = y;
            end
            if(particient == 10)
                X_ASD.p10(cnt+50*(round-1),1:size(x,2)) = x;
                Y_ASD.p10(cnt+50*(round-1),1:size(y,2)) = y;
            end
        end
    end
end

xfix_all=[X_ASD.p1,X_ASD.p2,X_ASD.p3,X_ASD.p4,X_ASD.p5,X_ASD.p6,X_ASD.p7,X_ASD.p8,X_ASD.p9,X_ASD.p10];
yfix_all=[Y_ASD.p1,Y_ASD.p2,Y_ASD.p3,Y_ASD.p4,Y_ASD.p5,Y_ASD.p6,Y_ASD.p7,Y_ASD.p8,Y_ASD.p9,Y_ASD.p10];

for index= 1:150
    %找到每一个眼动数据的txt文件所对应的刺激材料图片中的编号
    index1 = find(FilesNameOrder==order(index));
    FileName = Files(index1).name;
    FileName(end-3:end) = [];
    Img = imread([PathImage,FileName,'.png']);
    [ImgRow,ImgCol,~] = size(Img);
    FixationPoints = zeros(ImgRow,ImgCol);
    for j=1:size(xfix_all(index,:),2)
        yy=max(min(floor((yfix_all(index,j))*2160),2160),1);
        xx=max(min(floor((xfix_all(index,j))*3840),3840),1);
        FixationPoints(yy,xx)=1;
    end
    
    % write fixation points
    imwrite(FixationPoints,[PathFixPtsASD,FileName,'.png']);
    
    % write fixation map
    window = fspecial('gaussian', 36*6, 36);
    % window = fspecial('gaussian')
    window = window/sum(sum(window));
    FixationMapTemp = imfilter(FixationPoints, window, 'conv');
    FixationMap = mat2gray(FixationMapTemp);
    imwrite(FixationMap,[PathFixMapsASD,FileName,'.png']);
    
    
    %heat map
    figure(index)
    imshow(Img)
    hold on
    [meshX, meshY] = meshgrid(1:ImgCol, 1:ImgRow);
    HeatMap=pcolor(meshX,meshY,FixationMap);
    colorbar;
    shading interp
    alpha(0.4)
    % imwrite(HeatMap,[PathFixMapsASD,FileName,'_h.png']);
    saveas(HeatMap,[PathHeatMapsASD,FileName,'.png']);
    hold off
    close(figure(index));
    clf;
end