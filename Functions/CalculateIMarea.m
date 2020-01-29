function results = CalculateIMarea(img)
[w h d]=size(img)
if d==1
results.bwarea=bwarea(img);
else if d==3
    img=rgb2gray(img);
    img=imbinarize(img);
    results.bwarea=bwarea(img);
    end
end




%--------------------------------------------------------------------------
