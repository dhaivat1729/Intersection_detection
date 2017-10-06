%%
%% For IROS video
%%

clc;
clear all;
dir_name = '/media/dhaivat1729/198C-4AF1/video_res1/';
list = dir(dir_name);
save_path = '/media/dhaivat1729/198C-4AF1/IROS_video/Cropped/';

for i = 3:length(list)
    i
    I = imread(strcat(dir_name, list(i).name));
    bayer_pattern = 'gbrg';
    out_1 = demosaic(I, bayer_pattern);
    rows = 1:750;
    columns = 141:1140;
    crop_out_1 = out_1(rows, columns, :);
    if i < 12
        imwrite(crop_out_1, strcat(save_path, sprintf('Oxford.000%d.png',i-2), '.png'));
    elseif i >= 12 && i < 102
        imwrite(crop_out_1, strcat(save_path, sprintf('Oxford.00%d.png',i-2), '.png'));
    else
        imwrite(crop_out_1, strcat(save_path, sprintf('Oxford.0%d.png',i-2), '.png'));
    end
end

