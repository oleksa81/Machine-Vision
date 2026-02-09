For the dataset, the bloodMNIST dataset from
MedMNIST was chosen. The project was implemented in MATLAB, where also addittional
commands had to be added, readNPY, to be specific. For this classification task, GoogLeNet
was chosen as it is much faster and less heavy on the CPU.

TEST RESULTS

First, I would like to start with the dataset and additional command implementation. There
are a few options: either to .npz or .npy type of arrays that represent the dataset. I used NPY
(provided the GitHub repository after the code listing). There had to be several manipulations
made with the dataset which included data augmentation, reducing training set to 10% of the
initial complexion (the datapoints included in the dataset were chosen randomly). The source of
the dataset used, bloodMNIST, is also provided in the section after code listing.
GoogLeNet was chosen as a model as it is fairly quick and not heavy on the CPU.
Initially I wanted to use ResNet-50, but even after changing the size of batches and epochs it
took a lot of time to run.
I was starting with the following settings: learning rate = 1e-4, epochs = 2, the validation
accuracy was quite low – 65.13%, reaching the 30th iteration it almost plateaus (a), also ROC
Curve and AUC for the 8 classes of this dataset are provided on (b) and (c) accordingly.
As was mentioned in the assignment, we should try out different parameter values, so for
the second time I left the same learning rate and increased the number of epochs = 5. The
validation accuracy increased to 75.23% (d), the ROC curve is distributed more even between
classes (e).
Next, I kept the same number of epochs but increased the learning rate = 1e-3. In this
case validation accuracy increased to 76.93%. The overall result is almost the same as
increasing the number of epochs, but in this case the accuracy for each class is much higher
than compared to the 5 epochs, see (e).
3
Finally, applying both changes – epochs = 5, learning rate = 1e-3. These settings were
the most demanding, but delivered the best results, as expected. Validation accuracy in this
case reached up to 81.54% - see figure (j).


Commands for MATLAB source: https://github.com/kwikteam/npy-matlab/tree/master/npy-
matlab
Dataset: https://zenodo.org/records/10519652
