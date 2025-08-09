function [accuracystore,net1,TVal_Cell,YVal_Cell]= data_traintest3_multiclass_17classes_CNN(n)
%Simple Deep Learning Classfication
%n=number of runs
tStart=tic;
accuracystore=zeros(n,1);
net1=cell(n,1);
TVal_Cell=cell(n,1);
YVal_Cell=cell(n,1);
for i=1:n
dataFolder= "BaybayinData";  %change source folder if necessary; BaybayinData Folder contains 17 subfolders for every Baybayin character each with 3600 images 
imds = imageDatastore(dataFolder, ...
    IncludeSubfolders=true, ...
    LabelSource="foldernames");

classNames = categories(imds.Labels);
labelCount = countEachLabel(imds);

numTrainFiles = 2880; %input number of to train images. The remaining will be the holdout option
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,"randomize");

% Training Options
layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,8,Padding="same")
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,Stride=2)
    
    convolution2dLayer(3,16,Padding="same")
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,Stride=2)
    
    convolution2dLayer(3,32,Padding="same")
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(17)
    softmaxLayer];

options = trainingOptions("sgdm", ...
    InitialLearnRate=0.01, ...
    MaxEpochs=4, ...
    Shuffle="every-epoch", ...
    ValidationData=imdsValidation, ...
    ValidationFrequency=30, ...
    Plots="training-progress", ...
    Metrics="accuracy", ...
    Verbose=false);

net = trainnet(imdsTrain,layers,"crossentropy",options);


scores = minibatchpredict(net,imdsValidation);
YValidation = scores2label(scores,classNames);

TValidation = imdsValidation.Labels;
accuracy = mean(YValidation == TValidation)
figure()
confusionchart(TValidation,YValidation)

accuracystore(i,1)=accuracy;
net1{i,1}=net;
TVal_Cell{i,1}= TValidation;
YVal_Cell{i,1} = YValidation;

tEnd=toc(tStart)
end

end