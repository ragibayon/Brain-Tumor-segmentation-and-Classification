clc
clear all

img=imread('aBrats18_CBICA_121_1_t1ce.png');
load('C:\Users\hp\OneDrive\Documents\Thesis\Matlab\Codes\Thesis Final Code\Trained83.5.mat')

[hight, width, dim]=size(img);

if dim == 3
    img  = rgb2gray(img);
end

clusterNumber=4;
max_iter=100;

img=im2double(img);

data = img(:);
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
imshow(imagNew,[]);
figure
imshow(imagNew,[]);
title('Segmented Image');
axis off

[average index]=sort(imgAverage);
TumerSlice=reshape(MembershipFunction(index(1,1),:),[hight, width]);
figure,imshow(TumerSlice);
title('tumor');


plot(objectFunction);
title('Objective Function');
xlabel('Iteration');
ylabel('Cost Function');




GLCM_mat = graycomatrix(imagNew,'Offset',[2 0;0 2]);

GLCMstruct = Computefea(GLCM_mat,0);

contrast=GLCMstruct.contr(1); %contrast

correlation=GLCMstruct.corrm(1); %correlation

ClusterProminence=GLCMstruct.cprom(1); % Cluster Prominence

ClusterShade=GLCMstruct.cshad(1); %% Cluster Shade

Dissimilarity=GLCMstruct.dissi(1); % Dissimilarity

Energy=GLCMstruct.energ(1); % Energy

Entropy=GLCMstruct.entro(1); % Entropy

Homogeneity=GLCMstruct.homom1(1); % Homogeneity

Phomogeneity=GLCMstruct.homop(1); % Homogeneity

Maximumprobability=GLCMstruct.maxpr(1);    % Maximum probability

Sumofsqaures=GLCMstruct.sosvh(1);    % Sum of sqaures

Autocorrelation=GLCMstruct.autoc(1);    % Autocorrelation
Sumofsqaures1=GLCMstruct.sosvh(1); % Sum of sqaures
Sumaverage=GLCMstruct.savgh(1); % Sum average
Sumvariance=GLCMstruct.svarh(1); % Sum variance
Sumentropy=GLCMstruct.senth(1); % Sum entropy
Differencevariance=GLCMstruct.dvarh(1); % Difference variance
%GLCMstruct.dvarh2(1); % Difference variance
Differenceentropy=GLCMstruct.denth(1); % Difference entropy
Informationmeasureofcorrelation1=GLCMstruct.inf1h(1); % Information measure of correlation1
Informaitonmeasureofcorrelation2=GLCMstruct.inf2h(1); % Informaiton measure of correlation2
%GLCMstruct.mxcch(1);% maximal correlation coefficient
%GLCMstruct.invdc(1);% Inverse difference (INV)
Inversedifferencenormalized=GLCMstruct.indnc(1); % Inverse difference normalized
Inversedifferencemomentnormalized=GLCMstruct.idmnc(1); % Inverse difference moment normalized

%%

T = table(contrast, correlation, ClusterProminence, ClusterShade, Dissimilarity, Energy, Entropy, Homogeneity, Phomogeneity, Maximumprobability, Sumofsqaures, Autocorrelation, Sumofsqaures1, Sumaverage, Sumvariance, Sumentropy, Differencevariance, Differenceentropy, Informationmeasureofcorrelation1, Informaitonmeasureofcorrelation2, Inversedifferencenormalized, Inversedifferencemomentnormalized);
% results.TestImgFea = [v1,correlation,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22];
yfit = trainedModel83.predictFcn(T)
%%