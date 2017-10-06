%% Rename files
%% As soon as Data augmentation is done, run this file.
clc;
clear all;
root = '/media/dhaivat1729/Dhaivat666/Oxford_dataset/IROS_final/';

dir_list = dir(root);

file_input = fopen('image_list.txt', 'w');


for i = 3:length(dir_list)
    i
    dir_1 = dir_list(i).name;
    dir_1_list = dir(strcat(root, dir_1));
    if length(findstr('Non_Intersection',dir_1)) > 0
        %dir_1_list = dir(strcat(root, dir_1));
        for j = 3:length(dir_1_list)
            if j < 12
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('NInt.000%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 1\n'));
                if ~strcmp(file1, file2)
                    movefile(file1, file2);
                end
            else
                
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('NInt.00%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 1\n'));
                if ~strcmp(file1, file2)
                    movefile(file1, file2);
                end
            end
        end
        
    else
        for j = 3:length(dir_1_list)
            if j < 12
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('Int.000%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 0\n'));
                if ~strcmp(file1, file2)
                    movefile(file1, file2);
                end
            else
                
                folder = strcat(root, dir_1, '/');
                file1=[folder sprintf(dir_1_list(j).name)];
                file2=[folder sprintf('Int.00%d.png',j-2)];
                fprintf(file_input, strcat(file2, ' 0\n'));
                if ~strcmp(file1, file2)
                    movefile(file1, file2);
                end
            end
        end
    end
end
