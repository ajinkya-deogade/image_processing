clear;
clc;
I2 = imread('Larvae1.png');
% I2=imcrop(I,[274.5 607.5 345 282]);
I_gray=rgb2gray(I2);

% j=1;
t_low=0.0300;
t_high=0.0550;
% for i=1:10
  [I_canny t_canny]=edge(I_gray,'canny',[t_low t_high],0.07);
%   figure (i), imshow(I_canny), title(['Threshold Low =',num2str(t_low)]);
%   j=j+1;
%   t_low=t_low+0.0010;
% end
imshow(I_canny);