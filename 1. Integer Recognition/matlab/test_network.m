%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
% imshow(reshape(xtest(:, 1), 28, 28));
% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
probabilities = [];
C = zeros(10,10);
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    probabilities = [probabilities P];
end
[output, ind] = max(probabilities);
for i=1:length(ytest)
    C(ind(i), ytest(i)) = C(ind(i), ytest(i))+1;
end
fprintf("The confusion matrix: ");
disp(C);