clc
clear all
close all

str="aBrats18_2013_2_1_t1ce.png";
old = {'t1ce'};
new = 'seg';
newStr = replace(str,old,new);
% mkdir C:\Users\hp\OneDrive\Documents\Thesis\Conferecne\Book\Data\Result\Figure\Brats18_CBICA_AVV_1_t1ce

img=imread(str);
GT=im2bw(imread(newStr));
figure,imshow(img);
[hight width dim]=size(img);

if dim == 3;
    img  = rgb2gray(img);
    img=imdiffusefilt(img,'NumberOfIterations',4,'Connectivity','minimal');
    figure,imshow(img)
end
%%
clusterNumber=4;
max_iter=100;
beta=1;

data = img(:);
tic

[MembershipFunction,center,objectFunction]=MSFCM2D(img,clusterNumber,max_iter);

for i=1:clusterNumber
    
    plotNum=220+i;
    imgFigure=reshape(MembershipFunction(i,:),[hight, width]);
    imgAverage(i)=mean2(imgFigure);
    figure(1)
    subplot(plotNum)
    imshow(imgFigure,[]),title("cluster No:"+num2str(i))
    plotNum=220;
end

segtime = toc;

[average index]=sort(imgAverage);
%%
TumerSlice=reshape(MembershipFunction(index(1,1),:),[hight, width]);

figure(2),imshow(TumerSlice);
title('Predicted Tumor Slice');

segtime = toc;

figure(3),plot(objectFunction);
title('Objective Function');
xlabel('Iteration');
ylabel('Cost Function');

TumerSliceBW=imbinarize(TumerSlice,0.15);

max=10000;
min=200;

[BW_out,properties] = AreafilterRegions(TumerSliceBW,max,min);
% [GT,GTproperties] = AreafilterRegions(GT,max,min);

figure,imshow(BW_out); title('Predicted Tumor Region');
figure,imshow(GT);    title('GT')

% imwrite(BW_out,'Predicted Tumor Region.png')
% imwrite(GT,'GT.png')
% imwrite(TumerSlice,'Predicted Tumor Slice.png')
% saveas(figure(3),'Objective Function.png')
% saveas(figure(1),'Cluster.png')

[score,precision,recall] = bfscore(BW_out,GT)
Tumor_area=properties.Area;
% GT_area=GTproperties.Area;
%%
[imgls,sls]=MfuzzyLSM(img,BW_out,beta);

