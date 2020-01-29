function results = ImageFCM(img)
[hight, width, dim]=size(img);

if dim == 3
    img  = rgb2gray(img);
    img=imdiffusefilt(img,'NumberOfIterations',4,'Connectivity','minimal');
end

clusterNumber=4;
max_iter=100;


img=im2double(img);

data = img(:);
tic
[MembershipFunction,~,objectFunction]=MSFCM2D(img,clusterNumber,max_iter);

for i=1:clusterNumber
    
    plotNum=330+i;
    imgFigure=reshape(MembershipFunction(i,:),[hight, width]);
    imgAverage(i)=mean2(imgFigure);
    figure(1)
    subplot(plotNum)
    imshow(imgFigure,[]),title("abcd")
    plotNum=330;
end

segtime = toc;

%%
[average, index]=sort(imgAverage);
TumerSlice=reshape(MembershipFunction(index(1,1),:),[hight, width]);

figure,imshow(TumerSlice);
title('tumor');

segtime = toc;

figure,plot(objectFunction);
title('Objective Function');
xlabel('Iteration');
ylabel('Cost Function');
results.segtime





%--------------------------------------------------------------------------
