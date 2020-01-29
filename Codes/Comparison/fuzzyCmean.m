%fuzzy c means
img = rgb2gray(imread('aBrats18_2013_2_1_t1ce.png'));
k = 4;

[ Unew, centroid, obj_func_new ] = fuzzyCMeans( img, k );
figure;
for i=1:k
    subplot(1,k,i);
    imshow(Unew(:,:,i),[]), title('fuzzy Cmeans');
end
