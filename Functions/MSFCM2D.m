function [MembershipFunction,Cent,Obj]=SFCM2D(img,ncluster,max_iter,expofFuzziness)

if ndims(img)>2
    error('SFCM2D is applicable to 2D images only!');
    return
end

if nargin<4
    expofFuzziness=2;
    if nargin<3
        max_iter=100;
    end
end

[hight,width]=size(img);
imgSize=hight*width;
imgVector=reshape(img,imgSize,1);
imgVector=double(imgVector);

MembershipFunction=initfcm(ncluster,imgSize); %%%initial partition matrix

% Main loop
for i = 1:max_iter
    [MembershipFunction, Cent, Obj(i)] = stepfcm2dmf(imgVector,[hight,width],MembershipFunction,ncluster,expofFuzziness,...
        1,1,5);
    
	% check termination condition
	if i > 1
		if abs(Obj(i) - Obj(i-1)) < 1e-4 
            break; 
        end
	end
end
% End of main function


function [U_new, center, obj_fcn] = stepfcm2dmf(data, dims, U, cluster_n,...
    l, mfw, spw, nwin)
%STEPFCM One step in fuzzy c-mean image segmentation with spatial constraints;

mf = U.^l;   % MF matrix after exponential modification

center = mf*data./((ones(size(data, 2),1)*sum(mf'))'); % new center

dist = distfcm(center, data);       % fill the distance matrix

obj_fcn = sum(sum((dist.^2).*mf));  % objective function

tmp = dist.^(-2/(l-1));      % calculate new U, suppose (l)expo != 1

U_new = tmp./(ones(cluster_n, 1)*sum(tmp));

tempwin=ones(nwin);
mfwin=zeros(size(U_new));

for i=1:size(U_new,1)
    tempmf=reshape(U_new(i,:), dims);
    tempmf=imfilter(tempmf,tempwin,'conv');
    mfwin(i,:)=reshape(tempmf,1,size(U_new,2));
end

mfwin=mfwin.^spw;
U_new=U_new.^mfw;

tmp=mfwin.*U_new;
U_new=tmp./(ones(cluster_n, 1)*sum(tmp));