bw=imread('C:\Users\Lenovo\Desktop\da2.jpg');
bw=im2bw(bw);
L = bwlabel(bw, 4);
feature = regionprops(L,'area');
sum(cell2mat(struct2cell(feature)))
 feature = regionprops(L,'perimeter');
sum(cell2mat(struct2cell(feature)))