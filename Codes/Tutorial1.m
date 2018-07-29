clear;
clc;
I = imread('000001_15_20140213R_1.tiff');
I_gray=rgb2gray(I);
[I_sobel t_sobel]=edge(I_gray,'sobel');
[I_prewitt t_prewitt]=edge(I_gray,'prewitt');
[I_log t_log]=edge(I_gray,'log');
[I_zerocross t_zerocross]=edge(I_gray,'zerocross');
[I_canny t_canny]=edge(I_gray,'canny');

figure (1);
subplot(2,2,1), imshow(I_sobel), title(['Sobel Edge Detector Threshold = ', num2str(t_sobel)]);
subplot(2,2,2), imshow(I_prewitt), title(['Prewitt Edge Detector Threshold = ', num2str(t_prewitt)]);
subplot(2,2,3), imshow(I_log), title(['Laplacian of Gaussian Edge Detector Threshold = ', num2str(t_log)]);
subplot(2,2,4), imshow(I_zerocross), title(['Zerocross Edge Detector Threshold = ', num2str(t_zerocross)]);

figure(2), imshow(I_canny), title(['Canny Edge Detector Threshold = ', num2str(t_canny)]);

% X1=[-1 1];
% Y1=[-1; 1];
% central_derivativeX=1/3*[-1 0 1; -1 0 1; -1 0 1];
% central_derivativeY=1/3*[1 1 1; 0 0 0; -1 -1 -1];
% 
% Iconv2X = conv2(double(rgb2gray(I)), double(central_derivativeX), 'same');
% Iconv2Y = conv2(double(rgb2gray(I)), double(central_derivativeY), 'same');
% Iconv2XY = Iconv2X + Iconv2Y;
% 
% figure (1), subplot(2,2,1), imshow(I);
% subplot(2,2,2), imshow(Iconv2X), title('Convulation in X direction');
% subplot(2,2,3), imshow(Iconv2Y), title('Convulation in Y direction');
% subplot(2,2,4), imshow(Iconv2XY), title('Convulation in X + Y direction');
% 
% subplot(2,2,1), imshow(I);
% subplot(2,2,2), imshow(Iconv2X), title('Convulation in X direction');
% subplot(2,2,3), imshow(Iconv2Y), title('Convulation in Y direction');
% subplot(2,2,4), imshow(Iconv2XY), title('Convulation in X + Y direction');
% 
% Ifilter2X = filter2(double(central_derivativeX), double(rgb2gray(I)));
% Ifilter2Y = filter2(double(central_derivativeY), double(rgb2gray(I)));
% Ifilter2XY = Ifilter2X + Ifilter2Y;
% 
% figure (2), subplot (2,2,1), imshow(I);
% subplot(2,2,2), imshow(Ifilter2X), title('Corelation in X direction');
% subplot(2,2,3), imshow(Ifilter2Y), title('Corelation in Y direction');
% subplot(2,2,4), imshow(Ifilter2XY), title('Corelation in X + Y direction');
% 
% disp(size(I));
% disp(size(Iconv2X));
% disp(size(Iconv2Y));
% disp(size(Iconv2XY));
% disp(size(Ifilter2XY));
% 
% Iconvcorr=Iconv2XY + Ifilter2XY;
% figure (3), imshow(Iconvcorr);
% 
% figure (4), subplot(2,3,1), mesh(Iconv2X);
% subplot(2,3,2), mesh(Iconv2Y);
% subplot(2,3,3), mesh(Iconv2XY);
% subplot(2,3,4), mesh(Ifilter2X);
% subplot(2,3,5), mesh(Ifilter2Y);
% subplot(2,3,6), mesh(Ifilter2XY);
