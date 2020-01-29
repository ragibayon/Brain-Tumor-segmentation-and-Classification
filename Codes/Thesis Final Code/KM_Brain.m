clc
clear all
close all

clusterNumber=4;
str="aBrats18_CBICA_AVV_1_t1ce.png"
old = {'t1ce'};
new = 'seg';
newStr = replace(str,old,new)
img=imread(str);
GT=im2bw(imread(newStr));

[hight width dim]=size(img);


if dim == 3;
    img  = rgb2gray(img);
    img=imdiffusefilt(img,'NumberOfIterations',4,'Connectivity','minimal');
end


max_iter=100;

p=hight*width;
draft=zeros(p,clusterNumber);
%%


imgVec=reshape(img,[],1);


[idx,C] = kmeans(imgVec,clusterNumber,'MaxIter',1000,'Display','final')
imgidx=reshape(idx,size(img));


for i=1:clusterNumber
    
    plotNum=320+i;
    imgFigure=imgidx==i;
    figure(1)
    subplot(plotNum)
    imshow(imgFigure,[]),title("cluster No:"+num2str(i))
    plotNum=320;    
    figure,imshow(imgFigure,[])
end
%%
TumerSlice=imgidx==6;
TumerSliceBW=TumerSlice;
% TumerSliceBW=imbinarize(TumerSlice);

max=10000;
min=100;
[BW_out,properties] = AreafilterRegions(TumerSliceBW,max,min);
figure,imshow(BW_out); title('Predicted Tumor Region');
figure,imshow(GT);    title('GT')

[score,precision,recall] = bfscore(BW_out,GT)
