%%get four metrics
clear;
mmmm = 1;
mm = ones(2,150);
clear dje finalexp;
m =[1 1];
% shunxu=xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\upDownOrder\downOrder.xlsx');
% xfix = struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[],'p11',[],'p12',[],'p13',[],'p14',[],'p15',[]);
% yfix = struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[],'p11',[],'p12',[],'p13',[],'p14',[],'p15',[]);
q = struct('p1',ones(1,150),'p2',ones(1,150),'p3',ones(1,150),'p4',ones(1,150),'p5',ones(1,150),'p6',ones(1,150),'p7',ones(1,150),'p8',ones(1,150),'p9',ones(1,150),'p10',ones(1,150),'p11',ones(1,150),'p12',ones(1,150),'p13',ones(1,150),'p14',ones(1,150),'p15',ones(1,150));
for i=1:15%测试的人数序号,前1-10为专家  11-15为非专家
    for j=1:3%每一个人测试有三轮实验数据
        path=['E:\research\k_eyetracker\Eye movement_ data\experimental data\eye movement'  '\' num2str(i) '\' num2str(j) '\'];
        files = dir(path);
        eventdata = importdata([path 'Event-Data.tsv' ]);
        fixdata = importdata([path 'Fixation-Data.tsv']);
        %nadao event shijian
        ii = 1;                                                                                                                                                                                  ;
        for k =14 : 263%excel中的event事件中有用行数
            %for k=14:263(1-4)
            wz = strfind(eventdata{k},'I');
            if isempty(wz)==1
                continue;
            end
            event(ii) = str2num(eventdata{k}(1:wz(1)-2));
            ii = ii+1;
        end
        %qu qujian lide zhi baocun
        
        for iii = 1:length(fixdata.data)
            for ja = 1:50%每一轮实验是50张图
                if i==1
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        %取到的是event中的ImageStart-ImageEnd 里的数据
                        %每一个点的注视点的间隔
                        finalexp.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,3);
                        %记录x的坐标
                        xfix.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,4);
                        %记录y的坐标
                        yfix.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,5);
                        %%表示每一张图片看的点数多少
                        q.p1((j-1)*50+ja) = q.p1((j-1)*50+ja)+1;
                    end
                elseif i==2
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p2((j-1)*50+ja,q.p2((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p2((j-1)*50+ja,q.p2((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p2((j-1)*50+ja,q.p2((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p2((j-1)*50+ja) = q.p2((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==3
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p3((j-1)*50+ja,q.p3((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p3((j-1)*50+ja,q.p3((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p3((j-1)*50+ja,q.p3((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p3((j-1)*50+ja) = q.p3((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==4
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p4((j-1)*50+ja,q.p4((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p4((j-1)*50+ja,q.p4((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p4((j-1)*50+ja,q.p4((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p4((j-1)*50+ja) = q.p4((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==5
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p5((j-1)*50+ja,q.p5((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p5((j-1)*50+ja,q.p5((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p5((j-1)*50+ja,q.p5((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p5((j-1)*50+ja) = q.p5((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==6
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p6((j-1)*50+ja,q.p6((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p6((j-1)*50+ja,q.p6((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p6((j-1)*50+ja,q.p6((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p6((j-1)*50+ja) = q.p6((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==7
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p7((j-1)*50+ja,q.p7((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p7((j-1)*50+ja,q.p7((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p7((j-1)*50+ja,q.p7((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p7((j-1)*50+ja) = q.p7((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==8
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p8((j-1)*50+ja,q.p8((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p8((j-1)*50+ja,q.p8((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p8((j-1)*50+ja,q.p8((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p8((j-1)*50+ja) = q.p8((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==9
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p9((j-1)*50+ja,q.p9((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p9((j-1)*50+ja,q.p9((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p9((j-1)*50+ja,q.p9((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p9((j-1)*50+ja) = q.p9((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==10
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p10((j-1)*50+ja) = q.p10((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==11
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        finalexp.p11((j-1)*50+ja,q.p11((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p11((j-1)*50+ja,q.p11((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p11((j-1)*50+ja,q.p11((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p11((j-1)*50+ja) = q.p11((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==12
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p12((j-1)*50+ja,q.p12((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p12((j-1)*50+ja,q.p12((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p12((j-1)*50+ja,q.p12((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p12((j-1)*50+ja) = q.p12((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==13
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p13((j-1)*50+ja,q.p13((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p13((j-1)*50+ja,q.p13((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p13((j-1)*50+ja,q.p13((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p13((j-1)*50+ja) = q.p13((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==14
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p14((j-1)*50+ja,q.p14((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p14((j-1)*50+ja,q.p14((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p14((j-1)*50+ja,q.p14((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p14((j-1)*50+ja) = q.p14((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                elseif i==15
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p15((j-1)*50+ja,q.p15((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p15((j-1)*50+ja,q.p15((j-1)*50+ja)) = fixdata.data(iii,4);
                        yfix.p15((j-1)*50+ja,q.p15((j-1)*50+ja)) = fixdata.data(iii,5);
                        q.p15((j-1)*50+ja) = q.p15((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
                    end
                end
            end
        end
    end
end
%跌  shunxu=xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\upDownOrder\downOrder.xlsx');
%涨  shunxu=xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\upDownOrder\upOrder.xlsx');
shunxu=xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\upDownOrder\upOrder.xlsx');
%%restart
qHandle = struct('p1',ones(1,length(shunxu)),'p2',ones(1,length(shunxu)),'p3',ones(1,length(shunxu)),'p4',ones(1,length(shunxu)),'p5',ones(1,length(shunxu)),'p6',ones(1,length(shunxu)),'p7',ones(1,length(shunxu)),'p8',ones(1,length(shunxu)),'p9',ones(1,length(shunxu)),'p10',ones(1,length(shunxu)),'p11',ones(1,length(shunxu)),'p12',ones(1,length(shunxu)),'p13',ones(1,length(shunxu)),'p14',ones(1,length(shunxu)),'p15',ones(1,length(shunxu)));

%%指标一：注视点的持续时间 stareTime
%直接在finalexp中进行查看，p1-p15中对于每张图的注视时间
%计算10位专家和5位非专家的数据
%%% 参考计算实现二维数组中计算非零元素的平均值 最大值 最小值
% mean(AA(AA~=0))
% max(AA(AA~=0))
% min(AA(AA~=0))
%%指标二：注视点持续时间总和 stareTimeTotal
%%直接在finalexp中进行查看，p1-p15中对于每张图的注视时间后求和

%%指标五：每一张图注视点个数 starePoints
%在结构体q中的15个分支中也可以得到每一个被试者的每张图的注视点个数

%%指标三：注视点总个数统计 starePointsTotal
%在结构体q中的15个分支中也可以得到每一个被试者的每张图的注视点个数

%%指标四：首次注视时间   firstStareTime
%%在finalexp中的每一个结构体p1 p2...p15的第一列
for fixIndex=1:15
    if fixIndex==1
        for order = 1:length(shunxu)
            finalexpHandle.p1(order,:) = finalexp.p1(shunxu(order),:);
            qHandle.p1(order) = q.p1(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p1(finalexpHandle.p1~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p1(finalexpHandle.p1~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p1(finalexpHandle.p1~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p1(finalexpHandle.p1~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p1);
        maxstarePoints(fixIndex) = max(qHandle.p1);
        minstarePoints(fixIndex) = min(qHandle.p1);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p1);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p1(:,1));
    elseif fixIndex==2
        for order = 1:length(shunxu)
            finalexpHandle.p2(order,:) = finalexp.p2(shunxu(order),:);
            qHandle.p2(order) = q.p2(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p2(finalexpHandle.p2~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p2(finalexpHandle.p2~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p2(finalexpHandle.p2~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p2(finalexpHandle.p2~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p2);
        maxstarePoints(fixIndex) = max(qHandle.p2);
        minstarePoints(fixIndex) = min(qHandle.p2);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p2);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p2(:,1));
        elseif fixIndex==3
        for order = 1:length(shunxu)
            finalexpHandle.p3(order,:) = finalexp.p3(shunxu(order),:);
            qHandle.p3(order) = q.p3(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p3(finalexpHandle.p3~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p3(finalexpHandle.p3~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p3(finalexpHandle.p3~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p3(finalexpHandle.p3~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p3);
        maxstarePoints(fixIndex) = max(qHandle.p3);
        minstarePoints(fixIndex) = min(qHandle.p3);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p3);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p3(:,1));
        elseif fixIndex==4
        for order = 1:length(shunxu)
            finalexpHandle.p4(order,:) = finalexp.p4(shunxu(order),:);
            qHandle.p4(order) = q.p4(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p4(finalexpHandle.p4~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p4(finalexpHandle.p4~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p4(finalexpHandle.p4~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p4(finalexpHandle.p4~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p4);
        maxstarePoints(fixIndex) = max(qHandle.p4);
        minstarePoints(fixIndex) = min(qHandle.p4);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p4);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p4(:,1));
        elseif fixIndex==5
        for order = 1:length(shunxu)
            finalexpHandle.p5(order,:) = finalexp.p5(shunxu(order),:);
            qHandle.p5(order) = q.p5(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p5(finalexpHandle.p5~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p5(finalexpHandle.p5~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p5(finalexpHandle.p5~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p5(finalexpHandle.p5~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p5);
        maxstarePoints(fixIndex) = max(qHandle.p5);
        minstarePoints(fixIndex) = min(qHandle.p5);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p5);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p5(:,1));
        elseif fixIndex==6
        for order = 1:length(shunxu)
            finalexpHandle.p6(order,:) = finalexp.p6(shunxu(order),:);
            qHandle.p6(order) = q.p6(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p6(finalexpHandle.p6~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p6(finalexpHandle.p6~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p6(finalexpHandle.p6~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p6(finalexpHandle.p6~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p6);
        maxstarePoints(fixIndex) = max(qHandle.p6);
        minstarePoints(fixIndex) = min(qHandle.p6);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p6);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p6(:,1));
        elseif fixIndex==7
        for order = 1:length(shunxu)
            finalexpHandle.p7(order,:) = finalexp.p7(shunxu(order),:);
            qHandle.p7(order) = q.p7(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p7(finalexpHandle.p7~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p7(finalexpHandle.p7~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p7(finalexpHandle.p7~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p7(finalexpHandle.p7~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p7);
        maxstarePoints(fixIndex) = max(qHandle.p7);
        minstarePoints(fixIndex) = min(qHandle.p7);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p7);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p7(:,1));
        elseif fixIndex==8
        for order = 1:length(shunxu)
            finalexpHandle.p8(order,:) = finalexp.p8(shunxu(order),:);
            qHandle.p8(order) = q.p8(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p8(finalexpHandle.p8~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p8(finalexpHandle.p8~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p8(finalexpHandle.p8~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p8(finalexpHandle.p8~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p8);
        maxstarePoints(fixIndex) = max(qHandle.p8);
        minstarePoints(fixIndex) = min(qHandle.p8);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p8);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p8(:,1));
        elseif fixIndex==9
        for order = 1:length(shunxu)
            finalexpHandle.p9(order,:) = finalexp.p9(shunxu(order),:);
            qHandle.p9(order) = q.p9(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p9(finalexpHandle.p9~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p9(finalexpHandle.p9~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p9(finalexpHandle.p9~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p9(finalexpHandle.p9~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p9);
        maxstarePoints(fixIndex) = max(qHandle.p9);
        minstarePoints(fixIndex) = min(qHandle.p9);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p9);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p9(:,1));
        elseif fixIndex==10
        for order = 1:length(shunxu)
            finalexpHandle.p10(order,:) = finalexp.p10(shunxu(order),:);
            qHandle.p10(order) = q.p10(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p10(finalexpHandle.p10~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p10(finalexpHandle.p10~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p10(finalexpHandle.p10~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p10(finalexpHandle.p10~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p10);
        maxstarePoints(fixIndex) = max(qHandle.p10);
        minstarePoints(fixIndex) = min(qHandle.p10);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p10);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p10(:,1));
        elseif fixIndex==11
        for order = 1:length(shunxu)
            finalexpHandle.p11(order,:) = finalexp.p11(shunxu(order),:);
            qHandle.p11(order) = q.p11(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p11(finalexpHandle.p11~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p11(finalexpHandle.p11~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p11(finalexpHandle.p11~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p11(finalexpHandle.p11~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p11);
        maxstarePoints(fixIndex) = max(qHandle.p11);
        minstarePoints(fixIndex) = min(qHandle.p11);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p11);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p11(:,1));
        elseif fixIndex==12
        for order = 1:length(shunxu)
            finalexpHandle.p12(order,:) = finalexp.p12(shunxu(order),:);
            qHandle.p12(order) = q.p12(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p12(finalexpHandle.p12~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p12(finalexpHandle.p12~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p12(finalexpHandle.p12~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p12(finalexpHandle.p12~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p12);
        maxstarePoints(fixIndex) = max(qHandle.p12);
        minstarePoints(fixIndex) = min(qHandle.p12);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p12);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p12(:,1));
        elseif fixIndex==13
        for order = 1:length(shunxu)
            finalexpHandle.p13(order,:) = finalexp.p13(shunxu(order),:);
            qHandle.p13(order) = q.p13(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p13(finalexpHandle.p13~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p13(finalexpHandle.p13~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p13(finalexpHandle.p13~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p13(finalexpHandle.p13~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p13);
        maxstarePoints(fixIndex) = max(qHandle.p13);
        minstarePoints(fixIndex) = min(qHandle.p13);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p13);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p13(:,1));
        elseif fixIndex==14
        for order = 1:length(shunxu)
            finalexpHandle.p14(order,:) = finalexp.p14(shunxu(order),:);
            qHandle.p14(order) = q.p14(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p14(finalexpHandle.p14~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p14(finalexpHandle.p14~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p14(finalexpHandle.p14~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p14(finalexpHandle.p14~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p14);
        maxstarePoints(fixIndex) = max(qHandle.p14);
        minstarePoints(fixIndex) = min(qHandle.p14);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p14);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p14(:,1));
        elseif fixIndex==15
        for order = 1:length(shunxu)
            finalexpHandle.p15(order,:) = finalexp.p15(shunxu(order),:);
            qHandle.p15(order) = q.p15(shunxu(order));
        end
        %%指标一
        stareTime(fixIndex) = mean(finalexpHandle.p15(finalexpHandle.p15~=0));
        maxstareTime(fixIndex) = max(finalexpHandle.p15(finalexpHandle.p15~=0));
        minstareTime(fixIndex) = min(finalexpHandle.p15(finalexpHandle.p15~=0));
        %%指标二
        stareTimeTotal(fixIndex) = sum(finalexpHandle.p15(finalexpHandle.p15~=0));
        %%指标五
        starePoints(fixIndex) = mean(qHandle.p15);
        maxstarePoints(fixIndex) = max(qHandle.p15);
        minstarePoints(fixIndex) = min(qHandle.p15);
        %%%指标三
        starePointsTotal(fixIndex) = sum(qHandle.p15);
        %%指标四
        firstStareTime(fixIndex) = mean(finalexpHandle.p15(:,1));
    end
end
