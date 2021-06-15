
%% Setup
layers = get_lenet();
load lenet.mat
layers{1}.batch_size = 1;
%image paths
img1 = imread('../images/image1.jpg');
img2 = imread('../images/image2.jpg');
img3 = imread('../images/image3.png');
img4 = imread('../images/image4.jpg');


%% image 1
img1 = rgb2gray(img1);
img1 = imbinarize(img1);
final_img1 = im2double(img1);

%find connected components
[L,n] = bwlabel(1.-img1); 
boundaries = cell(1,n);
for i = 1:n
    [row,col] = find(L==i) %find connected component 1, 2, 3, ... n
    %rescale boundaries
    boundaries{i} = img1(min(row):max(row), min(col):max(col)); 
    min_r = min(row);
    min_c = min(col);
    [row,col] = size(boundaries{i});
    
    %create padding
    if row > col
        boundaries{i} = padarray(boundaries{i}, [0 floor((row-col)/2)], 1);
    else
        boundaries{i} = padarray(boundaries{i}, [floor((col-row)/2) 0], 1); 
    end
    
    if max([row, col]) > 100 && (row/col-1) > 0.5
        reshap = 5;
    else
        if max([row, col]) > 100
            reshap = 4;
        else
            reshap = 0;
        end
    end
    
    boundaries{i} = imresize(boundaries{i}, [28-2*reshap 28-2*reshap], 'nearest')';
    boundaries{i} = padarray(boundaries{i}, [reshap reshap], 1);
    [~, P] = convnet_forward(params, layers, logical(1.-boundaries{i}(:)));
    [~, idx] = max(P); 
    
    boundaries{i} = transpose(boundaries{i});
    boundaries{i} = im2double(boundaries{i});
    subplot(2,5,i);
    imshow(boundaries{i});
    final_img1 = insertText(final_img1, [min_c min_r], idx-1, 'FontSize', 64); 
       
end
figure; imshow(final_img1);

% image 2
img2 = rgb2gray(img2);
img2 = imbinarize(img2);
final_img2 = im2double(img2);

%find connected components
[L,n] = bwlabel(1.-img2); 
boundaries = cell(1,n);
for i = 1:n
    [row,col] = find(L==i) %find connected component 1, 2, 3, ... n
    %rescale boundaries
    boundaries{i} = img2(min(row):max(row), min(col):max(col)); 
    min_r = min(row);
    min_c = min(col);
    [row,col] = size(boundaries{i});
    
    %create padding
    if row > col
        boundaries{i} = padarray(boundaries{i}, [0 floor((row-col)/2)], 1);
    else
        boundaries{i} = padarray(boundaries{i}, [floor((col-row)/2) 0], 1); 
    end
    
    if max([row, col]) > 100 && (row/col-1) > 0.5
        reshap = 5;
    else
        if max([row, col]) > 100
            reshap = 4;
        else
            reshap = 0;
        end
    end
    
    boundaries{i} = imresize(boundaries{i}, [28-2*reshap 28-2*reshap], 'nearest')';
    boundaries{i} = padarray(boundaries{i}, [reshap reshap], 1);
    [~, P] = convnet_forward(params, layers, logical(1.-boundaries{i}(:)));
    [~, idx] = max(P);
    
    boundaries{i} = transpose(boundaries{i});
    boundaries{i} = im2double(boundaries{i});
    subplot(2,5,i);
    imshow(boundaries{i});

    final_img2 = insertText(final_img2, [min_c min_r], idx-1, 'FontSize', 64); 
    
end

figure; imshow(final_img2);

% image 3
img3 = rgb2gray(img3);
img3 = imbinarize(img3);
final_img3 = im2double(img3);

%find connected components
[L,n] = bwlabel(1.-img3); 
boundaries = cell(1,n);
for i = 1:n
    [row,col] = find(L==i) %find connected component 1, 2, 3, ... n
    %rescale boundaries
    boundaries{i} = img3(min(row):max(row), min(col):max(col)); 
    min_r = min(row);
    min_c = min(col);
    [row,col] = size(boundaries{i});
    
    %create padding
    if row > col
        boundaries{i} = padarray(boundaries{i}, [0 floor((row-col)/2)], 1);
    else
        boundaries{i} = padarray(boundaries{i}, [floor((col-row)/2) 0], 1); 
    end
    
    if max([row, col]) > 100 && (row/col-1) > 0.5
        reshap = 5;
    else
        if max([row, col]) > 100
            reshap = 4;
        else
            reshap = 0;
        end
    end
    
    boundaries{i} = imresize(boundaries{i}, [28-2*reshap 28-2*reshap], 'nearest')';
    boundaries{i} = padarray(boundaries{i}, [reshap reshap], 1);
    [~, P] = convnet_forward(params, layers, logical(1.-boundaries{i}(:)));
    [~, idx] = max(P);
    
    boundaries{i} = transpose(boundaries{i});
    boundaries{i} = im2double(boundaries{i});
    subplot(1,6,i);
    imshow(boundaries{i});

    final_img3 = insertText(final_img3, [min_c min_r], idx-1, 'FontSize', 32); 
    
end

figure; imshow(final_img3);

%% image 4
img4 = rgb2gray(img4);
img4 = imbinarize(img4);
final_img4 = im2double(img4);

%find connected components
[L,n] = bwlabel(1.-img4); 
boundaries = cell(1,n);
for i = 1:n
    [row,col] = find(L==i) %find connected component 1, 2, 3, ... n
    %rescale boundaries
    boundaries{i} = img4(min(row):max(row), min(col):max(col)); 
    min_r = min(row);
    min_c = min(col);
    [row,col] = size(boundaries{i});
    
    %create padding
    if row > col
        boundaries{i} = padarray(boundaries{i}, [0 floor((row-col)/2)], 1);
    else
        boundaries{i} = padarray(boundaries{i}, [floor((col-row)/2) 0], 1); 
    end
    
    if max([row, col]) > 100 && (row/col-1) > 0.5
        reshap = 5;
    else
        if max([row, col]) > 100
            reshap = 4;
        else
            reshap = 0;
        end
    end
    
    boundaries{i} = imresize(boundaries{i}, [28-2*reshap 28-2*reshap], 'nearest')';
    boundaries{i} = padarray(boundaries{i}, [reshap reshap], 1);
    [~, P] = convnet_forward(params, layers, logical(1.-boundaries{i}(:)));
    [~, idx] = max(P);
    
    boundaries{i} = transpose(boundaries{i});
    boundaries{i} = im2double(boundaries{i});
    subplot(6,10,i);
    imshow(boundaries{i});

    final_img4 = insertText(final_img4, [min_c min_r], idx-1, 'FontSize', 16); 
    
end

figure; imshow(final_img4);





    