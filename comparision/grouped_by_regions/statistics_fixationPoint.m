%%get four metrics
clear;
mmmm = 1;
mm = ones(2,150);
q = ones(1,150);
clear dje finalexp;
m =[1 1];
shunxu=xlsread('../../data/order/showOrder.xlsx');
xfix = struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[],'p11',[],'p12',[],'p13',[],'p14',[],'p15',[]);
yfix = struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[],'p11',[],'p12',[],'p13',[],'p14',[],'p15',[]);
q = struct('p1',ones(1,150),'p2',ones(1,150),'p3',ones(1,150),'p4',ones(1,150),'p5',ones(1,150),'p6',ones(1,150),'p7',ones(1,150),'p8',ones(1,150),'p9',ones(1,150),'p10',ones(1,150),'p11',ones(1,150),'p12',ones(1,150),'p13',ones(1,150),'p14',ones(1,150),'p15',ones(1,150));
for i=1:15%���Ե��������,ǰ1-10Ϊר��  11-15Ϊ��ר��
    for j=1:3%ÿһ���˲���������ʵ������
        path=['../../data/simplified'  '/' num2str(i) '/' num2str(j) '/'];
        files = dir(path);
        eventdata = importdata([path 'Event-Data.tsv' ]);
        fixdata = importdata([path 'Fixation-Data.tsv']);
        %nadao event shijian
        ii = 1;             
        for k =14 : 263%excel�е�event�¼�����������
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
            for ja = 1:50%ÿһ��ʵ����50��ͼ
            % 660 is the region dividing line, where '> 660' is for volume
            % and '< 660 is for candlestick
                if i==1
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        %ȡ������event�е�ImageStart-ImageEnd �������
                        %ÿһ�����ע�ӵ�ļ��
                        finalexp.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,3);
                        %��¼x������
                        xfix.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,4);
                        %��¼y������
                        yfix.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,5);
                       
                        %%��ʾÿһ��ͼƬ���ĵ�������
                        q.p1((j-1)*50+ja) = q.p1((j-1)*50+ja)+1;
                    end
                elseif i==2
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p2((j-1)*50+ja,q.p2((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p2((j-1)*50+ja,q.p2((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p2((j-1)*50+ja,q.p2((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p2((j-1)*50+ja) = q.p2((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==3
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p3((j-1)*50+ja,q.p3((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p3((j-1)*50+ja,q.p3((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p3((j-1)*50+ja,q.p3((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p3((j-1)*50+ja) = q.p3((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==4
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p4((j-1)*50+ja,q.p4((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p4((j-1)*50+ja,q.p4((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p4((j-1)*50+ja,q.p4((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p4((j-1)*50+ja) = q.p4((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==5
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p5((j-1)*50+ja,q.p5((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p5((j-1)*50+ja,q.p5((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p5((j-1)*50+ja,q.p5((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p5((j-1)*50+ja) = q.p5((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==6
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p6((j-1)*50+ja,q.p6((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p6((j-1)*50+ja,q.p6((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p6((j-1)*50+ja,q.p6((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p6((j-1)*50+ja) = q.p6((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==7
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p7((j-1)*50+ja,q.p7((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p7((j-1)*50+ja,q.p7((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p7((j-1)*50+ja,q.p7((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p7((j-1)*50+ja) = q.p7((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==8
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p8((j-1)*50+ja,q.p8((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p8((j-1)*50+ja,q.p8((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p8((j-1)*50+ja,q.p8((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p8((j-1)*50+ja) = q.p8((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==9
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p9((j-1)*50+ja,q.p9((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p9((j-1)*50+ja,q.p9((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p9((j-1)*50+ja,q.p9((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p9((j-1)*50+ja) = q.p9((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==10
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p10((j-1)*50+ja) = q.p10((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==11
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        finalexp.p11((j-1)*50+ja,q.p11((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p11((j-1)*50+ja,q.p11((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p11((j-1)*50+ja,q.p11((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p11((j-1)*50+ja) = q.p11((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==12
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p12((j-1)*50+ja,q.p12((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p12((j-1)*50+ja,q.p12((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p12((j-1)*50+ja,q.p12((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p12((j-1)*50+ja) = q.p12((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==13
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p13((j-1)*50+ja,q.p13((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p13((j-1)*50+ja,q.p13((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p13((j-1)*50+ja,q.p13((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p13((j-1)*50+ja) = q.p13((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==14
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p14((j-1)*50+ja,q.p14((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p14((j-1)*50+ja,q.p14((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p14((j-1)*50+ja,q.p14((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p14((j-1)*50+ja) = q.p14((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                elseif i==15
                    if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100&&fixdata.data(iii,5)>660)
                        % if(mm(i,(j-1)*50+ja) == 1)
                        % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
                        % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
                        % end
                        finalexp.p15((j-1)*50+ja,q.p15((j-1)*50+ja)) = fixdata.data(iii,3);
                        xfix.p15((j-1)*50+ja,q.p15((j-1)*50+ja)) = fixdata.data(iii,4);
                        if fixdata.data(iii,5)<660
                            yfix.p15((j-1)*50+ja,q.p15((j-1)*50+ja)) = fixdata.data(iii,5);
                        end
                        q.p15((j-1)*50+ja) = q.p15((j-1)*50+ja)+1;%q��ʾÿһ��ͼƬ���ĵ�������
                    end
                end
            end
        end
    end
end

%%restart
% xfix_all=[xfix.p1,xfix.p2,xfix.p3,xfix.p4,xfix.p5,xfix.p6,xfix.p7,xfix.p8,xfix.p9,xfix.p10,xfix.p11,xfix.p12,xfix.p13,xfix.p14,xfix.p15];
% yfix_all=[yfix.p1,yfix.p2,yfix.p3,yfix.p4,yfix.p5,yfix.p6,yfix.p7,yfix.p8,yfix.p9,yfix.p10,yfix.p11,yfix.p12,yfix.p13,yfix.p14,yfix.p15];

%%ָ��һ��ע�ӵ�ĳ���ʱ�� stareTime
%ֱ����finalexp�н��в鿴��p1-p15�ж���ÿ��ͼ��ע��ʱ��
%����10λר�Һ�5λ��ר�ҵ�����
%%% �ο�����ʵ�ֶ�ά�����м������Ԫ�ص�ƽ��ֵ ���ֵ ��Сֵ
% mean(AA(AA~=0))
% max(AA(AA~=0))
% min(AA(AA~=0))
%%ָ�����ע�ӵ����ʱ���ܺ� stareTimeTotal
%%ֱ����finalexp�н��в鿴��p1-p15�ж���ÿ��ͼ��ע��ʱ������

%%ָ���壺ÿһ��ͼע�ӵ���� starePoints
%�ڽṹ��q�е�15����֧��Ҳ���Եõ�ÿһ�������ߵ�ÿ��ͼ��ע�ӵ����

%%ָ������ע�ӵ��ܸ���ͳ�� starePointsTotal
%�ڽṹ��q�е�15����֧��Ҳ���Եõ�ÿһ�������ߵ�ÿ��ͼ��ע�ӵ����

%%ָ���ģ��״�ע��ʱ��   firstStareTime
%%��finalexp�е�ÿһ���ṹ��p1 p2...p15�ĵ�һ��
for fixIndex=1:15
    if fixIndex==1
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p1(finalexp.p1~=0));
        maxstareTime(fixIndex) = max(finalexp.p1(finalexp.p1~=0));
        minstareTime(fixIndex) = min(finalexp.p1(finalexp.p1~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p1(finalexp.p1~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p1);
        maxstarePoints(fixIndex) = max(q.p1);
        minstarePoints(fixIndex) = min(q.p1);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p1);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p1(:,1));
    elseif fixIndex==2
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p2(finalexp.p2~=0));
        maxstareTime(fixIndex) = max(finalexp.p2(finalexp.p2~=0));
        minstareTime(fixIndex) = min(finalexp.p2(finalexp.p2~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p2(finalexp.p2~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p2);
        maxstarePoints(fixIndex) = max(q.p2);
        minstarePoints(fixIndex) = min(q.p2);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p2);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p2(:,1));
    elseif fixIndex==3
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p3(finalexp.p3~=0));
        maxstareTime(fixIndex) = max(finalexp.p3(finalexp.p3~=0));
        minstareTime(fixIndex) = min(finalexp.p3(finalexp.p3~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p3(finalexp.p3~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p3);
        maxstarePoints(fixIndex) = max(q.p3);
        minstarePoints(fixIndex) = min(q.p3);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p3);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p3(:,1));
    elseif fixIndex==4
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p4(finalexp.p4~=0));
        maxstareTime(fixIndex) = max(finalexp.p4(finalexp.p4~=0));
        minstareTime(fixIndex) = min(finalexp.p4(finalexp.p4~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p4(finalexp.p4~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p4);
        maxstarePoints(fixIndex) = max(q.p4);
        minstarePoints(fixIndex) = min(q.p4);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p4);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p4(:,1));
    elseif fixIndex==5
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p5(finalexp.p5~=0));
        maxstareTime(fixIndex) = max(finalexp.p5(finalexp.p5~=0));
        minstareTime(fixIndex) = min(finalexp.p5(finalexp.p5~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p5(finalexp.p5~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p5);
        maxstarePoints(fixIndex) = max(q.p5);
        minstarePoints(fixIndex) = min(q.p5);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p5);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p5(:,1));
    elseif fixIndex==6
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p6(finalexp.p6~=0));
        maxstareTime(fixIndex) = max(finalexp.p6(finalexp.p6~=0));
        minstareTime(fixIndex) = min(finalexp.p6(finalexp.p6~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p6(finalexp.p6~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p6);
        maxstarePoints(fixIndex) = max(q.p6);
        minstarePoints(fixIndex) = min(q.p6);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p6);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p6(:,1));
    elseif fixIndex==7
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p7(finalexp.p7~=0));
        maxstareTime(fixIndex) = max(finalexp.p7(finalexp.p7~=0));
        minstareTime(fixIndex) = min(finalexp.p7(finalexp.p7~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p7(finalexp.p7~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p7);
        maxstarePoints(fixIndex) = max(q.p7);
        minstarePoints(fixIndex) = min(q.p7);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p7);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p7(:,1));
    elseif fixIndex==8
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p8(finalexp.p8~=0));
        maxstareTime(fixIndex) = max(finalexp.p8(finalexp.p8~=0));
        minstareTime(fixIndex) = min(finalexp.p8(finalexp.p8~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p8(finalexp.p8~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p8);
        maxstarePoints(fixIndex) = max(q.p8);
        minstarePoints(fixIndex) = min(q.p8);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p8);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p8(:,1));
    elseif fixIndex==9
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p9(finalexp.p9~=0));
        maxstareTime(fixIndex) = max(finalexp.p9(finalexp.p9~=0));
        minstareTime(fixIndex) = min(finalexp.p9(finalexp.p9~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p9(finalexp.p9~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p9);
        maxstarePoints(fixIndex) = max(q.p9);
        minstarePoints(fixIndex) = min(q.p9);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p9);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p9(:,1));
    elseif fixIndex==10
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p10(finalexp.p10~=0));
        maxstareTime(fixIndex) = max(finalexp.p10(finalexp.p10~=0));
        minstareTime(fixIndex) = min(finalexp.p10(finalexp.p10~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p10(finalexp.p10~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p10);
        maxstarePoints(fixIndex) = max(q.p10);
        minstarePoints(fixIndex) = min(q.p10);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p10);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p10(:,1));
    elseif fixIndex==11
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p11(finalexp.p11~=0));
        maxstareTime(fixIndex) = max(finalexp.p11(finalexp.p11~=0));
        minstareTime(fixIndex) = min(finalexp.p11(finalexp.p11~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p11(finalexp.p11~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p11);
        maxstarePoints(fixIndex) = max(q.p11);
        minstarePoints(fixIndex) = min(q.p11);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p11);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p11(:,1));
    elseif fixIndex==12
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p12(finalexp.p12~=0));
        maxstareTime(fixIndex) = max(finalexp.p12(finalexp.p12~=0));
        minstareTime(fixIndex) = min(finalexp.p12(finalexp.p12~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p12(finalexp.p12~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p12);
        maxstarePoints(fixIndex) = max(q.p12);
        minstarePoints(fixIndex) = min(q.p12);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p12);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p12(:,1));
    elseif fixIndex==13
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p13(finalexp.p13~=0));
        maxstareTime(fixIndex) = max(finalexp.p13(finalexp.p13~=0));
        minstareTime(fixIndex) = min(finalexp.p13(finalexp.p13~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p13(finalexp.p13~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p13);
        maxstarePoints(fixIndex) = max(q.p13);
        minstarePoints(fixIndex) = min(q.p13);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p13);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p13(:,1));
    elseif fixIndex==14
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p14(finalexp.p14~=0));
        maxstareTime(fixIndex) = max(finalexp.p14(finalexp.p14~=0));
        minstareTime(fixIndex) = min(finalexp.p14(finalexp.p14~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p14(finalexp.p14~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p14);
        maxstarePoints(fixIndex) = max(q.p14);
        minstarePoints(fixIndex) = min(q.p14);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p14);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p14(:,1));
    elseif fixIndex==15
        %%ָ��һ
        stareTime(fixIndex) = mean(finalexp.p15(finalexp.p15~=0));
        maxstareTime(fixIndex) = max(finalexp.p15(finalexp.p15~=0));
        minstareTime(fixIndex) = min(finalexp.p15(finalexp.p15~=0));
        %%ָ���
        stareTimeTotal(fixIndex) = sum(finalexp.p15(finalexp.p15~=0));
        %%ָ����
        starePoints(fixIndex) = mean(q.p15);
        maxstarePoints(fixIndex) = max(q.p15);
        minstarePoints(fixIndex) = min(q.p15);
        %%%ָ����
        starePointsTotal(fixIndex) = sum(q.p15);
        %%ָ����
        firstStareTime(fixIndex) = mean(finalexp.p15(:,1));
    end
end
    
