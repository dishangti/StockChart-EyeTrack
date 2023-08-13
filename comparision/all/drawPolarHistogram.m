clear;
mmmm = 1;
mm = ones(2,150);
% initialize the fixation number matrix
q = ones(1,150);
clear dje finalexp;
m =[1 1];
shunxu=xlsread('G:\k_eyetracker\Eye movement_ data\dataset\shunxu.xlsx');
xfix = [];
yfix = [];

%dicard fixations whose fixation time is smaller than 100ms
filePath = 'G:\k_eyetracker\Eye movement_ data\experimental data\eye movement\1';
for j=1:3%there are three rounds in ever trial
    path=[filePath '\' num2str(j) '\'];
    files = dir(path);
    eventdata = importdata([path 'Event-Data.tsv' ]);
    fixdata = importdata([path 'Fixation-Data.tsv']);
    %get the timestamp named "I" in Event-Data.tsv
    ii = 1;                                                                                                                                                                                  ;
    for k =14 : 263
        wz = strfind(eventdata{k},'I');
        %judge whether the wz is empty
        if isempty(wz)==1
            continue;
        end
        event(ii) = str2num(eventdata{k}(1:wz(1)-2));
        ii = ii+1;
    end
    %get the fixation coordinates corresponding to the evevt timestamp
    for iii = 1:length(fixdata.data)
        %there are 50 pictures in every round
        for ja = 1:50
            %get the fixation coordinates betweent the event ImageStart to
            %ImageEnd and dicard the fixations whose fixation time is
            %smaller than 100ms
            if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                %record the fixation time
                finalexp((j-1)*50+ja,q((j-1)*50+ja)) = fixdata.data(iii,3);
                %record the x coordinate
                xfix((j-1)*50+ja,q((j-1)*50+ja)) = fixdata.data(iii,4);
                %record the y coordinate
                yfix((j-1)*50+ja,q((j-1)*50+ja)) = fixdata.data(iii,5);
                %record the fixation number in every picture
                q((j-1)*50+ja) = q((j-1)*50+ja)+1;
            end
        end
    end
end

%draw the f ixation track

for cnt=1:150
    Img=imread(['G:\k_eyetracker\Eye movement_ data\dataset\png\1280x1024png\' num2str(shunxu(cnt)) '.png']);
    %imshow(img);
    %FixationPoints = zeros(1024,1280);
    xfixRevised=[];
    yfixRevised=[];
    for j=1:length(xfix(cnt,:))
        if (yfix(cnt,j)==0&&xfix(cnt,j)==0)
            break;
        end
        if (yfix(cnt,j)>1024||xfix(cnt,j)>1280||yfix(cnt,j)<=0||xfix(cnt,j)<=0)
            continue;
        end
        %  FixationPoints(yfix(cnt,j),xfix(cnt,j))=1
        xfixRevised(j) = xfix(cnt,j);
        yfixRevised(j) = yfix(cnt,j);
    end
    if(cnt == 50 || cnt == 100 || cnt == 150)
        figure(cnt);
        imshow(Img);
        hold on;
        %         track = plot(xfixRevised,yfixRevised,'b>-');
        c = linspace(1,10,length(xfixRevised));
        scatter(xfixRevised,yfixRevised,25,c,'filled');
        %         imwrite(track,['E:\research\k_eyetracker\Eye movement_ data\experimental data\png\' num2str(shunxu(cnt)) '.png']);
        hold off;
        %         close(figure(cnt));
    end
end

%%

%%calculate the ¦È and draw the PolarHistogram
theta = [];
thetaReverse  = [];
countTT = 0;
for cntRow =1:150
    for cntCol=1:length(xfix(cntRow,:))
        if (yfix(cntRow,cntCol)==0 && xfix(cntRow,cntCol)==0)
            break;
        end
        if (yfix(cntRow,cntCol)>1024||xfix(cntRow,cntCol)>1280||yfix(cntRow,cntCol)<=0||xfix(cntRow,cntCol)<=0)
            continue;
        end
        xCoor(cntCol) = xfix(cntRow,cntCol);
        yCoor(cntCol) = yfix(cntRow,cntCol);
    end
    for cntCN=2:(length(xCoor)-1)
        %use artan2 method
        ve01  = [xCoor(cntCN)-xCoor(cntCN-1),yCoor(cntCN)-yCoor(cntCN-1)];
        ve02 = [xCoor(cntCN+1)-xCoor(cntCN), yCoor(cntCN+1)-yCoor(cntCN)];
        ve01Dotve02 = ve01(1)*ve02(1)+ ve01(2)*ve02(2);
        ve01Crossve02 = ve01(1)*ve02(2) - ve01(2)*ve02(1);
        thetaTemp(cntCN-1) = mod(atan2(ve01Crossve02, ve01Dotve02),2*pi);
        
        % use atan method
        %         thetaTemp(cntCN-1) = (atan((yCoor(cntCN+1)-yCoor(cntCN))/(xCoor(cntCN+1)-xCoor(cntCN)))-atan((yCoor(cntCN)-yCoor(cntCN)-1))/(xCoor(cntCN)-xCoor(cntCN-1)));
        if(thetaTemp(cntCN-1)<(13/12*pi) && thetaTemp(cntCN-1)>(11/12*pi))
            countTT =countTT+1;
            thetaReverse = [thetaReverse thetaTemp(cntCN -1)];
        end
    end
    theta = [theta thetaTemp];
    %%draw theta polar histogram
    %%reference to https://ww2.mathworks.cn/help/matlab/ref/polarhistogram.html
    p = polarhistogram(theta,24);
    %     title('Polarhistogram');
    p.FaceColor = [0 0 0];
    p.FaceAlpha = 0.1;
    p.EdgeColor = 'black';
    p.EdgeAlpha = 0.45;
    p.Tag = 'Expert';
    pax = gca;
    thetaticks(0:30:360);
    thetatickformat('degrees');
    %  pax.FontWeight = 'bold';
    pax.FontSize = 12;
    pax.ThetaColor = 'black';
    pax.RMinorGrid = 'on';
    pax.RColor = [0 0 0.5];
    pax.GridColor = [1 0 1];
    
    hold on;
    pp = polarhistogram(thetaReverse,2);
    pp.FaceAlpha = 0.3;
    pp.EdgeColor = 'red';
    pp.BinEdges = [11/12*pi pi 13/12*pi];
    
    hold off;
end
SRR = (countTT/length(theta))
