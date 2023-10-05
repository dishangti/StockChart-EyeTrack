clear;
mmmm = 1;
mm = ones(2,150);
% initialize the fixation number matrix
q = ones(1,150);
clear dje finalexp;
m =[1 1];
shunxu=xlsread('../../data/order/showOrder.xlsx');
xfix = [];
yfix = [];

%dicard fixations whose fixation time is smaller than 100ms
filePath = '../../data/simplified/1';
for j=1:3%there are three rounds in ever trial
    path=[filePath '/' num2str(j) '/'];
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

valid_point = 0;
total_point = 0;
for cnt=1:150
    Img=imread(['../../stimuli/simplified_1280x1024/' num2str(shunxu(cnt)) '.png']);
    Img=rgb2gray(Img);
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

    for j=1:length(xfixRevised)
        ox = xfixRevised(j);
        oy = yfixRevised(j);
        found = 0;
        for dx=-17:17
            for dy=-17:17
                if sqrt(dx*dx+dy*dy) > 34
                    continue
                end
                if (1<=ox+dx && ox+dx<=1024 && 1<=oy+dy && oy+dy<=1280 && Img(ox+dx,oy+dy) <= 250)
                    valid_point = valid_point + 1;
                    found = 1;
                    break
                end
            end
            if found
                break
            end
        end
    end
    
    total_point = total_point + length(xfixRevised);
end

valid_rate = valid_point / total_point