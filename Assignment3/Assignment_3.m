% Assignment 3
close all;
clear;
clc;

%_____________Morphology____________

% read the input image as input image
inimage = imread('morphology.png');


% Show input image
figure,imshow(inimage,[]); 
title("Morphology Original image");

% Output Image B
% creating a flat morphological structural element
struct_el = strel('disk',2)
% Perform morph. operation - opening 
image_filtered_1 = imopen(inimage, struct_el);
figure(2),imshow(image_filtered_1,[]); 
title("Morphology Image B");

% saving the image
im_name = ['Morphology_B' '.jpg']
imwrite(image_filtered_1,im_name,'jpg');

% Output Image D
% creating a flat morphological structural element
struct_el = strel('disk',3)
% Perform morph. operation opening followed by closing
image_filtered_2 = imclose(imopen(inimage, struct_el), struct_el);
figure(3),imshow(image_filtered_2,[]); 
title("Morphology Image D");

% saving the image
im_name = ['Morphology_D' '.jpg']
imwrite(image_filtered_2,im_name,'jpg');

%_____________Fingerprint____________

% read the input image as input image
inimage_1 = imread('fingerprint_BW.png');

% Show input image
figure(4),imshow(inimage_1,[]); 
title("Fingerprint Original image");

% Morphological filter
% creating a flat morphological structural element
struct_el = strel('disk',1)
% Perform morph. operation opening followed by closing
finger_filtered1 = imclose(imopen(inimage_1, struct_el), struct_el);
figure(5),imshow(finger_filtered1,[]); 
title("Fingerprint Morphological filter");

% saving the image
im_name = ['Fingerprint_Morphological' '.jpg']
imwrite(finger_filtered1,im_name,'jpg');

%_______________________________________

% read the input image as input image
inimage_3 = imread('fingerprint_BW.png');

% converting to grayscale
% the original fingerprint image is binary, but for some reason
% it kept erroring, so I converted just in case for it to work
if size(inimage_3, 3) == 3
    inimage_3 = rgb2gray(inimage_3);
end

% Median Filter
% Apply median filtering to the fingerprint image
finger_filtered2 = medfilt2(inimage_3, [3 3]);
figure(6), imshow(finger_filtered2, []);
title("Fingerprint Median Filtered Image");

% saving the image
im_name = ['Fingerprint_Median' '.jpg']
imwrite(finger_filtered2,im_name,'jpg');


%_____________Moon____________

% read the input image as input image
inimage_4 = imread('moon.jpg');
in_im4_double = double(inimage_4);

figure(7),imshow(inimage_4,[]); 
title("Moon Original image");

% defining the laplacian filter
h = fspecial('laplacian', 0.2);
% applying the filter
filtered_inim4 = imfilter(in_im4_double, h, 'replicate');
% enhancing the image by subtracting from the original filtered laplacian
in_im4_enhanced = imsubtract(in_im4_double, filtered_inim4);
figure(8), imshow(in_im4_enhanced, []);
title("Moon Enhanced Laplacian");

% saving the image
im_name = ['Moon_enhanced' '.jpg']
imwrite(in_im4_enhanced,im_name,'jpg');
