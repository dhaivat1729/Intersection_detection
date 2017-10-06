%%
%% Lara test data augmentation and script generation.
%%

clc;
clear all;

root =  '/media/dhaivat1729/Seagate Backup Plus Drive/Lara_dataset/Intersections/';
dir_root_list = dir(root);
dir_1 = root;

fileID = fopen('lara_test_list.txt','w');
image_paths = [];

save_path = '/media/dhaivat1729/Seagate Backup Plus Drive/Lara_dataset/Lara_sequences/';

count = 1;
a = 1;
b = 1;
flag = 0;
for i = 3:(length(dir_root_list))
    dir_1 = root;
    dir_1 = strcat(dir_1, dir_root_list(i).name, '/');
    dir_1_list = dir(dir_1);
    for j = 3:(length(dir_1_list))
        dir_2 = strcat(dir_1, dir_1_list(j).name, '/');
        dir_2_list =  dir(dir_2);
        
        if i == 3
            path_1 = strcat(save_path, 'Intersection_', num2str(a));
            path_2 = strcat(save_path, 'Intersection_', num2str(a+1));
            path_3 = strcat(save_path, 'Intersection_', num2str(a+2));
            path_4 = strcat(save_path, 'Intersection_', num2str(a+3));
            mkdir(path_1);
            mkdir(path_2);
            mkdir(path_3);
            mkdir(path_4);
        else
            path_1 = strcat(save_path, 'Non_Intersection_', num2str(b));
            path_2 = strcat(save_path, 'Non_Intersection_', num2str(b+1));
            path_3 = strcat(save_path, 'Non_Intersection_', num2str(b+2));
            path_4 = strcat(save_path, 'Non_Intersection_', num2str(b+3));
            mkdir(path_1);
            mkdir(path_2);
            mkdir(path_3);
            mkdir(path_4);
        end
        for l = 3:(length(dir_2_list))
            image_file = strcat(dir_2, dir_2_list(l).name);
            
            img = imread(image_file);
            %% Make color image from bayer format
            %bayer_pattern = 'gbrg';
            %out_1 = demosaic(img, bayer_pattern);
            out_1 = img;
            out_2 = flipdim(out_1,2);      %# Flips the columns, making a mirror image
            
            
            %% Cropping parameters
            %rows = 1:750;
            %                 columns = 141:1140;
            %
            %                 crop_out_1 = out_1(rows, columns, :);
            %                 crop_out_2 = out_2(rows, columns, :);
            %                 crop_out_3 = crop_out_1; %imnoise(crop_out_1, 'salt & pepper', 0.02);
            
            %% Adding noise to RGB channels, add more nouse to the green channel.
            noise_out_1(:,:,1) = imnoise(out_1(:,:,1), 'gaussian', 0.01);
            noise_out_1(:,:,2) = imnoise(out_1(:,:,2), 'gaussian', 0.1);
            noise_out_1(:,:,3) = imnoise(out_1(:,:,3), 'gaussian', 0.01);
            
            
            %crop_out_4 = crop_out_2; %imnoise(crop_out_2, 'salt & pepper', 0.02);
            
            %% Adding noise to RGB channels, add more nouse to the green channel.
            noise_out_2(:,:,1) = imnoise(out_2(:,:,1), 'gaussian', 0.01);
            noise_out_2(:,:,2) = imnoise(out_2(:,:,2), 'gaussian', 0.1);
            noise_out_2(:,:,3) = imnoise(out_2(:,:,3), 'gaussian', 0.01);
            %imshow(crop_out);
            
            %% Cropping for LRCN size
            final_out_1 = imresize(out_1, [240 320]);
            final_out_2 = imresize(out_2, [240 320]);
            final_out_3 = imresize(noise_out_1, [240 320]);
            final_out_4 = imresize(noise_out_2, [240 320]);
            
            if i == 3
                
                imwrite(final_out_1, strcat(save_path, 'Intersection_', num2str(a), '/', dir_2_list(l).name));
                imwrite(final_out_2, strcat(save_path, 'Intersection_', num2str(a+1), '/', dir_2_list(l).name));
                imwrite(final_out_3, strcat(save_path, 'Intersection_', num2str(a+2), '/', dir_2_list(l).name));
                imwrite(final_out_4, strcat(save_path, 'Intersection_', num2str(a+3), '/', dir_2_list(l).name));
                
                fprintf(fileID, strcat(save_path, 'Intersection_', num2str(a), '/', dir_2_list(l).name, ' ', ' 0\n'));
                fprintf(fileID, strcat(save_path, 'Intersection_', num2str(a+1), '/', dir_2_list(l).name, ' ', ' 0\n'));
                fprintf(fileID, strcat(save_path, 'Intersection_', num2str(a+2), '/', dir_2_list(l).name, ' ', ' 0\n'));
                fprintf(fileID, strcat(save_path, 'Intersection_', num2str(a+3), '/', dir_2_list(l).name, ' ', ' 0\n'));
                
                
            else
                
                imwrite(final_out_1, strcat(save_path, 'Non_Intersection_', num2str(b), '/', dir_2_list(l).name));
                imwrite(final_out_2, strcat(save_path, 'Non_Intersection_', num2str(b+1), '/', dir_2_list(l).name));
                imwrite(final_out_3, strcat(save_path, 'Non_Intersection_', num2str(b+2), '/', dir_2_list(l).name));
                imwrite(final_out_4, strcat(save_path, 'Non_Intersection_', num2str(b+3), '/', dir_2_list(l).name));
                
                
                fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b), '/', dir_2_list(l).name, ' ', ' 1\n'));
                fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b+1), '/', dir_2_list(l).name, ' ', ' 1\n'));
                fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b+2), '/', dir_2_list(l).name, ' ', ' 1\n'));
                fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b+3), '/', dir_2_list(l).name, ' ', ' 1\n'));
                
            end
            %imshow(imresize(crop_out, [240 320]));
            
            if i==3
                a = a+4;
            else
                b = b+4;
            end
            count = count + 1
        end
        
        dir_2_list =  [];
    end
end
fclose(fileID);

file_lstm_train = fopen('lara_train_lstm_split.txt', 'w');
file_lstm_test = fopen('lara_test_lstm_split.txt', 'w');
file_lstm_val = fopen('lara_validate_lstm_split.txt', 'w');

root_dir = '/media/dhaivat1729/Seagate Backup Plus Drive/Lara_dataset/Lara_sequences/';

dir_list = dir(root_dir);

in = 0;
nn = 0;
a = 0;

indices = randperm(length(dir_list), length(dir_list));

for i = 1:length(dir_list)
    if indices(i) == 1 || indices(i) == 2
        continue;
    elseif i <= 100
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            if length(dir(strcat(root_dir, dir_list(indices(i)).name))) > 18
                a = a + 1;
                fprintf(file_lstm_train, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
            end
        else
            if length(dir(strcat(root_dir, dir_list(indices(i)).name))) > 18
                a = a + 1;
                fprintf(file_lstm_train, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
            end
        end
        
    elseif i > 100 & i <= 150
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            if length(dir(strcat(root_dir, dir_list(indices(i)).name))) > 18
                nn = nn+1;
                a = a + 1;
                fprintf(file_lstm_test, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
            end
        else
            if length(dir(strcat(root_dir, dir_list(indices(i)).name))) > 18
                in = in + 1;
                a = a + 1;
                fprintf(file_lstm_test, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
            end
        end
    elseif i > 150
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            if length(dir(strcat(root_dir, dir_list(indices(i)).name))) > 18
                a = a + 1;
                fprintf(file_lstm_val, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
            end
        else
            if length(dir(strcat(root_dir, dir_list(indices(i)).name))) > 18
                a = a + 1;
                fprintf(file_lstm_val, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
            end
        end
    end
    
end
