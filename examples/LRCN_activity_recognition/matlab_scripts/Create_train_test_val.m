%% Create train_test_files

clc;
clear all;
file_input = fopen('image_list.txt');

file_train = fopen('train_singleframe_split.txt', 'w');
file_test = fopen('test_singleframe_split.txt', 'w');
file_val = fopen('validate_singleframe_split.txt', 'w');

C = textscan(file_input, '%s', 'Delimiter','\n');
C_size = length(C{1});

indices = randperm(C_size, C_size);

%% Generating training file, it will have 50000 images

for i = 1:20000
    fprintf(file_train, strcat(C{1}{indices(i)}, '\n'));
end

%% Generating testing file, it will have 5000 images

for i = 20000:40000
    fprintf(file_test, strcat(C{1}{indices(i)}, '\n'));
end

%% Generating validation file, it will have 1404 images

for i = 40000:C_size
    fprintf(file_val, strcat(C{1}{indices(i)}, '\n'));
end

file_lstm_train = fopen('Oxford_train_lstm_split5.txt', 'w');
file_lstm_test = fopen('Oxford_test_lstm_split5.txt', 'w');
file_lstm_val = fopen('Oxford_validate_lstm_split5.txt', 'w');

root_dir = '/media/dhaivat1729/Dhaivat666/Oxford_dataset/IROS_final/';

dir_list = dir(root_dir);

in = 0;
nn = 0;

indices = randperm(length(dir_list), length(dir_list));

for i = 1:length(dir_list)
    if indices(i) == 1 || indices(i) == 2
        continue;
    elseif i <= 250
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            
            fprintf(file_lstm_train, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
        else
            
            fprintf(file_lstm_train, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
        end
        
    elseif i > 250 & i <= 400
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            
            fprintf(file_lstm_test, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
        else
            
            fprintf(file_lstm_test, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
        end
    elseif i > 400
        if length(findstr('Non_Intersection',dir_list(indices(i)).name)) > 0
            nn = nn+1;
            fprintf(file_lstm_val, strcat(root_dir, dir_list(indices(i)).name, ' 1\n'));
        else
            in = in + 1;
            fprintf(file_lstm_val, strcat(root_dir, dir_list(indices(i)).name, ' 0\n'));
        end
    end
    
end