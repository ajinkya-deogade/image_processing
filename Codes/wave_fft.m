clear;
clc;
I1 = imread('Larvae1.png');
I2=rgb2gray(I1);
[c s]=wavedec2(I2, 1, 'haar');
I_ifft=waverec2(c,s, 'haar');
I_ifft=uint8(I_ifft);
figure, imshow(I_ifft);