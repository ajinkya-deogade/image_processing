clear;
clc;
I = imread('000016_media5_1306.tiff');
% I=imcrop(I2,[199.5 344.5 60 53]);
I_gray=rgb2gray(I);
j=1;
for i=0.1:0.1:1.5
  matrix_size=floor(((3/i)*2+1));
  Gaussian=fspecial('gaussian',[matrix_size, matrix_size], i);
  Gaussian_Image=imfilter(I_gray, Gaussian);
  figure (j), imshow(Gaussian_Image), title(['Sigma=',num2str(i)]);
  j=j+1;
  end