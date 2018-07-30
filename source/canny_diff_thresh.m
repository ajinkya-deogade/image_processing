clear;
clc;
I = imread('Larvae1.png');
% I=imcrop(I2,[199.5 344.5 60 53]);
I_gray=rgb2gray(I);

j=1;
for i=0.05:0.01:0.15
  [I_canny t_canny]=edge(I_gray,'canny',[t_low t_high],i);
  figure (j), imshow(I_canny), title(['Sigma=',num2str(i)]);
  j=j+1;
  end