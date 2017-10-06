%%
%% Data augmentation of Intersections(this is just a prototype)
%% Steps this script does:
%% 1. Convert into a color image(save)  --> Output_1 (1 image as output)
%% 2. Flip the image around vertical axis(save) --> Output 2(1 image output)
%% 3. Add noise to R,G,B channels of Output_1 and Output_2(2x3 = 6 images as output)
%% Try performing PCA




clc;
clear all;

root =  '/media/dhaivat1729/Dhaivat666/Oxford_dataset/3_class_intersections/';
dir_root_list = dir(root);
dir_1 = root;

fileID = fopen('Multi_class_image_list.txt','w');
image_paths = [];

save_path = '/media/dhaivat1729/Dhaivat666/Oxford_dataset/Multi_class_final/';

count = 1;
a = 1;
b = 1;
c = 1;
flag = 0;
for i = 5:(length(dir_root_list))
    dir_1 = root;
    dir_1 = strcat(dir_1, dir_root_list(i).name, '/');
    dir_1_list = dir(dir_1);
    
    for j = 3:(length(dir_1_list))
        dir_2 = strcat(dir_1, dir_1_list(j).name, '/');
        dir_2_list =  dir(dir_2);
        
        for k = 3:(length(dir_2_list))
            dir_3 = strcat(dir_2, dir_2_list(k).name, '/');
            dir_3_list = dir(dir_3);
%             if exist(strcat(save_path, 'Intersection_', num2str(a))) == 7 || exist(strcat(save_path, 'Non_Intersection_', num2str(a))) == 7
%                 flag = 1;
%                 a = a + 4;
%                 count = count + 1;
%                 continue;
%             end
%             if flag == 1
%                 count = count - 1;
%                 k = k - 1;
%                 a = a - 1;  
%                 flag = 0;
%             end
            count
            if i == 3
                path_1 = strcat(save_path, 'Cross_junction_', num2str(a));
                path_2 = strcat(save_path, 'Cross_junction_', num2str(a+1));
                path_3 = strcat(save_path, 'Cross_junction_', num2str(a+2));
                path_4 = strcat(save_path, 'Cross_junction_', num2str(a+3));
                mkdir(path_1);
                mkdir(path_2);
                mkdir(path_3);
                mkdir(path_4);
            elseif i == 4
                path_1 = strcat(save_path, 'Non_Intersection_', num2str(b));
                path_2 = strcat(save_path, 'Non_Intersection_', num2str(b+1));
                %path_3 = strcat(save_path, 'Non_Intersection_', num2str(b+2));
                %path_4 = strcat(save_path, 'Non_Intersection_', num2str(b+3));
                mkdir(path_1);
                mkdir(path_2);
                %mkdir(path_3);
                %mkdir(path_4);
            else 
                
                path_1 = strcat(save_path, 'T_junction_', num2str(c));
                path_2 = strcat(save_path, 'T_junction_', num2str(c+1));
                path_3 = strcat(save_path, 'T_junction_', num2str(c+2));
                path_4 = strcat(save_path, 'T_junction_', num2str(c+3));
                mkdir(path_1);
                mkdir(path_2);
                mkdir(path_3);
                mkdir(path_4);
            end
            for l = 3:length(dir_3_list)
                
                image_file = strcat(dir_3, dir_3_list(l).name);
                
                img = imread(image_file);
                %% Make color image from bayer format
                bayer_pattern = 'gbrg';
                out_1 = demosaic(img, bayer_pattern);
                
                out_2 = flipdim(out_1,2);      %# Flips the columns, making a mirror image
                
                
                %% Cropping parameters
                rows = 1:750;
                columns = 141:1140;
                
                crop_out_1 = out_1(rows, columns, :);
                crop_out_2 = out_2(rows, columns, :);
                crop_out_3 = crop_out_1; %imnoise(crop_out_1, 'salt & pepper', 0.02);
                
                %% Adding noise to RGB channels, add more nouse to the green channel.
                crop_out_3(:,:,1) = imnoise(crop_out_3(:,:,1), 'gaussian', 0.01);
                crop_out_3(:,:,2) = imnoise(crop_out_3(:,:,2), 'gaussian', 0.1);
                crop_out_3(:,:,3) = imnoise(crop_out_3(:,:,3), 'gaussian', 0.01);
                
                
                crop_out_4 = crop_out_2; %imnoise(crop_out_2, 'salt & pepper', 0.02);
                
                %% Adding noise to RGB channels, add more nouse to the green channel.
                crop_out_4(:,:,1) = imnoise(crop_out_4(:,:,1), 'gaussian', 0.01);
                crop_out_4(:,:,2) = imnoise(crop_out_4(:,:,2), 'gaussian', 0.1);
                crop_out_4(:,:,3) = imnoise(crop_out_4(:,:,3), 'gaussian', 0.01);
                %imshow(crop_out);
                
                %% Cropping for LRCN size
                final_out_1 = imresize(crop_out_1, [240 320]);
                final_out_2 = imresize(crop_out_2, [240 320]);
                final_out_3 = imresize(crop_out_3, [240 320]);
                final_out_4 = imresize(crop_out_4, [240 320]);
                
                if i == 3
                    imwrite(final_out_1, strcat(save_path, 'Cross_junction_', num2str(a), '/', dir_3_list(l).name));
                    imwrite(final_out_2, strcat(save_path, 'Cross_junction_', num2str(a+1), '/', dir_3_list(l).name));
                    imwrite(final_out_3, strcat(save_path, 'Cross_junction_', num2str(a+2), '/', dir_3_list(l).name));
                    imwrite(final_out_4, strcat(save_path, 'Cross_junction_', num2str(a+3), '/', dir_3_list(l).name));
                    
                    fprintf(fileID, strcat(save_path, 'Cross_junction_', num2str(a), '/', dir_3_list(l).name, ' ', ' 0\n'));
                    fprintf(fileID, strcat(save_path, 'Cross_junction_', num2str(a+1), '/', dir_3_list(l).name, ' ', ' 0\n'));
                    fprintf(fileID, strcat(save_path, 'Cross_junction_', num2str(a+2), '/', dir_3_list(l).name, ' ', ' 0\n'));
                    fprintf(fileID, strcat(save_path, 'Cross_junction_', num2str(a+3), '/', dir_3_list(l).name, ' ', ' 0\n'));
                    
                    
                elseif i == 4
                    %% We have many non-intersection sequences, so don't augment mirror images.
                    imwrite(final_out_1, strcat(save_path, 'Non_Intersection_', num2str(b), '/', dir_3_list(l).name));
                    %imwrite(final_out_2, strcat(save_path, 'Non_Intersection_', num2str(b+1), '/', dir_3_list(l).name));
                    imwrite(final_out_3, strcat(save_path, 'Non_Intersection_', num2str(b+1), '/', dir_3_list(l).name));
                    %imwrite(final_out_4, strcat(save_path, 'Non_Intersection_', num2str(b+3), '/', dir_3_list(l).name));
                    
                    
                    fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b), '/', dir_3_list(l).name, ' ', ' 2\n'));
                    %fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b+1), '/', dir_3_list(l).name, ' ', ' 1\n'));
                    fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b+1), '/', dir_3_list(l).name, ' ', ' 2\n'));
                    %fprintf(fileID, strcat(save_path, 'Non_Intersection_', num2str(b+3), '/', dir_3_list(l).name, ' ', ' 1\n'));
                    
                else
                    imwrite(final_out_1, strcat(save_path, 'T_junction_', num2str(c), '/', dir_3_list(l).name));
                    imwrite(final_out_2, strcat(save_path, 'T_junction_', num2str(c+1), '/', dir_3_list(l).name));
                    imwrite(final_out_3, strcat(save_path, 'T_junction_', num2str(c+2), '/', dir_3_list(l).name));
                    imwrite(final_out_4, strcat(save_path, 'T_junction_', num2str(c+3), '/', dir_3_list(l).name));
                    
                    
                    fprintf(fileID, strcat(save_path, 'T_junction_', num2str(c), '/', dir_3_list(l).name, ' ', ' 1\n'));
                    fprintf(fileID, strcat(save_path, 'T_junction_', num2str(c+1), '/', dir_3_list(l).name, ' ', ' 1\n'));
                    fprintf(fileID, strcat(save_path, 'T_junction_', num2str(c+2), '/', dir_3_list(l).name, ' ', ' 1\n'));
                    fprintf(fileID, strcat(save_path, 'T_junction_', num2str(c+3), '/', dir_3_list(l).name, ' ', ' 1\n'));
                    
                end
                %imshow(imresize(crop_out, [240 320]));
            end
            if i==3 
                a = a+4;
            elseif i == 4
                b = b+2;
            else
                c = c+4
            end
            count = count + 1;
        end
        dir_2_list =  [];
    end
end
fclose(fileID);

