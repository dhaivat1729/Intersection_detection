
%%
%% Merging two frames
%%

clc;
clear all;
dir_T = dir('/media/dhaivat1729/e4187b00-2f8d-4c09-b475-5966c6563009/Intersection_detection_work/IROS_video/Multiclass_sequences/T_junction_49/');
dir_cross = dir('/media/dhaivat1729/e4187b00-2f8d-4c09-b475-5966c6563009/Intersection_detection_work/IROS_video/Multiclass_sequences/Cross_junction_113/');
save_path = '/media/dhaivat1729/e4187b00-2f8d-4c09-b475-5966c6563009/Intersection_detection_work/IROS_video/Multiclass_sequences/Merged/';

length1 = length(dir_T);
length2 = length(dir_cross);

for i = 3:length(dir_T)
    impath1 = strcat('/media/dhaivat1729/e4187b00-2f8d-4c09-b475-5966c6563009/Intersection_detection_work/IROS_video/Multiclass_sequences/T_junction_49/', dir_T(i).name);
    impath2 = strcat('/media/dhaivat1729/e4187b00-2f8d-4c09-b475-5966c6563009/Intersection_detection_work/IROS_video/Multiclass_sequences/Cross_junction_61/', dir_cross(i).name);
    im1 = imread(impath1);
    im2 = imread(impath2);
    im_final_1 = imresize(im1, 2);
    im_final_2 = imresize(im2, 2);
    pad_im1 = padarray(im_final_1,[15 15],'both');
    pad_im2 = padarray(im_final_2,[15 15],'both');
    im_final = cat(2, pad_im1, pad_im2);
    imwrite(im_final, strcat(save_path, sprintf('00%d.png', i-2)));
    %imshow(im_final);
end