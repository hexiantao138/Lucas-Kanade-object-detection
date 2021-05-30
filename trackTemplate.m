% This function applies Lucas-Kanade tracking technique to track a
% template in image sequence.
% note: key point is to update the window 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% smooth image and template with gaussian kernel
% calculate the template gradient Tx and Ty 
% get It in the window with template and current frame
% get [u, v] (weighted)
% iteration if tracking is too different

function [new_window] = trackTemplate(img1, img2, window, sigma)

img1 = im2double(img1);
img2 = im2double(img2);

[row1, col1] = size(img1);
[row2, col2] = size(img2);

threshold=0.01;
maxIter=7;
u=0.0;
v=0.0;

% smooth use gaussian kernel --sigma
gaussFilt = fspecial('gaussian',10,sigma);  % SEE 'help fspecial' 
img1 = imfilter(img1, gaussFilt, 'symmetric'); 
img2 = imfilter(img2, gaussFilt, 'symmetric'); 

if(window(1) == 0)
    %%%%%      To   Do     %%%%%%%%%%%
    % the first frame, initialize new_window
    c=normxcorr2(img1,img2);
    [ypeak,xpeak]=find(c==max(c(:)));
    yoffset=ypeak-row1+1;
    xoffset=xpeak-col1+1;
    new_window(1)=yoffset;
    new_window(2)=ypeak;
    new_window(3)=xoffset;
    new_window(4)=xpeak;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    %%%%%      To   Do     %%%%%%%%%%%
    % update new_window
     [Tx,Ty]=gradient(img1);
    m=window(1);
    n=window(2);
    q=window(3);
    r=window(4);
    for i=1:maxIter
        [iX, iY]=meshgrid(q:r,m:n);
        It = interp2(q:r, m:n, img2(m:n,q:r),iX,iY)-img1;
        It=It(:);
        Tx=Tx(:);
        Ty=Ty(:);
        G = [Tx Ty]; 
        b = -It(:);
        nu = G\b;
        u=nu(1)
        v=nu(2)
        m=m+v;
        n=m+row1-1;
        q=q+u;
        r=q+col1-1;
        if max(abs(nu))<threshold
            break; 
        end
    end
    new_window(1)=m;
    new_window(2)=n;
    new_window(3)=q;
    new_window(4)=r;     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

end
