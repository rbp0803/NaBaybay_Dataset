# NABaybay Dataset

The NABaybay Dataset is a curated collection of Baybayin script data designed for computer vision applications and related research. 

It contains Baybayin character, word, and block-level images, formatted as follows:

```
○ Baybayin Character Images
  ► Available in four data formats: raw (.jpg), grayscale (.jpg), feature vector (.csv),
    and feature vector (.mat) files.
  ► Each Baybayin character has 3,600 images. Thus, totalling up to 61,200 Baybayin character images available.
  ► Each raw image is converted into binary, center-aligned, and 28×28 pixel data.
```
```
○ Baybayin Word Images
  ► 1,000 raw (.png) Baybayin word images.
  ► Each file is named according to its Latin equivalent.
```
```
○ Baybayin Block Images
  ► Over 100 raw (.png) Baybayin block images.
  ► Includes 55 handwritten and 35 typewritten Baybayin texts (some with accompanying Latin text). 
```

The complete dataset can be accessed here: **[insert doi]**

## Main Files Attached
The repository contains source code and scripts to process, extract, and validate the Baybayin character dataset.
#### Training Scripts
* Located in the /Training Scripts folder.
* Contains MATLAB functions for training the Baybayin character dataset using seven classification models:
  * **Machine Learning**: Support Vector Machine (SVM), K-Nearest Neighbors (KNN), Naive Bayes (NB), Adaptive Boosting (AB)
  * **Deep Learning**: Feed Forward Neural Network (FFNN), Convolutional Neural Network (CNN), Recurrent Neural Network (RNN).
#### Core Scripts
* `Data_Extraction_Algorithm.m` - Main function to extract data from a single raw Baybayin character image. Steps include binarization, image cleaning, exporting grayscale images, and feature vector extraction.
* `kmeans_mod.m` - Subfunction for clustering a grayscale image into two intensities for binarization.
* `c2bw.m` - Subfunction to convert a raw image into binary format using the modified k-means method.
* `feature_vector_extractor.m` - Subfunction that outputs a 1×784 feature vector from a square matrix.
* `Batch_Image_Data_Extraction_Script.m` - Batch-processing version of `Data_Extraction_Algorithm.m` for extracting data from all images in a directory.
#### Sample images
* Example images for testing the data extraction functions.
  * `Baybayin A.jpg`  - noisy image of a Baybayin character "A"
  * `Baybayin Ba.jpg` - noisy image of a Baybayin character "Ba"
  * `Baybayin Ka.jpg` - noisy image of a Baybayin character "Ka"
  * `Baybayin Da.jpg` - noisy image of a Baybayin character "Da"
  * `Baybayin EI.jpg` - noisy image of a Baybayin character "E/I"
  * `Baybayin Ga.jpg` - noisy image of a Baybayin character "Ga"
  
    
### Acknowledgment
Special thanks to family and friends who helped by writing dozens of Baybayin characters. We also acknowledge the following online sources that provided some of the raw images used in this dataset:
* [Baybayín (Baybayin) Handwritten Images - Kaggle](https://www.kaggle.com/datasets/jamesnogra/baybayn-baybayin-handwritten-images)
* [Baybayin Script Dataset - Mendeley Data](https://data.mendeley.com/datasets/j6cgcfys77/1) 
* [Roboflow Universe](https://universe.roboflow.com/search?q=baybayin)
* [Baybayin Philippine National Writing Facebook Group](https://www.facebook.com/groups/Baybayin.PhilippineNationalWritingSystem)

All images gathered from these sources were reformatted according to the data specifications described above. 

### Queries
This dataset is part of an ongoing effort to preserve and reintroduce the Baybayin script in the Philippines. It can be utilized for various Baybayin-related research projects.

For inquiries about the dataset, source code, or scripts, just email me at: rbpino@up.edu.ph
