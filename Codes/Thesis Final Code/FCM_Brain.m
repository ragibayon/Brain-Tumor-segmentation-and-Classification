clc
clear all
close all
%%
%%image read
img=imread('snapshot0002.png');
[hight width dim]=size(img);

if dim == 3;
    img  = rgb2gray(img);
end

%%
%%tumor detection

clusterNumber=4;
max_iter=100;
beta=1;

img=im2double(img);

data = img(:);
tic
[MembershipFunction,center,objectFunction]=MSFCM2D(img,clusterNumber,max_iter);

for i=1:clusterNumber
    
    imgFigure=reshape(MembershipFunction(i,:),[hight, width]);
    imgAverage(i)=mean2(imgFigure);
    figure, imshow(imgFigure,[]),title("abcd")
end
%%
maxU = max(MembershipFunction);
index1 = find(MembershipFunction(1,:) == maxU);
index2 = find(MembershipFunction(2,:) == maxU);
index3 = find(MembershipFunction(3,:) == maxU);
index4 = find(MembershipFunction(4,:) == maxU);
fcmImage(1:length(data))=0;
fcmImage(index1)= 1;
fcmImage(index2)= 0.8;
fcmImage(index3)= 0.6;
fcmImage(index4)= 0.4;

imagNew = reshape(fcmImage,[hight,width]);
% imagNew = reshape(fcmImage,256,256);
segtime = toc;
imshow(imagNew,[]);
figure
imshow(imagNew,[]);
title('Segmented Image');
axis off
%%
[average index]=sort(imgAverage);
TumerSlice=reshape(MembershipFunction(index(1,1),:),[hight, width]);
figure,imshow(TumerSlice);
title('tumor');
segtime = toc

plot(objectFunction);
title('Objective Function');
xlabel('Iteration');
ylabel('Cost Function');

%%
[imgls,sls]=MfuzzyLSM(img,TumerSlice,beta);
%%
%%Tumor classification
%%feature extraction
GLCM_mat = graycomatrix(imagNew,'Offset',[2 0;0 2]);

GLCMstruct = Computefea(GLCM_mat,0);

v1=GLCMstruct.contr(1);

v2=GLCMstruct.corrm(1);

v3=GLCMstruct.cprom(1);

v4=GLCMstruct.cshad(1);

v5=GLCMstruct.dissi(1);

v6=GLCMstruct.energ(1);

v7=GLCMstruct.entro(1);

v8=GLCMstruct.homom1(1);

v9=GLCMstruct.homop(1);

v10=GLCMstruct.maxpr(1);

v11=GLCMstruct.sosvh(1);

v12=GLCMstruct.autoc(1);

TestImgFea = [v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12];

