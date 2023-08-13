clear;
mmmm = 1;
mm = ones(2,150);
% initialize the fixation number matrix
q = ones(1,150);
clear dje finalexp;
m =[1 1];
shunxu=xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\shunxu.xlsx');
xfix = [];
yfix = [];

%%dicard fixations whose fixation time is smaller than 100ms
filePath = 'E:\research\k_eyetracker\Eye movement_ data\experimental data\eye movement\1';
for j=1:3%there are three rounds in ever trial
    path=[filePath '\' num2str(j) '\'];
    files = dir(path);
    eventdata = importdata([path 'Event-Data.tsv' ]);
    fixdata = importdata([path 'Fixation-Data.tsv']);
    %get the timestamp named "I" in Event-Data.tsv
    ii = 1;                                                                                                                                                                                  ;
    for k =14 : 263
        wz = strfind(eventdata{k},'I');
        % judge whether the wz is empty
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
            if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
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

%%draw scatter diagram
xfixRevised = [];
yfixRevised = [];
xCoorHan=[];
yCoorHan=[];

for  cntRow =1:length(xfix)
    xCoor = [];
    yCoor = [];
    %%delete the x=0 && y=0 coordinates
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
    for cntCN=2:(length(xCoor))
        xCoorHan(cntCN-1) =xCoor(cntCN)-xCoor(cntCN-1);
        yCoorHan(cntCN-1) =yCoor(cntCN)-yCoor(cntCN-1);
    end
    xfixRevised = [xfixRevised xCoorHan];
    yfixRevised = [yfixRevised yCoorHan];
end
%% draw scatter diagram and 
%prepare to regress
x=xfixRevised';
y=yfixRevised';
%%SA
for saIndex = 1:length(x)
     sa(saIndex) =sqrt(x(saIndex)^2+y(saIndex)^2);
end
mean(sa)
%%regression
X=[x.^2,y.^2,x.*y,x,y];
Y=ones(size(x));
L=regress(Y, X); % Y=X*B B为回归系数
fimplicit(@(x,y) L(1).*x.^2+L(2).*y.^2+L(3).*x.*y+L(4).*x+L(5).*y-1,[min(x) max(x) min(y) max(y)],'--b','LineWidth',2);
hold on
%
c = linspace(1,10,length(x));
s = scatter(x,y,25,c,'filled');
hold off
%BCEA
area =  find_ellipse_area([L(1) L(3) L(2) L(4) L(5) -1])
% area =  find_ellipse_area([1 0 1 0 0 -1])
% L = scatter(xfixRevised,yfixRevised);
% disp(L)