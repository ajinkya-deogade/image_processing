clear;
clc;
I = imread('LarvalDOs_highRes 001.tif');
I_gray=rgb2gray(I);

Average=fspecial('average');
Disk=fspecial('disk');
Gaussian=fspecial('gaussian',[9,9], 0.75)
Laplacian=fspecial('laplacian');
Laplacian_of_Gaussian=fspecial('log');
Prewitt=fspecial('prewitt');
Sobel=fspecial('sobel');

Average_Image=imfilter(I_gray, Average);
Disk_Image=imfilter(I_gray, Disk);
Gaussian_Image=imfilter(I_gray, Gaussian);
Laplacian_Image=imfilter(I_gray, Laplacian);
LOG_Image=imfilter(I_gray, Laplacian_of_Gaussian);
Prewitt_Image=imfilter(I_gray, Prewitt);
Sobel_Image=imfilter(I_gray, Sobel);

subplot(2,4,1), imshow(I), title('Original');
subplot(2,4,2), imshow(Disk_Image), title('Disk');
subplot(2,4,3), imshow(Gaussian_Image), title('Gaussian');
subplot(2,4,4), imshow(Laplacian_Image), title('Laplacian');
subplot(2,4,5), imshow(LOG_Image), title('Laplacian of Gaussian');
subplot(2,4,6), imshow(Average_Image), title('Average');
subplot(2,4,7), imshow(Prewitt_Image), title('Prewitt');
subplot(2,4,8), imshow(Sobel_Image), title('Sobel');
