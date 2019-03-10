function vBoW = create_bow_histograms(nameDir, vCenters)

  vImgNames = dir(fullfile(nameDir,'*.png'));
  nImgs = length(vImgNames); 
  vFeatures = zeros(0,128); % 16 histograms containing 8 bins
  vPatches = zeros(0,16*16); % 16*16 image patches 
  vBoW  = [];
  
  cellWidth = 4;
  cellHeight = 4;
  nPointsX = 10;
  nPointsY = 10;
  border = 8;
  
  % Extract features for all images in the given directory
  for i=1:nImgs
    disp(strcat('  Processing image ', num2str(i),'...'));
    
    % load the image
    img = double(rgb2gray(imread(fullfile(nameDir,vImgNames(i).name))));

    % Collect local feature points for each image
    % and compute a descriptor for each local feature point
    vPoints = grid_points(img,nPointsX,nPointsY,border);
    [vFeatures,~] = descriptors_hog(img,vPoints,cellWidth,cellHeight);
    
    % Create a BoW activation histogram for this image
    vBoW = [vBoW; bow_histogram(vFeatures, vCenters)];
    
  end
    
end