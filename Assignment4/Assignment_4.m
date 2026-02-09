% Assignment 4
close all;
clear;
clc;

addpath("C:\Users\sasha\OneDrive\Desktop\Machine Vision Fall 2025\Assignment_4\npy-matlab-master\npy-matlab");
disp(which('readNPY'));

% importing MedMNIST dataset


train_im = readNPY("train_images.npy");
train_lbl = readNPY("train_labels.npy");
train_im = permute(train_im, [2 3 4 1]);


test_im = readNPY("test_images.npy");
test_lbl = readNPY("test_labels.npy");
test_im = permute(test_im, [2 3 4 1]);

val_im = readNPY("val_images.npy");
val_lbl = readNPY("val_labels.npy");
val_im = permute(val_im, [2 3 4 1]);

disp(size(train_im));


% Convert labels to categorical for easier handling
train_lbl = categorical(train_lbl);
test_lbl = categorical(test_lbl);
val_lbl = categorical(val_lbl);


train_im = uint8(train_im);
test_im = uint8(test_im);
val_im = uint8(val_im);

% 10%

% Number of samples for 10%
numTrainSamples = floor(0.1 * size(train_im, 4));

% Randomly sample indices
rng('default'); % for reproducibility
idx = randperm(size(train_im, 4), numTrainSamples);

% Subsample train images and labels
train_im = train_im(:, :, :, idx);
train_lbl = train_lbl(idx);


% augmentedImageDatastores

in_size = [size(train_im,1), size(train_im, 2), size(train_im, 3)];

augm_train = augmentedImageDatastore(in_size, train_im, train_lbl);
augm_test = augmentedImageDatastore(in_size, test_im, test_lbl);
augm_val = augmentedImageDatastore(in_size, val_im, val_lbl);





% SETTING UP GoogLeNet

net = googlenet;

lgraph = layerGraph(net);

classes_num = numel(categories(train_lbl));

newFCLayer = fullyConnectedLayer(classes_num, ...
    "Name", "new_fc", ...
    "WeightLearnRateFactor", 10, ...
    "BiasLearnRateFactor", 10);

newClassLayer = classificationLayer("Name", "new_class_out");

%lgraph = layerGraph(net);
%layerNames = {lgraph.Layers.Name}';

%disp('All layer names in the network:');
%disp(layerNames);


lgraph = replaceLayer(lgraph, 'loss3-classifier', newFCLayer);
lgraph = replaceLayer(lgraph, "output", newClassLayer);

% Fixing size for ResNet-50

% augmentedImageDatastores

inp_size = net.Layers(1).InputSize;

augm_train = augmentedImageDatastore(inp_size, train_im, train_lbl);
augm_test = augmentedImageDatastore(inp_size, test_im, test_lbl);
augm_val = augmentedImageDatastore(inp_size, val_im, val_lbl);

% TRAINING 

options = trainingOptions('sgdm', ...
    'InitialLearnRate', 1e-3, ...
    'MaxEpochs', 5, ...
    'MiniBatchSize', 64, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', augm_val, ...
    "ValidationFrequency", 30, ...
    'Verbose', false, ...
    'Plots', 'training-progress');

% Train the network using the augmented image datastore
trainedNet = trainNetwork(augm_train, lgraph, options);


% Evaluation

[YPred, scores] = classify(trainedNet, augm_test);

classes = categories(test_lbl);
num_class = numel(classes);

AUCx = zeros(num_class,1);

figure; hold on;

for k = 1:num_class
    posClass = classes{k};
    [X, Y, ~, AUC] = perfcurve(test_lbl, scores(:,k), posClass);
    AUCx(k) = AUC;

    plot(X,Y, 'DisplayName', posClass);
end

xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curves for BloodMNIST');
legend('show');
hold off;

% Display AUC table
AUC_Table = table(classes, AUCx, 'VariableNames', {'Class','AUC'});
disp(AUC_Table);
