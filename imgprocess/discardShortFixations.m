%extract fixation points and compose pseudo color chart
%fixation points with time less than 100 ms are filtered out
%change line 10
clear;
mmmm = 1;
mm = ones(2,150);
q = ones(1,150);
clear dje finalexp;
m =[1 1];
shunxu=xlsread('E:\research\k_eyetracker\Eye movement_ data\dataset\shunxu.xlsx');
xfix = struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[]);
yfix = struct('p1',[],'p2',[],'p3',[],'p4',[],'p5',[],'p6',[],'p7',[],'p8',[],'p9',[],'p10',[]);
q = struct('p1',ones(1,150),'p2',ones(1,150),'p3',ones(1,150),'p4',ones(1,150),'p5',ones(1,150),'p6',ones(1,150),'p7',ones(1,150),'p8',ones(1,150),'p9',ones(1,150),'p10',ones(1,150));
for i=1:10%Person number
    for j=1:3%Test number
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
    for ja = 1:50%picutre number
        %find the min value
        %if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
        if i==1 
            if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2)&&fixdata.data(iii,3)>100)
                %取到的是event中的ImageStart-ImageEnd 里的
               % if(mm(i,(j-1)*50+ja) == 1)
               % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
               % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
               % end
                finalexp.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,3);
                %记录x的坐标
                xfix.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,4);
                %记录y的坐标
                yfix.p1((j-1)*50+ja,q.p1((j-1)*50+ja)) = fixdata.data(iii,5);
                q.p1((j-1)*50+ja) = q.p1((j-1)*50+ja)+1;%q fixation point number
            end
        elseif i==2
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
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
               if(fixdata.data(iii,2)>event((ja-1)*4+1)&&fixdata.data(iii,2)<event((ja-1)*4+2))
               % if(mm(i,(j-1)*50+ja) == 1)
               % djj(i,(j-1)*50+ja) = sqrt(fixdata.data(iii,4)*fixdata.data(iii,4)+fixdata.data(iii,5)*fixdata.data(iii,5));
               % mm(i,(j-1)*50+ja) = mm(i,(j-1)*50+ja)+1;
               % end
                finalexp.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,3);
                xfix.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,4);
                yfix.p10((j-1)*50+ja,q.p10((j-1)*50+ja)) = fixdata.data(iii,5);
                q.p10((j-1)*50+ja) = q.p10((j-1)*50+ja)+1;%q表示每一张图片看的点数多少
               end
         end
    end
    end
    end
end

%%restart
xfix_all=[xfix.p1,xfix.p2,xfix.p3,xfix.p4,xfix.p5,xfix.p6,xfix.p7,xfix.p8,xfix.p9,xfix.p10];
yfix_all=[yfix.p1,yfix.p2,yfix.p3,yfix.p4,yfix.p5,yfix.p6,yfix.p7,yfix.p8,yfix.p9,yfix.p10];
for cnt=1:150
Img=imread(['E:\research\k_eyetracker\Eye movement_ data\dataset\png\1280x1024png\' num2str(shunxu(cnt)) '.png']);
%imshow(img);
FixationPoints = zeros(1024,1280);
for j=1:length(xfix_all(cnt,:))
    if (yfix_all(cnt,j)==0&&xfix_all(cnt,j)==0)
        break;
    end
    if (yfix_all(cnt,j)>1024||xfix_all(cnt,j)>1280||yfix_all(cnt,j)<=0||xfix_all(cnt,j)<=0)
        continue;
    end
    FixationPoints(yfix_all(cnt,j),xfix_all(cnt,j))=1;
end
% imwrite(FixationPoints,['E:\research\k_eyetracker\Eye movement_ data\experimental data\fixpoints\'  num2str(0) '\' num2str(shunxu(cnt)) '.png']);
imwrite(FixationPoints,['E:\research\k_eyetracker\Eye movement_ data\experimental data\png\fixpoints\' num2str(shunxu(cnt)) '.png']);
window = fspecial('gaussian', 36*6, 36);
window = window/sum(sum(window));
FixationMapTemp = imfilter(FixationPoints, window, 'conv');
FixationMap = mat2gray(FixationMapTemp);
imwrite(FixationMap,['E:\research\k_eyetracker\Eye movement_ data\experimental data\png\fixmaps\' num2str(shunxu(cnt)) '.png']);
figure(cnt);
imshow(Img)
hold on
[meshX, meshY] = meshgrid(1:1280, 1:1024);
HeatMap=pcolor(meshX,meshY,FixationMap);
colorbar;
shading interp
alpha(0.4)
%saveas(HeatMap,[WritePath,ImgNameWrite,'_heatMapASD.bmp']);
saveas(HeatMap,['E:\research\k_eyetracker\Eye movement_ data\experimental data\png\heatmap\' num2str(shunxu(cnt)) '.png']);
hold off
close(figure(cnt));
end

