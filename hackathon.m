I=imread('C:\Users\Lenovo\Downloads\jaundice.jpg');

imshow(I);
%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I);
figure,imshow(I);
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
h = imrect(gca, BB);

I2 = imcrop(I,BB);
imshow(I2);
% Read standard MATLAB demo image.
rgbImage = I2;
% Display the original image.

imshow(rgbImage);
figure

% Maximize figure.
set(gcf, 'Position', get(0, 'ScreenSize'));
% Split the original image into color bands.
redBand = rgbImage(:,:, 1);
greenBand = rgbImage(:,:, 2);
blueBand = rgbImage(:,:, 3);
% Display them.

% Threshold each color band.
redthreshold = 210;redthreshold1=240;
greenThreshold = 150;greenThreshold1=200;
blueThreshold = 40;blueThreshold1=70;
redMask = (redBand < redthreshold1)&(redBand > redthreshold);
greenMask = (greenBand > greenThreshold)&(greenBand < greenThreshold1);
blueMask = (blueBand > blueThreshold)&(blueBand < blueThreshold1);

% Combine the masks to find where all 3 are "true."
redObjectsMask = uint8(redMask & greenMask & blueMask);

imshow(redObjectsMask,[]);

maskedrgbImage = uint8(zeros(size(redObjectsMask))); % Initialize
maskedrgbImage(:,:,1) = rgbImage(:,:,1) .* redObjectsMask;
maskedrgbImage(:,:,2) = rgbImage(:,:,2) .* redObjectsMask;
maskedrgbImage(:,:,3) = rgbImage(:,:,3) .* redObjectsMask;

area1=bwarea(redObjectsMask)
