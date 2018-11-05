
% Read standard MATLAB demo image.
rgbImage = imread('C:\Users\Lenovo\Desktop\image proj\oilspill.jpg');
% Display the original image.

imshow(rgbImage);
title('Original RGB Image');
% Maximize figure.
set(gcf, 'Position', get(0, 'ScreenSize'));
% Split the original image into color bands.
redBand = rgbImage(:,:, 1);
greenBand = rgbImage(:,:, 2);
blueBand = rgbImage(:,:, 3);
% Display them.

% Threshold each color band.
redthreshold = 65;redthreshold1=100;
greenThreshold = 9;greenThreshold1=40;
blueThreshold = 23;blueThreshold1=65;
redMask = (redBand < redthreshold1)&(redBand > redthreshold);
greenMask = (greenBand > greenThreshold)&(greenBand < greenThreshold1);
blueMask = (blueBand > blueThreshold)&(blueBand < blueThreshold1);

% Combine the masks to find where all 3 are "true."
redObjectsMask = uint8(redMask & greenMask & blueMask);

imshow(redObjectsMask, []);
title('Red Objects Mask');
maskedrgbImage = uint8(zeros(size(redObjectsMask))); % Initialize
maskedrgbImage(:,:,1) = rgbImage(:,:,1) .* redObjectsMask;
maskedrgbImage(:,:,2) = rgbImage(:,:,2) .* redObjectsMask;
maskedrgbImage(:,:,3) = rgbImage(:,:,3) .* redObjectsMask;


area=bwarea(redObjectsMask)
