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
filePath = '../../data/simplified/11';
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

cnt = 1;
Imgrgb=imread(['../../stimuli/simplified_1280x1024/' num2str(shunxu(cnt)) '.png']);
Img=rgb2gray(Imgrgb);
imshow(Imgrgb,'border','tight','initialmagnification','fit');
set(gcf,'Position', [0,0,1280,1024]);
axis normal;
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

cut_begin = [];         % Vertically fragment the chart
cut_end = [];
n = 1;
is_frag_start = 0;
is_edge_start = 0;
for j=1:length(Img(990, :))
    if (Img(990, j) <= 50 && is_edge_start == 0)
        is_edge_start = 1;
        if (is_frag_start == 0)
            is_frag_start = 1;
            cut_begin(n) = j;
        else
            is_frag_start = 0;
            cut_end(n) = j;
            n = n+1;
        end
    elseif (Img(990, j) >= 75 && is_edge_start == 1)
        is_edge_start = 0;
    end
end

cut_line = zeros(1,length(cut_begin) + 1);
cut_line(1) = cut_begin(1);
cut_line(end) = cut_end(end);
for j=2:length(cut_begin)
    cut_line(j) = round((cut_end(j - 1) + cut_begin(j))/2);
end

hold on;
for j=1:length(cut_line)
    plot([cut_line(j) cut_line(j)], [0, 992], '--', color = '#D95319');
end
plot([cut_line(1), cut_line(end)], [660, 660], '--', color='#D95319')
hold off;

for cntCol=1:length(xfix(cnt,:))
    if (yfix(cnt,cntCol)==0 && xfix(cnt,cntCol)==0)
        break;
    end
    if (yfix(cnt,cntCol)>1024||xfix(cnt,cntCol)>1280||yfix(cnt,cntCol)<=0||xfix(cnt,cntCol)<=0)
        continue;
    end
    xCoor(cntCol) = xfix(cnt,cntCol);
    yCoor(cntCol) = yfix(cnt,cntCol);
end

%{
Numbering rules
* 1 * 3 * 5 * 7 * ...
* 2 * 4 * 6 * 8 * ...
%}
graph_order = [];  % Graph visiting order
graph_num = 0;
for j=1:length(xCoor)
    fx = xCoor(j);
    fy = yCoor(j);

    idx = find(cut_line > fx,1);
    if isempty(idx) || idx==1
        continue
    end
    num = (idx-1) * 2 - 1;
    if (fy > 660)
        num = num + 1;
    end
    graph_num = graph_num + 1;
    graph_order(graph_num) = num;
end

central_y = zeros(1,(length(cut_line)-1)*2);
for j=1:length(cut_line)-1
    %Upper area
    k = 2*(j-1)+1;
    ycnt = 0;
    for x=cut_line(j):cut_line(j+1)
        for y=1:660
            if Img(y,x) ~= 255
                central_y(k) = central_y(k) + y;
                ycnt = ycnt+1;
            end
        end
    end
    central_y(k) = round(central_y(k) / ycnt);

    %Lower area
    k = k + 1;
    ycnt = 0;
    for x=cut_line(j):cut_line(j+1)
        for y=661:1024
            if Img(y,x) ~= 255
                central_y(k) = central_y(k) + y;
                ycnt = ycnt+1;
            end
        end
    end
    central_y(k) = round(central_y(k) / ycnt);
end

central_x = zeros(1,(length(cut_line)-1)*2);
hold on;
for j=1:length(cut_line)-1
    k = 2*(j-1)+1;
    x = round((cut_line(j)+cut_line(j+1))/2);
    central_x(k) = x;
    central_x(k+1) = x;
end
hold off;

bar_start = zeros(1,(length(cut_line)-1)*2);
bar_end = zeros(1,(length(cut_line)-1)*2);
bar_length = zeros(1,(length(cut_line)-1)*2);
for j=1:length(cut_line)-1
    %Upper Area
    k = 2*(j-1) +1;
    bar_start(k) = find(Img(1:660,cut_line(j)+9) ~= 255, 1);
    bar_end(k) = 660+1-find(flip(Img(1:660,cut_line(j)+9)) ~= 255, 1);
    bar_length(k) = bar_end(k) - bar_start(k);

    %Lower Area
    k = k+1;
    bar_start(k) = find(Img(661:1024,cut_line(j)+9) ~= 255, 1) + 660;
    bar_end(k) = 1024+1-find(flip(Img(661:1024,cut_line(j)+9)) ~= 255, 1);
    bar_length(k) = bar_end(k) - bar_start(k);

    %Draw
    hold on;
    scatter([central_x(k), central_x(k)], bar_start(k-1:k), 'green', 'fill')
    scatter([central_x(k), central_x(k)], bar_end(k-1:k), 'magenta', 'fill')
    hold off;
end

exportgraphics(gcf,'bar-1.png','Resolution',300)

%%
candle_bar_length = [];
vol_bar_length = [];
candle_bar_visit = [];
vol_bar_visit = [];
for cnt=1:150
    Imgrgb=imread(['../../stimuli/simplified_1280x1024/' num2str(shunxu(cnt)) '.png']);
    Img=rgb2gray(Imgrgb);
    
    cut_begin = [];         % Vertically fragment the chart
    cut_end = [];
    n = 1;
    is_frag_start = 0;
    is_edge_start = 0;
    for j=1:length(Img(990, :))
        if (Img(990, j) <= 50 && is_edge_start == 0)
            is_edge_start = 1;
            if (is_frag_start == 0)
                is_frag_start = 1;
                cut_begin(n) = j;
            else
                is_frag_start = 0;
                cut_end(n) = j;
                n = n+1;
            end
        elseif (Img(990, j) >= 75 && is_edge_start == 1)
            is_edge_start = 0;
        end
    end
    
    cut_line = zeros(1,length(cut_begin) + 1);
    cut_line(1) = cut_begin(1);
    cut_line(end) = cut_end(end);
    for j=2:length(cut_begin)
        cut_line(j) = round((cut_end(j - 1) + cut_begin(j))/2);
    end
    
    
    for cntCol=1:length(xfix(cnt,:))
        if (yfix(cnt,cntCol)==0 && xfix(cnt,cntCol)==0)
            break;
        end
        if (yfix(cnt,cntCol)>1024||xfix(cnt,cntCol)>1280||yfix(cnt,cntCol)<=0||xfix(cnt,cntCol)<=0)
            continue;
        end
        xCoor(cntCol) = xfix(cnt,cntCol);
        yCoor(cntCol) = yfix(cnt,cntCol);
    end
    
    %{
    Numbering rules
    * 1 * 3 * 5 * 7 * ...
    * 2 * 4 * 6 * 8 * ...
    %}
    
    central_y = zeros(1,(length(cut_line)-1)*2);
    for j=1:length(cut_line)-1
        %Upper area
        k = 2*(j-1)+1;
        ycnt = 0;
        for x=cut_line(j):cut_line(j+1)
            for y=1:660
                if Img(y,x) ~= 255
                    central_y(k) = central_y(k) + y;
                    ycnt = ycnt+1;
                end
            end
        end
        central_y(k) = round(central_y(k) / ycnt);
    
        %Lower area
        k = k + 1;
        ycnt = 0;
        for x=cut_line(j):cut_line(j+1)
            for y=661:1024
                if Img(y,x) ~= 255
                    central_y(k) = central_y(k) + y;
                    ycnt = ycnt+1;
                end
            end
        end
        central_y(k) = round(central_y(k) / ycnt);
    end
    
    central_x = zeros(1,(length(cut_line)-1)*2);
    for j=1:length(cut_line)-1
        k = 2*(j-1)+1;
        x = round((cut_line(j)+cut_line(j+1))/2);
        central_x(k) = x;
        central_x(k+1) = x;
    end
    
    bar_start = zeros(1,(length(cut_line)-1)*2);
    bar_end = zeros(1,(length(cut_line)-1)*2);
    bar_length = zeros(1,(length(cut_line)-1)*2);
    for j=1:length(cut_line)-1
        %Upper Area
        k = 2*(j-1) +1;
        bar_start(k) = find(Img(1:660,cut_line(j)+9) ~= 255, 1);
        bar_end(k) = 660+1-find(flip(Img(1:660,cut_line(j)+9)) ~= 255, 1);
        bar_length(k) = bar_end(k) - bar_start(k);
    
        %Lower Area
        k = k+1;
        bar_start(k) = find(Img(661:1024,cut_line(j)+9) ~= 255, 1) + 660;
        bar_end(k) = 1024+1-find(flip(Img(661:1024,cut_line(j)+9)) ~= 255, 1);
        bar_length(k) = bar_end(k) - bar_start(k);
    end

    candle_bar_length = [candle_bar_length bar_length(1:2:end)];
    vol_bar_length = [vol_bar_length bar_length(2:2:end)];
end

%%
experts_list = [1 2 4 5 6];
experts_candle_tiny = [];
experts_candle_small = [];
experts_candle_middle = [];
experts_candle_large = [];
experts_vol_tiny = [];
experts_vol_small = [];
experts_vol_middle = [];
experts_vol_large = [];

for expert=1:length(experts_list)
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
    filePath = ['../../data/simplified/' num2str(experts_list(expert))];
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
    
    candle_tiny = 0;
    candle_small = 0;
    candle_middle = 0;
    candle_large = 0;
    vol_tiny = 0;
    vol_small = 0;
    vol_middle = 0;
    vol_large = 0;
    for cnt=1:150
        Imgrgb=imread(['../../stimuli/simplified_1280x1024/' num2str(shunxu(cnt)) '.png']);
        Img=rgb2gray(Imgrgb);
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
        
        cut_begin = [];         % Vertically fragment the chart
        cut_end = [];
        n = 1;
        is_frag_start = 0;
        is_edge_start = 0;
        for j=1:length(Img(990, :))
            if (Img(990, j) <= 50 && is_edge_start == 0)
                is_edge_start = 1;
                if (is_frag_start == 0)
                    is_frag_start = 1;
                    cut_begin(n) = j;
                else
                    is_frag_start = 0;
                    cut_end(n) = j;
                    n = n+1;
                end
            elseif (Img(990, j) >= 75 && is_edge_start == 1)
                is_edge_start = 0;
            end
        end
        
        cut_line = zeros(1,length(cut_begin) + 1);
        cut_line(1) = cut_begin(1);
        cut_line(end) = cut_end(end);
        for j=2:length(cut_begin)
            cut_line(j) = round((cut_end(j - 1) + cut_begin(j))/2);
        end
        
        
        for cntCol=1:length(xfix(cnt,:))
            if (yfix(cnt,cntCol)==0 && xfix(cnt,cntCol)==0)
                break;
            end
            if (yfix(cnt,cntCol)>1024||xfix(cnt,cntCol)>1280||yfix(cnt,cntCol)<=0||xfix(cnt,cntCol)<=0)
                continue;
            end
            xCoor(cntCol) = xfix(cnt,cntCol);
            yCoor(cntCol) = yfix(cnt,cntCol);
        end
        
        %{
        Numbering rules
        * 1 * 3 * 5 * 7 * ...
        * 2 * 4 * 6 * 8 * ...
        %}
        graph_order = [];  % Graph visiting order
        graph_num = 0;
        for j=1:length(xCoor)
            fx = xCoor(j);
            fy = yCoor(j);
        
            idx = find(cut_line > fx,1);
            if isempty(idx) || idx==1
                continue
            end
            num = (idx-1) * 2 - 1;
            if (fy > 660)
                num = num + 1;
            end
            graph_num = graph_num + 1;
            graph_order(graph_num) = num;
        end
    
        for vert=1:length(graph_order)
            if mod(graph_order(vert),2) == 0
                bar_len = vol_bar_length(70*(cnt-1)+ceil(graph_order(vert)/2));
                if bar_len <= 73
                    vol_tiny = vol_tiny + 1;
                elseif bar_len <= 107
                    vol_small = vol_small +1;
                elseif bar_len <= 141
                    vol_middle = vol_middle + 1;
                else
                    vol_large = vol_large + 1;
                end
            else
                bar_len = candle_bar_length(70*(cnt-1)+ceil(graph_order(vert)/2));
                if bar_len <= 12
                    candle_tiny = candle_tiny + 1;
                elseif bar_len <= 25
                    candle_small = candle_small +1;
                elseif bar_len <= 45
                    candle_middle = candle_middle + 1;
                else
                    candle_large = candle_large + 1;
                end
            end
        end
    end

    experts_candle_tiny(expert) = candle_tiny;
    experts_candle_small(expert) = candle_small;
    experts_candle_middle(expert) = candle_middle;
    experts_candle_large(expert) = candle_large;
    experts_vol_tiny(expert) = vol_tiny;
    experts_vol_small(expert) = vol_small;
    experts_vol_middle(expert) = vol_middle;
    experts_vol_large(expert) = vol_large;
end

%%
nexperts_list = [11 12 13 14 15];
nexperts_candle_tiny = [];
nexperts_candle_small = [];
nexperts_candle_middle = [];
nexperts_candle_large = [];
nexperts_vol_tiny = [];
nexperts_vol_small = [];
nexperts_vol_middle = [];
nexperts_vol_large = [];

for nexpert=1:length(nexperts_list)
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
    filePath = ['../../data/simplified/' num2str(nexperts_list(nexpert))];
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
    
    candle_tiny = 0;
    candle_small = 0;
    candle_middle = 0;
    candle_large = 0;
    vol_tiny = 0;
    vol_small = 0;
    vol_middle = 0;
    vol_large = 0;
    for cnt=1:150
        Imgrgb=imread(['../../stimuli/simplified_1280x1024/' num2str(shunxu(cnt)) '.png']);
        Img=rgb2gray(Imgrgb);
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
        
        cut_begin = [];         % Vertically fragment the chart
        cut_end = [];
        n = 1;
        is_frag_start = 0;
        is_edge_start = 0;
        for j=1:length(Img(990, :))
            if (Img(990, j) <= 50 && is_edge_start == 0)
                is_edge_start = 1;
                if (is_frag_start == 0)
                    is_frag_start = 1;
                    cut_begin(n) = j;
                else
                    is_frag_start = 0;
                    cut_end(n) = j;
                    n = n+1;
                end
            elseif (Img(990, j) >= 75 && is_edge_start == 1)
                is_edge_start = 0;
            end
        end
        
        cut_line = zeros(1,length(cut_begin) + 1);
        cut_line(1) = cut_begin(1);
        cut_line(end) = cut_end(end);
        for j=2:length(cut_begin)
            cut_line(j) = round((cut_end(j - 1) + cut_begin(j))/2);
        end
        
        
        for cntCol=1:length(xfix(cnt,:))
            if (yfix(cnt,cntCol)==0 && xfix(cnt,cntCol)==0)
                break;
            end
            if (yfix(cnt,cntCol)>1024||xfix(cnt,cntCol)>1280||yfix(cnt,cntCol)<=0||xfix(cnt,cntCol)<=0)
                continue;
            end
            xCoor(cntCol) = xfix(cnt,cntCol);
            yCoor(cntCol) = yfix(cnt,cntCol);
        end
        
        %{
        Numbering rules
        * 1 * 3 * 5 * 7 * ...
        * 2 * 4 * 6 * 8 * ...
        %}
        graph_order = [];  % Graph visiting order
        graph_num = 0;
        for j=1:length(xCoor)
            fx = xCoor(j);
            fy = yCoor(j);
        
            idx = find(cut_line > fx,1);
            if isempty(idx) || idx==1
                continue
            end
            num = (idx-1) * 2 - 1;
            if (fy > 660)
                num = num + 1;
            end
            graph_num = graph_num + 1;
            graph_order(graph_num) = num;
        end
    
        for vert=1:length(graph_order)
            if mod(graph_order(vert),2) == 0
                bar_len = vol_bar_length(70*(cnt-1)+ceil(graph_order(vert)/2));
                if bar_len <= 73
                    vol_tiny = vol_tiny + 1;
                elseif bar_len <= 107
                    vol_small = vol_small +1;
                elseif bar_len <= 141
                    vol_middle = vol_middle + 1;
                else
                    vol_large = vol_large + 1;
                end
            else
                bar_len = candle_bar_length(70*(cnt-1)+ceil(graph_order(vert)/2));
                if bar_len <= 12
                    candle_tiny = candle_tiny + 1;
                elseif bar_len <= 25
                    candle_small = candle_small +1;
                elseif bar_len <= 45
                    candle_middle = candle_middle + 1;
                else
                    candle_large = candle_large + 1;
                end
            end
        end
    end

    nexperts_candle_tiny(nexpert) = candle_tiny;
    nexperts_candle_small(nexpert) = candle_small;
    nexperts_candle_middle(nexpert) = candle_middle;
    nexperts_candle_large(nexpert) = candle_large;
    nexperts_vol_tiny(nexpert) = vol_tiny;
    nexperts_vol_small(nexpert) = vol_small;
    nexperts_vol_middle(nexpert) = vol_middle;
    nexperts_vol_large(nexpert) = vol_large;
end