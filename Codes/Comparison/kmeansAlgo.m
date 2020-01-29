img=rgb2gray(imread('aBrats18_2013_2_1_t1ce.png'));
k=4;

img = double(img);
img = imresize(img, [256,256]);
img_vect = img(:);
centroid = zeros(k,1);
class = zeros(length(img_vect), k);
%initialize centroid
maximum = max(img_vect);
for cent = 1:k
    centroid(cent,1)= cent * maximum / k;
end
iter = 0;
while(iter<10)
    class(1:length(img_vect),1:k) = 0;
    % classifying pixels
    for i = 1: length(img_vect)
        [val, ind]=min(abs(img_vect(i) - centroid((1:k),1)));
        class(i,ind)= img_vect(i);
    end
    % updating centroid
    for cent = 1:k
        centroid(cent, 1)= sum(class(:,cent))/length(find(class(:,cent)));
    end

    iter = iter +1; 
end

figure;imshow(img,[]),title('original');
for i = 1:k
    cluster = reshape(class(1:length(img_vect),i:i), [256,256] );
    figure; imshow(cluster,[]),title('cluster');
end
    
[average, index]=sort(imgAverage);
% %%
% 
% TumerSlice=reshape(class(index(1,1),:),[256, 256]);
% 
% figure,imshow(TumerSlice);
% title('tumor');


%%
% cluster = reshape(class(1:length(img_vect),1:), [256,256] );
%     imgAverage(i)=mean2(cluster);
%     figure; imshow(cluster,[]),title('cluster');

