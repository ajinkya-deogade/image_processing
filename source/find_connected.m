clear;
clc;
I1 = imread('Larvae1.png');
I2=im2bw(I1,0.20);
I2=1-I2;
I2=imclearborder(I2);
imshow(I2);
[LO n]=bwlabel(I2,8);
Areas=regionprops(LO,'area');
area_val=[Areas.Area];
maxarea=max(area_val);
idxBig= find(maxarea == area_val);
it2=ismember(LO,idxBig);
% it2=1-it2;
% cropping box
[r c]=find(it2);
close all
figure,imshow(it2);
display('Biggest object detected');

boxsize=50; 
maxc=max(c)+boxsize;
minc=min(c)-boxsize;
maxr=max(r)+boxsize;
minr=min(r)-boxsize;
if minr<0
    minr=0;
end
if minc<0
    minc=0;
end
% Important data
x=minc;
y=minr;
l=maxc-minc;
w=maxr-minr;
bbox=[minc minr maxc-minc maxr-minr];

figure, imshow(it2);