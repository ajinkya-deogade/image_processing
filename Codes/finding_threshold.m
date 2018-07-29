clear;
clc;
close all;
I1 = imread('000016_media5_1306.tiff');
I2=rgb2gray(I1);
disk_filter = fspecial('disk',22);
I3 = imfilter(I2, disk_filter);
I4 = im2bw(I3, 0.63);
% subplot(1,2,1),imshow(I3);
% subplot(1,2,2),
imshow(I4);
% figure,
% imcontour(I4);
imwrite(I4,'template.tiff');
  %% Extract Body Contour
    clear contour_info contour_body contour_head contour_body_fit;
    contour_info = []; contour_body = [];
    figure(3);
    i_contour = imcontour(i_crop, 1); axis equal;
    contour_start = find(i_contour(1,:) < 1);
    num_of_contours = length(contour_start);
    contour_info = zeros(num_of_contours, 4);
    
    for i = 1:num_of_contours
        contour_info(i,1) = contour_start(i); % Contour Start Points
        if i < num_of_contours
            contour_info(i,2) = contour_start(i+1)-1; % Contour End Points
        else
            contour_info(num_of_contours,2) = num_of_contours;
        end
        contour_info(i,3) = i_contour(2,contour_start(i)); % Contour Length
        contour_info(i,4) = i_contour(1,contour_start(i));
    end
    contour_info';
    contour_info = sortrows(contour_info, -3); % Sort according to rows
    
    for j = 1:contour_info(1,3)
        contour_body(:,j) = i_contour(:, contour_info(1,1) + j); % Pick the biggest contour as larvae
    end
    
    contour_body = contour_body';
% imhist(I2);
% I3=roicolor(I2,175,210);
% % figure, imhist(I3);
% % figure, imshow(I3);
% [B,L,N] = bwboundaries(I3);
% figure; imshow(I3); hold on;
% for k=1:length(B),
%     boundary = B{k};
%     if(k > N)
%         plot(boundary(:,2),...
%             boundary(:,1),'g','LineWidth',2);
%     else
%         plot(boundary(:,2),...
%             boundary(:,1),'r','LineWidth',2);
%     end
% end
% % [I_canny t_canny]=edge(I3,'canny');
% figure, imshow(I_canny) ;