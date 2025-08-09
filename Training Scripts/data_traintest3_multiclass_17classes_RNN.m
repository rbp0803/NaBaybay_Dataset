function [accuracystore,net1,TVal_Cell,YVal_Cell]= data_traintest3_multiclass_17classes_RNN(n)
%Simple Deep Learning Classfication
%n=number of runs
tStart=tic;
accuracystore=zeros(n,1);
net1=cell(n,1);
TVal_Cell=cell(n,1);
YVal_Cell=cell(n,1);
for ik=1:n
dataFolder= "BaybayinData";  %change source folder if necessary; BaybayinData Folder contains 17 subfolders for every Baybayin character each with 3600 images
imds = imageDatastore(dataFolder, ...
    IncludeSubfolders=true, ...
    LabelSource="foldernames");

numTrainFiles = 2880; %input number of to train images. The remaining will be the holdout option
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,"randomize");


% Get class labels
classNames = categories(imds.Labels);
numClasses = numel(classNames);

%% Convert Images to Sequences
% Read all images and convert them into column-wise sequences
XTrain = cell(length(imdsTrain.Files), 1);
YTrain = imdsTrain.Labels;

for i = 1:length(imdsTrain.Files)
    img = readimage(imdsTrain, i);
    seq = double(img) / 255; % Normalize pixel values to [0,1]
    seq = reshape(seq',28,[]); %row-wise sequence
    % Convert 28x28 image into a sequence (column-wise scanning)
%    seq = reshape(img', 28, []);  % Each row becomes a time step
    XTrain{i} = seq; % Store as a sequence
end

% Do the same for validation data
XValidation = cell(length(imdsValidation.Files), 1);
YValidation = imdsValidation.Labels;

for i = 1:length(imdsValidation.Files)
    img = readimage(imdsValidation, i);
    seq = double(img) / 255;
    seq = reshape(seq',28,[]); %row-wise sequence    
    XValidation{i} = seq;
end

% Define RNN Model
layers = [
    sequenceInputLayer(28)  % Each time step has 28 features (columns)
    lstmLayer(510, 'OutputMode', 'sequence') % 100 LSTM units, last time step output
    dropoutLayer(0.2)
    lstmLayer(255, 'OutputMode', 'last') % 100 LSTM units, last time step output
    dropoutLayer(0.2)    
    fullyConnectedLayer(numClasses)  % Fully connected layer for classification
    softmaxLayer  % Convert to probabilities
    ];  % Classification output

% Training Options
options = trainingOptions("adam", ...
    MaxEpochs=4, ...
    Shuffle="every-epoch", ...
    ValidationData={XValidation, YValidation}, ...
    ValidationFrequency=30, ...
    Plots="training-progress", ...   
    Metrics="accuracy",...    
    Verbose=false);



net = trainnet(XTrain,YTrain,layers,"crossentropy",options);


XTest = cell(length(imdsValidation.Files), 1);
TValidation = imdsValidation.Labels;

for i = 1:length(imdsValidation.Files)
img = readimage(imdsValidation, i);
seq = double(img) / 255; % Normalize
seq = reshape(seq',28,[]); %row-wise sequence

XTest{i} = seq;
end



scores = minibatchpredict(net,XTest);
YValidation =scores2label(scores,classNames);

accuracy = mean(YValidation == TValidation)
figure()
confusionchart(TValidation,YValidation)

accuracystore(ik,1)=accuracy;
net1{ik,1}=net;
TVal_Cell{ik,1}= TValidation;
YVal_Cell{ik,1} = YValidation;

tEnd=toc(tStart)
end

end