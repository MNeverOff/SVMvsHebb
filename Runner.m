%%
%% ================        Initialization        ================
clear all; clc;
addpath(genpath('Classes/'));
addpath(genpath('Data/'));
addpath(genpath('Functions/'));
addpath(genpath('Inputs/'));
addpath(genpath('Utilities/'));


%% ================        Model Constants       ================
TrainingSet = {};
TestSet = {};
Config = {};

% Temporary hard-code
Config.Models = ["OvO"];
Config.Sizes = [0 1000 2];
Config.Labels = [3 5];
Config.ThetaFunction = @thetaFunction;

%% ================ Loading and Visualizing Data ================

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
TrainingSet.values = loadMNISTImages('train-images.idx3-ubyte')';
TrainingSet.labels = loadMNISTLabels('train-labels.idx1-ubyte');
TestSet.values = loadMNISTImages('t10k-images.idx3-ubyte')';
TestSet.labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
Config.Sizes(1) = size(TrainingSet.values,2);

% Randomly select 100 data points to display
m = size(TrainingSet.values, 1);
rand_indices = randperm(m);
sel = TrainingSet.values((rand_indices(1:100)), :);
displayData(sel);

%% ================       Model execution       ================

% Launching models
for i=1:size(Config.Models,2)
    model = createModel(Config.Models(1), Config);
    model = model.Init(TrainingSet, Config);
    model = model.Prepare();
    results = model.Run();
    log = model.Log();
end