%%
%% ================        Initialization        ================
clear all; clc;
addpath(genpath('Classes/'));
addpath(genpath('Data/'));
addpath(genpath('Functions/'));
addpath(genpath('Inputs/'));
addpath(genpath('Utilities/'));
addpath(genpath('LearningFunctions/'));


%% ================        Model Constants       ================
TrainingSet = {};
TestSet = {};
Config = {};

% Temporary hard-code
Config.Models = [string('OvO')];
Config.LearningFunctions = {@hebbLearn, @SVMLearn};
Config.Sizes = [0 1000 2];
Config.ThetaFunction = @thetaFunctionRandConnectivity;
Config.Classes = [3 5]; % 0 1 2 3 4 5 6 7 8 9

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
for i=1:size(Config.Models,2)                       % All structure models
    for l=1:size(Config.LearningFunctions,2)        % All learning models
        for j = 1:size(Config.Classes,2)            % All classes (first)
            for k = 1:size(Config.Classes,2)        % Against all other classes (second)
                if (j ~= k)                         % don't compare class with itself
                    Config.Labels = [j k];
                    model = createModel(Config.Models(i), Config);
                    model = model.Init(TrainingSet);
                    results = model.Train(TrainingSet, Config.Learning(l));
                    log = model.Log();
                end
            end
        end
        
        
    end
end