clear;
clc;
I1 = imread('Larvae1.png');
I2=rgb2gray(I1);
I_fft=fft(I2);
imshow(I_fft);
I_ifft=ifft(I_fft);
I_ifft=uint8(I_ifft);
figure, imshow(I_ifft);