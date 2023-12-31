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
    eventdata = importdata([path 'Event-Data.tsv']);
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
    if isempty(idx) || idx == 1
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
    scatter([x,x],central_y(k:k+1),15, 'black','filled');
end
hold off;

hold on;
for fix_p=2:length(graph_order)
    start_vert = graph_order(fix_p-1);
    end_vert = graph_order(fix_p);
    start_x = central_x(start_vert); start_y = central_y(start_vert);
    end_x = central_x(end_vert); end_y = central_y(end_vert);
    dx = end_x - start_x;
    dy = end_y - start_y;
    qver = quiver(start_x, start_y, dx, dy,0, 'm', LineWidth=1);
    qver.MaxHeadSize = qver.MaxHeadSize*500/sqrt(dx*dx+dy*dy);
end
hold off;

exportgraphics(gcf,'graph-1.png','Resolution',300)

%%

clear;

experts_list = [1 2 4 5 6];
experts_total_path = [];
experts_avg_degree = [];
experts_visit_point = [];
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

    total_path_list = [];
    visit_point_list = [];
    avg_degree_list = [];
    
    for cnt = 1:150
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
            if isempty(idx) || idx ==1
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
        for j=1:length(cut_line)-1
            k = 2*(j-1)+1;
            x = round((cut_line(j)+cut_line(j+1))/2);
            central_x(k) = x;
            central_x(k+1) = x;
        end
        
        
        % Features of graph
        % Average Degree: average visiting number of each vertix
        % Min path: a path with the minimum length
        % Max path: a path with the maximum length
        % Total path: total length of user's path
        degree = zeros(1,max(graph_order));
        for i=1:length(graph_order)
            degree(graph_order(i)) = degree(graph_order(i)) + 1;
        end
        
        avg_degree = sum(degree) / nnz(degree);
        avg_degree_list(cnt) = avg_degree;
        
        total_path = 0;
        for fix_p=2:length(graph_order)
            start_vert = graph_order(fix_p-1);
            end_vert = graph_order(fix_p);
            start_x = central_x(start_vert); start_y = central_y(start_vert);
            end_x = central_x(end_vert); end_y = central_y(end_vert);
            dx = end_x - start_x; dy = end_y - start_y;
            total_path = total_path + sqrt(dx*dx+dy*dy);
        end
        total_path_list(cnt) = total_path;
        
        graph_unique = unique(graph_order);
        visit_point = length(graph_unique);
        visit_point_list(cnt) = visit_point;
    end

    experts_total_path = [experts_total_path total_path_list];
    experts_avg_degree = [experts_avg_degree avg_degree_list];
    experts_visit_point = [experts_visit_point visit_point_list];
end

clearvars -except experts_total_path experts_avg_degree experts_visit_point;

nexperts_list = [11 12 13 14 15];
nexperts_total_path = [];
nexperts_avg_degree = [];
nexperts_visit_point = [];
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

    total_path_list = [];
    visit_point_list = [];
    avg_degree_list = [];
    
    for cnt = 1:150
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
            if isempty(idx) || idx ==1
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
        for j=1:length(cut_line)-1
            k = 2*(j-1)+1;
            x = round((cut_line(j)+cut_line(j+1))/2);
            central_x(k) = x;
            central_x(k+1) = x;
        end
        
        
        % Features of graph
        % Average Degree: average visiting number of each vertix
        % Min path: a path with the minimum length
        % Max path: a path with the maximum length
        % Total path: total length of user's path
        degree = zeros(1,max(graph_order));
        for i=1:length(graph_order)
            degree(graph_order(i)) = degree(graph_order(i)) + 1;
        end
        
        avg_degree = sum(degree) / nnz(degree);
        avg_degree_list(cnt) = avg_degree;
        
        total_path = 0;
        for fix_p=2:length(graph_order)
            start_vert = graph_order(fix_p-1);
            end_vert = graph_order(fix_p);
            start_x = central_x(start_vert); start_y = central_y(start_vert);
            end_x = central_x(end_vert); end_y = central_y(end_vert);
            dx = end_x - start_x; dy = end_y - start_y;
            total_path = total_path + sqrt(dx*dx+dy*dy);
        end
        total_path_list(cnt) = total_path;
        
        graph_unique = unique(graph_order);
        visit_point = length(graph_unique);
        visit_point_list(cnt) = visit_point;
    end

    nexperts_total_path = [nexperts_total_path total_path_list];
    nexperts_avg_degree = [nexperts_avg_degree avg_degree_list];
    nexperts_visit_point = [nexperts_visit_point visit_point_list];
end