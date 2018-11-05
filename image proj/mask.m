
% Read standard MATLAB demo image.
rgbImage = imread('C:\Users\Lenovo\Desktop\image proj\watershedop.jpg');
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
redthreshold = 30;
greenThreshold = 220;
blueThreshold = 220;
redMask = (redBand < redthreshold);
greenMask = (greenBand > greenThreshold);
blueMask = (blueBand > blueThreshold);

% Combine the masks to find where all 3 are "true."
redObjectsMask = uint8(redMask & greenMask & blueMask);

imshow(redObjectsMask, []);
title('Red Objects Mask');
maskedrgbImage = uint8(zeros(size(redObjectsMask))); % Initialize
maskedrgbImage(:,:,1) = rgbImage(:,:,1) .* redObjectsMask;
maskedrgbImage(:,:,2) = rgbImage(:,:,2) .* redObjectsMask;
maskedrgbImage(:,:,3) = rgbImage(:,:,3) .* redObjectsMask;


area=bwarea(redObjectsMask)

