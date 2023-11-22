%%
% LBYCPA4 - Final Project

%% Template Letters
% Alphabets
A=imread('alpha/A.bmp');
B=imread('alpha/B.bmp');
C=imread('alpha/C.bmp');
D=imread('alpha/D.bmp');
E=imread('alpha/E.bmp');
F=imread('alpha/F.bmp');
G=imread('alpha/G.bmp');
H=imread('alpha/H.bmp');
I=imread('alpha/I.bmp');
J=imread('alpha/J.bmp');
K=imread('alpha/K.bmp');
L=imread('alpha/L.bmp');
M=imread('alpha/M.bmp');
N=imread('alpha/N.bmp');
O=imread('alpha/O.bmp');
P=imread('alpha/P.bmp');
Q=imread('alpha/Q.bmp');
R=imread('alpha/R.bmp');
S=imread('alpha/S.bmp');
T=imread('alpha/T.bmp');
U=imread('alpha/U.bmp');
V=imread('alpha/V.bmp');
W=imread('alpha/W.bmp');
X=imread('alpha/X.bmp');
Y=imread('alpha/Y.bmp');
Z=imread('alpha/Z.bmp');

% Natural Numbers
one=imread('alpha/1.bmp');
two=imread('alpha/2.bmp');
three=imread('alpha/3.bmp');
four=imread('alpha/4.bmp');
five=imread('alpha/5.bmp');
six=imread('alpha/6.bmp');
seven=imread('alpha/7.bmp');
eight=imread('alpha/8.bmp');
nine=imread('alpha/9.bmp');
zero=imread('alpha/0.bmp');

% Creating Array for Alphabets
letter = {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z};

% Creating Array for Numbers
number = {one two three four five six seven eight nine zero};

alphanum = [letter number];

%% Load Image
fileName = "testlp2.jpg";
im = imread(fileName);
im = imresize(im, [512 512]);

figure(1);subplot(3,2,1);imshow(im);
title("Original RGB Image")

%% Extract Rectangular License Plate
% Convert to Grayscale
imgray = rgb2gray(im);
figure(1);subplot(3,2,2);imshow(imgray);
title("Grayscale Image")

% Apply Gaussian Blur
imgauss = imgaussfilt(imgray,0.1);

% Convert to Binary 
imbin = imbinarize(imgauss, 0.5);
figure(1);subplot(3,2,3);imshow(imbin);
title("Binary Image")

Iprops=regionprops(imbin,'BoundingBox','Area', 'Image');
maxa = Iprops.Area;
count = numel(Iprops);
boundingBox = Iprops.BoundingBox;

for i=1:count
   if (maxa < Iprops(i).Area && ...
           ((Iprops(i).BoundingBox(3) > 2.5*Iprops(i).BoundingBox(4)) && ...
           (Iprops(i).BoundingBox(3) < 3*Iprops(i).BoundingBox(4))))
        maxa=Iprops(i).Area;
        boundingBox=Iprops(i).BoundingBox;
   end
end   

im = imcrop(imbin, boundingBox);
figure(1);subplot(3,2,4);imshow(im);
title("Extracted License Plate");

%% Character Extraction
im = bwareaopen(~im, 64);
[h, w] = size(im);

im = imerode(im,strel("square",2));
figure(1);subplot(3,2,5);imshow(im);
title("Eroded License Plate");

figure(1);subplot(3,2,6);imshow(im);
title("Inverted and Reduced License Plate")

Iprops = regionprops(im,'BoundingBox','Area', 'Image');

count = numel(Iprops);
noPlate=[];

figure(2);

for i=2:count
    let = imcrop(im, Iprops(i).BoundingBox);
    let = imresize(let, [42 24]);

    subplot(1,7,i-1);imshow(let);
    
    rec = [ ];

    for n=1:length(alphanum)
        cor = corr2(alphanum{n}, let);
        rec = [rec cor];
    end

    ind = find(rec == max(rec));
    
    if ind==1
        letter='A';
    elseif ind==2
        letter='B';
    elseif ind==3
        letter='C'
    elseif ind==4
        letter='D';
    elseif ind==5
        letter='E';
    elseif ind==6
        letter='F';
    elseif ind==7
        letter='G';
    elseif ind==8
        letter='H';
    elseif ind==9
        letter='I';
    elseif ind==10
        letter='J';
    elseif ind==11
        letter='K';
    elseif ind==12
        letter='L';
    elseif ind==13
        letter='M';
    elseif ind==14
        letter='N';
    elseif ind==15
        letter='O';
    elseif ind==16
        letter='P';
    elseif ind==17
        letter='Q';
    elseif ind==18
        letter='R';
    elseif ind==19
        letter='S';
    elseif ind==20
        letter='T';
    elseif ind==21
        letter='U';
    elseif ind==22
        letter='V';
    elseif ind==23
        letter='W';
    elseif ind==24
        letter='X';
    elseif ind==25
        letter='Y';
    elseif ind==26
        letter='Z';
    elseif ind==27
        letter='1';
    elseif ind==28
        letter='2';
    elseif ind==29
        letter='3';
    elseif ind==30
        letter='4';
    elseif ind==31
        letter='5';
    elseif ind==32
        letter='6';
    elseif ind==33
        letter='7';
    elseif ind==34
        letter='8';
    elseif ind==35
        letter='9';
    else
        letter='0';
    end
    noPlate = [noPlate letter]
end

noPlate

