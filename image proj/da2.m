I=imread('C:\Users\Lenovo\Desktop\hist.jpg');
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
figure
imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
se = strel('disk', 20);
Io = imopen(I, se);
figure
imshow(Io), title('Opening (Io)')
Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
figure
imshow(Iobr), title('Opening-by-reconstruction (Iobr)')
Ioc = imclose(Io, se);
figure
imshow(Ioc), title('Opening-closing (Ioc)')
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
figure
imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')
fgm = imregionalmax(Iobrcbr);
figure
image(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')
I2 = I;
I2(fgm) = 255;
figure
imshow(I2), title('Regional maxima superimposed on original image (I2)')
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = I;
I3(fgm4) = 255;
figure
imshow(I3)
title('Modified regional maxima superimposed on original image (fgm4)')
bw = im2bw(Iobrcbr);
figure
imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')

gradmag2 = imimposemin(gradmag,  fgm4);
L = watershed(gradmag2);

I4 = I;
I4(imdilate(L == 0, ones(3, 3)) |fgm4) = 255;
imshow(I4);
