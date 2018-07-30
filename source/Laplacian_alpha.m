clear;
clc;
I = imread('LarvalDOs_highRes 001.tif');
% I=imcrop(I2,[199.5 344.5 60 53]);
I_gray=rgb2gray(I);
j=1;
for i=0.1:0.1:1
  Laplacian=fspecial('laplacian', i);
  Laplacian_Image=imfilter(I_gray, Laplacian);
  figure (j), imshow(Laplacian_Image), title(['Sigma=',num2str(i)]);
  j=j+1;
  end