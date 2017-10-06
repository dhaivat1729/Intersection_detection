%% Rename files
%% As soon as Data augmentation is done, run this file.
clc;
clear all;
root = '/media/dhaivat1729/Dhaivat666/Oxford_dataset/Multi_class_final/';

dir_list = dir(root);

file_input = fopen('Multi_class_image_list.txt', 'w');


for i = 3:length(dir_list)
    i
    dir_1 = dir_list(i).name;
    dir_1_list = dir(strcat(root, dir_1));
    if length(findstr('Non_Intersection',dir_1)) > 0
        dir_1_list = dir(strcat(root, dir_1));
        for j = 3:length(dir_1_list)
            if j < 12
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('N_Int.000%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 2\n'));
                movefile(file1, file2);
            else
                
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('N_Int.00%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 2\n'));
                movefile(file1, file2);
            end
        end
        
    elseif length(findstr('Cross_junction',dir_1)) > 0
        for j = 3:length(dir_1_list)
            if j < 12
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('C_junc.000%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 0\n'));
                movefile(file1, file2);
            else
                
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('C_junc.00%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 0\n'));
                movefile(file1, file2);
            end
        end
    else
        for j = 3:length(dir_1_list)
            if j < 12
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('T_junc.000%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 1\n'));
                movefile(file1, file2);
            else
                
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('T_junc.00%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 1\n'));
                movefile(file1, file2);
            end
        end
    end
    
end
