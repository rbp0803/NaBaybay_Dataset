% ----------------------------------------------------------------------------------------
% Batch Image Data Extraction Algorithm                                                  %                           
% by Rodney Pino, Renier Mendoza and Rachelle Sambayan                                   %
% Programmed by Rodney Pino at University of the Philippines - Diliman                   %
% Programming dates: July 2025 to August 2025                                            % 
% ----------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------------------------%  
% This script converts raw (rgb) Baybayin character image data files into a binary, center-aligned, 28x28-pixel data. %   
% Due to its default structure array handling, a minimum of six (6) images must be present in the directory for       %
% successful execution (unless this parameter is modified in the code). Enjoy coding!                                 %                
%---------------------------------------------------------------------------------------------------------------------% 

P=[];
A=dir('*.jpg'); %takes all .jpg format files as inputs
AA=struct2cell(A); A00=pwd; A00=strcat(A00,'\');
N=length(AA);
AAA=AA(1,1:N);

%---------------------------------Start of preprocessing---------------------------------%
for i=1:N
u= imread(AAA{i});
[v1, A01]=c2bw(u);
s=regionprops(A01,'basic');
ss=struct2cell(s);
S=cell2mat(ss(1,:));

try 
EE=max(S)/max(S(S<max(S)))-1;
catch
EE=max(S)/1-1;    
end

if length(S)>=2 && EE>1 && ~isempty(max(S(S<max(S))))
%Identifying the main body's significant features or bounding box    
L=find(S==max(S));

SS=max(S(S<max(S)));
LL=find(S==SS);

B=ss(:,L);
BB=ss(:,LL);


denoise=BB{1};

A01=bwareaopen(A01,denoise+1); %Denoising other unnecessary components

A=B{3};
A(1)=A(1)-1; A(2)=A(2)-1; A(3)=A(3)+1; A(4)=A(4)+1;

A01=imcrop(A01,A); %Cropping the main body with only its essential features


M=28; 
A01=imresize(A01, [M M]); %Rescaling the cropped image

a1=sprintf('%04d', i); a1=num2str(a1);
imwrite(A01, strcat(A00,a1,'.jpg')); %Exporting the converted image as a .jpg file in the directory  

QQ=feature_vector_extractor(A01); %Extracting feature vector data
P=cat(1,P,QQ);


elseif length(S)>=2 && EE<=1 && ~isempty(max(S(S<max(S))))
  %Identifying the main body's significant features or bounding box
    L=find(S==max(S)); 
    SS=max(S(S<max(S)));
    LL=find(S==SS);
    
    B=ss(:,L);
    BB=ss(:,LL);
    
    A=cat(1,B{3},BB{3});
    AA1(1)=min(A(:,1)); AA1(2)=min(A(:,2)); AA1(3)=max(A(:,3)); AA1(4)=abs(A(1,2)-A(2,2));
    if A(1,2)>A(2,2)
       AA1(4)=AA1(4)+A(1,4);
    else
       AA1(4)=AA1(4)+A(2,4);
    end
    
    A01=imcrop(A01,AA1); %Cropping the main body with only its essential features
    
    A01=imresize(A01,[28 28]); %Rescaling the cropped image
    
    A01=bwareaopen(A01, 7); %Denoising of the 28x28 size image

    
    a1=sprintf('%04d', i); a1=num2str(a1);
    imwrite(A01, strcat(A00,a1,'.jpg')); %Exporting the converted image as a .jpg file in the directory
     
    QQ=feature_vector_extractor(A01); %%Extracting feature vector data
    P=cat(1,P,QQ); 
    
else

if isempty(max(S(S<max(S))))
M=28;
A01=imresize(A01, [M M]);
A01=bwareaopen(A01, 7); %Denoising of the 28x28 size image
a1=sprintf('%04d', i); a1=num2str(a1);
imwrite(A01, strcat(A00,a1,'.jpg')); %Exporting the converted image as a .jpg file in the directory

QQ=feature_vector_extractor(A01); %Extracting feature vector data
P=cat(1,P,QQ);

else
L=find(S==max(S));    
B=ss(:,L);
    
A=B{3};
A(1)=A(1)-1; A(2)=A(2)-1; A(3)=A(3)+1; A(4)=A(4)+1;

A01=imcrop(A01,A);


M=28;
A01=imresize(A01, [M M]); %Rescaling the cropped image
A01=bwareaopen(A01, 7); %Denoising of the 28x28 size image
a1=sprintf('%04d', i); a1=num2str(a1);
imwrite(A01, strcat(A00,a1,'.jpg')); %Exporting the converted image as a .jpg file in the directory

QQ=feature_vector_extractor(A01); %Extracting feature vector data
P=cat(1,P,QQ);

end
end
end
PP=imbinarize(P);
writematrix(PP, 'feature_vector_data.csv'); %Exporting the feature vector data as a .csv file in the directory