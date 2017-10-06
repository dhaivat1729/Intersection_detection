%% Create train_test_files

clc;
clear all;
file_input = fopen('Multi_class_image_list.txt', 'r');

file_train = fopen('Multi_class_train_singleframe_split.txt', 'w');
file_test = fopen('Multi_class_test_singleframe_split.txt', 'w');
file_val = fopen('Multi_class_validate_singleframe_split.txt', 'w');

C = textscan(file_input, '%s', 'Delimiter','\n');
C_size = length(C{1});

indices = randperm(C_size, C_size);

%% Generating training file, it will have 50000 images

for i = 1:18000
    fprintf(file_train, strcat(C{1}{indices(i)}, '\n'));
end

%% Generating testing file, it will have 5000 images

for i = 18001:35000
    fprintf(file_test, strcat(C{1}{indices(i)}, '\n'));
end

%% Generating validation file, it will have 1404 images

for i = 35001:C_size
    fprintf(file_val, strcat(C{1}{indices(i)}, '\n'));
end

file_lstm_train = fopen('Multi_class_train_lstm_split10.txt', 'w');
file_lstm_test = fopen('Multi_class_test_lstm_split10.txt', 'w');
file_lstm_val = fopen('Multi_class_validate_lstm_split.txt', 'r');

root_dir = '/media/dhaivat1729/Dhaivat666/Oxford_dataset/Multi_class_final/';

dir_list = dir(root_dir);

indices = randperm(length(dir_list), length(dir_list));

for i = 1:length(dir_list)
    if indices(i) == 1 || indices(i) == 2
        continue;
    elseif i <= 600
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            fprintf(file_lstm_train, strcat(root_dir, dir_list(indices(i)).name, ' 2\n'));
        elseif length(findstr('Cross_junction_',dir_list(indices(i)).name)) > 0
            fprintf(file_lstm_train, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
        else
            fprintf(file_lstm_train, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
        end
        
    elseif i > 600 
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            fprintf(file_lstm_test, strcat(root_dir, dir_list(indices(i)).name, ' 2\n'));
        elseif length(findstr('Cross_junction_',dir_list(indices(i)).name)) > 0
            
            fprintf(file_lstm_test, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
        else
            fprintf(file_lstm_test, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
        end
%     elseif i > 800
%         if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
%             fprintf(file_lstm_val, strcat(root_dir, dir_list(indices(i)).name, ' 2\n'));
%         elseif length(findstr('Cross_junction_',dir_list(indices(i)).name)) > 0
%             fprintf(file_lstm_val, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
%         else
%             fprintf(file_lstm_val, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
%         end
%     end
    
end
end





