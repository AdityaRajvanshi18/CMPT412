layers = get_lenet();

ximg = [];
des_num = [];
img_folder = '../test/';
correct = 0;
img_src = dir(fullfile(img_folder, '*.png'));
load lenet.mat

for i = 1:numel(img_src)
    file = fullfile(img_folder,img_src(i).name);
    img = imread(file); %read file
    img = rgb2gray(img); %make grayscale
    subplot(2,5,i);
    imshow(img); %plot before further edits
    img = imresize(imcomplement(img),[28 28]); %resize and make background black
    img = transpose(img); %rotate so easier to see
    img = reshape(img,[784 1]); %reshape
    num = img_src(i).name(1:end-4); %get image number
    num = str2num(['uint8(',num,')']); %convert from str to int
    
    ximg = [ximg img]; %track of returned num
    des_num = [des_num num]; %track of real num
end
layers{1}.batch_size = 1; %pass one image at a time
for i=1:size(ximg, 2)
    [output, P] = convnet_forward(params, layers, ximg(:, i)); %run through network
    test_label = des_num(i); 
    [~,pred_label] = max(P); %get predicted num
    pred_label = pred_label - 1;
    if(test_label == pred_label) %if predicted num and actual num are the same
        correct = correct+1; %+1 correct count
    end
    fprintf('The true number is: %d.\n', test_label);
    fprintf('The predicted number is: %d.\n', pred_label);
end
fprintf('Correctly predicted: %d/10.\n', correct);






    