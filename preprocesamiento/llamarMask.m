image_folder = 'maskfinal';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

full_name= fullfile(image_folder, filenames(6).name);         
our_images = imread(full_name);