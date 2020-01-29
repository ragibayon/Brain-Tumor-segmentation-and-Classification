clc
clear all
close all

img=imread("aBrats18_2013_10_1_t1ce_p.png");
[hight width dim]=size(img);

if dim == 3;
    img  = rgb2gray(img);
end




figure,imshow(img);

GLCM_mat = graycomatrix(img,'Offset',[2 0;0 2]);

GLCMstruct = Computefea(GLCM_mat,0);

v1=GLCMstruct.contr(1); %contrast

v2=GLCMstruct.corrm(1); %correlation

v3=GLCMstruct.cprom(1); % Cluster Prominence

v4=GLCMstruct.cshad(1); %% Cluster Shade

v5=GLCMstruct.dissi(1); % Dissimilarity

v6=GLCMstruct.energ(1); % Energy

v7=GLCMstruct.entro(1); % Entropy

v8=GLCMstruct.homom1(1); % Homogeneity

v9=GLCMstruct.homop(1); % Homogeneity

v10=GLCMstruct.maxpr(1);    % Maximum probability

v11=GLCMstruct.sosvh(1);    % Sum of sqaures

v12=GLCMstruct.autoc(1);    % Autocorrelation 
v13=GLCMstruct.sosvh(1); % Sum of sqaures
v14=GLCMstruct.savgh(1); % Sum average 
v15=GLCMstruct.svarh(1); % Sum variance 
v16=GLCMstruct.senth(1); % Sum entropy 
v17=GLCMstruct.dvarh(1); % Difference variance 
%GLCMstruct.dvarh2(1); % Difference variance 
v18=GLCMstruct.denth(1); % Difference entropy 
v19=GLCMstruct.inf1h(1); % Information measure of correlation1 
v20=GLCMstruct.inf2h(1); % Informaiton measure of correlation2 
%GLCMstruct.mxcch(1);% maximal correlation coefficient 
%GLCMstruct.invdc(1);% Inverse difference (INV)  
v21=GLCMstruct.indnc(1); % Inverse difference normalized 
v22=GLCMstruct.idmnc(1); % Inverse difference moment normalized 


TestImgFea = [v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22];
