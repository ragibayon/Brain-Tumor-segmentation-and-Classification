function results = myimfcn(img)
[hight width dim]=size(img);

if dim == 3;
    img  = rgb2gray(img);
end

clusterNumber=4;
max_iter=100;

img=im2double(img);

data = img(:);
[MembershipFunction,center,objectFunction]=MSFCM2D(img,clusterNumber,max_iter);

for i=1:clusterNumber
    
    imgFigure=reshape(MembershipFunction(i,:),[hight, width]);
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

GLCM_mat = graycomatrix(imagNew,'Offset',[2 0;0 2]);

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
results.TestImgFea = [v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22];
