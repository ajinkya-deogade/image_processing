clear;
clc;
I2 = imread('000001_15_20140213R_1.tiff');
% I2=imcrop(I,[274.5 607.5 345 282]);
I_gray=rgb2gray(I2);

T= 0.5*(double(min(I_gray(:))) + double(max(I_gray(:))));
done=false;
while ~done
    g = I_gray >= T;
    Tnext = 0.5*(mean(I_gray(g))+mean(I_gray(~g)));
    done = abs(T-Tnext) < 0.5;
    T=Tnext;
end
I_thresh=grayslice(I_gray,T);
imshow(I_thresh);