clear;
clc;

%% Input/Output Folders
dataDir0 = 'F:\Video\';
dirOut2 = 'F:\Video_output';
mkdir(dirOut2);
dataFolder = 'larvae\';
dataDir = strcat(dataDir0,dataFolder,'frames\');
outDir = dataDir;
filesArray = dir(strcat(dataDir,'*.jpeg'));
maxFile = length(filesArray);
cd(dataDir);

%% Load Background Image
ibg = imread('F:\Video\larvae\frames\BK\0000.jpeg');
ibg = ibg(:,:,1);

%% Initialization
fileCount = 0;
flag = 1;
iniFile = 1;
finalFile = maxFile;
cgTime = 1;
skip_frame = 0;

for file_number = iniFile:finalFile
filename = filesArray(file_number).name;
i_original = imread(filename);
i0=rgb2gray(i_original);
i0 = ibg - i0;

Average=fspecial('average');
Disk=fspecial('disk', 2);
Gaussian=fspecial('gaussian',[9,9], 0.75);
Laplacian=fspecial('laplacian');
Laplacian_of_Gaussian=fspecial('log');
Prewitt=fspecial('prewitt');
Sobel=fspecial('sobel');

Average_Image=imfilter(i0, Average);
Disk_Image=imfilter(i0, Disk);
Gaussian_Image=imfilter(i0, Gaussian);
Laplacian_Image=imfilter(i0, Laplacian);
LOG_Image=imfilter(i0, Laplacian_of_Gaussian);
Prewitt_Image=imfilter(i0, Prewitt);
Sobel_Image=imfilter(i0, Sobel);

figure (1);
subplot(1,3,1), imshow(i_original), title('Original');
subplot(1,3,2), imshow(Disk_Image), title('Disk');
% subplot(2,4,3), imshow(Gaussian_Image), title('Gaussian');
% subplot(2,4,4), imshow(Laplacian_Image), title('Laplacian');
% subplot(2,4,5), imshow(LOG_Image), title('Laplacian of Gaussian');
% subplot(2,4,6), imshow(Average_Image), title('Average');
% subplot(1,3,2), imshow(Prewitt_Image), title('Prewitt');
subplot(1,3,3), imshow(Sobel_Image), title('Sobel');
end
