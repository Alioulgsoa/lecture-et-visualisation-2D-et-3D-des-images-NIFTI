%% lecture et visualisation 2D et 3D des images NIFTI
clc;
clear all;
close all;

%% Data retrieval - Anatomical image %

path_anat = "mOTBB3_01_03_V1_T1_AOLMNdenoised_roi.nii"; % Path to anatomical NifTi file

Va = niftiread(path_anat); % Load NifTI file

Vmax = max(Va,[],'all'); % Maximum value in the whole scan
Vmin = min(Va,[],'all'); % Minimum value in the whole scan

Va_prime = (Va-Vmin)./(Vmax-Vmin); % Normalization -> values between 0 and 1
dim = size(Va_prime); % Dimensions of the volume

%% Data visualization %

% 3D visualization %
figure;
volshow(Va);

% 2D visualization %
% Slices of the volume
sliceX = 120;
sliceY = 150;
sliceZ = 150;

frontal = Va_prime(:,:,sliceZ); % Frontal view


masque = frontal > 0.0049; %masque
imshow(masque);

fronta=frontal;
fronta(~masque) = 0; % applique le masque


sagittal = reshape(Va_prime(sliceX,:,:),[dim(2) dim(3)]); % Sagittal view
horizontal = reshape(Va_prime(:,sliceY,:),[dim(1) dim(3)]); % Horizontal view

[fron]=methode(fronta); % normalisation
fron=mat2gray(fron);

%Show images
figure ;
subplot(131),imshow(imrotate(frontal,90));title('image Frontal origine');
subplot(132),imshow(imrotate(fronta,90));title('Frontal apres masque');
subplot(133),imshow(imrotate(fron,90));title('Frontal normalisation');

%Show histo
figure ;
subplot(131),imhist(frontal);title('histo Frontal origine');
subplot(132),imhist(fronta);title('histo Frontal apres masque');
subplot(133),imhist(fron);title('histoFrontal normalisation');

% Show views of the brain
figure;
subplot(2,2,1); imshow(imrotate(frontal,90)); title('Frontal');
subplot(2,2,2); imshow(imrotate(sagittal,90)); title('Sagittal');
subplot(2,2,3); imshow(imrotate(horizontal,90)); title('Horizontal');

