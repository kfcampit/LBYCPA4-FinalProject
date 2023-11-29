%%
% LBYCPA4 - Final Project

%% Convert template characters from jpg to bmp
for i = 0:35
    % Load Image
    filename = strcat(strcat('phfont/',int2str(i)),'.jpg');
    curr_char = imread(filename);
    curr_char = imresize(curr_char, [42 24]);

    % Convert to Grayscale
    curr_char_gray = rgb2gray(curr_char);

    % Convert to Binary 
    curr_char_bin = imbinarize(curr_char_gray);
    
    % Reverse 1 and 0
    curr_char_bin = bwareaopen(~curr_char_bin,64);
    [curr_char_h, curr_char_w] = size(curr_char_bin);

    % Remove outside background
    Iprops = regionprops(curr_char_bin,'BoundingBox','Area', 'Image');
    
    curr_char_bin = imcrop(curr_char_bin, Iprops.BoundingBox);
    curr_char_bin = imresize(curr_char_bin, [42 24]);
    
    figure(i+10);imshow(curr_char_bin);
    
    disp(i);
    if(i<10)
        number{i+1} = curr_char_bin;
    else
        letter{i-9} = curr_char_bin;
    end
end

%% Template Letters (To be compared with the input)
% Alphabets
%A=imread('phfont/10.jpg');
%B=imread('phfont/11.jpg');
%C=imread('phfont/12.jpg');
%D=imread('phfont/13.jpg');
%E=imread('phfont/14.jpg');
%F=imread('phfont/15.jpg');
%G=imread('phfont/16.jpg');
%H=imread('phfont/17.jpg');
%I=imread('phfont/18.jpg');
%J=imread('phfont/19.jpg');
%K=imread('phfont/20.jpg');
%L=imread('phfont/21.jpg');
%M=imread('phfont/22.jpg');
%N=imread('phfont/23.jpg');
%O=imread('phfont/24.jpg');
%P=imread('phfont/25.jpg');
%Q=imread('phfont/26.jpg');
%R=imread('phfont/27.jpg');
%S=imread('phfont/28.jpg');
%T=imread('phfont/29.jpg');
%U=imread('phfont/30.jpg');
%V=imread('phfont/31.jpg');
%W=imread('phfont/32.jpg');
%X=imread('phfont/33.jpg');
%Y=imread('phfont/34.jpg');
%Z=imread('phfont/35.jpg');

% Natural Numbers
%one=imread('phfont/1.jpg');
%two=imread('phfont/2.jpg');
%three=imread('phfont/3.jpg');
%four=imread('phfont/4.jpg');
%five=imread('phfont/5.jpg');
%six=imread('phfont/6.jpg');
%seven=imread('phfont/7.jpg');
%eight=imread('phfont/8.jpg');
%nine=imread('phfont/9.jpg');
%zero=imread('phfont/0.jpg');

% Creating Array for Alphabets
%letter = {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z};

% Creating Array for Numbers
%number = {one two three four five six seven eight nine zero};

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

% Find which objects detected is a license plate based on the sizes of the
% objects
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
% Remove parts of the image that has less than 64 pixels connected with
% each other
im = bwareaopen(~im, 64);
[h, w] = size(im);

figure(1);subplot(3,2,5);imshow(im);
title("Inverted and Reduced License Plate");

im = imerode(im,strel("square",2));
figure(1);subplot(3,2,6);imshow(im);
title("Eroded License Plate");

% Start to extract each number
Iprops = regionprops(im,'BoundingBox','Area', 'Image');

count = 1;
for i=2:numel(Iprops)
    if (Iprops(i).Area>100) && (count<=7)
        iprops_boundingbox(count).Area = Iprops(i).Area;
        iprops_boundingbox(count).BoundingBox = Iprops(i).BoundingBox;
        iprops_boundingbox(count).Image = Iprops(i).Image;
        count = count+1;
    end
end

noPlate=[];

figure(2);
for i=1:numel(iprops_boundingbox)
    let = imcrop(im, iprops_boundingbox(i).BoundingBox);
    let = imresize(let, [42 24]);

    subplot(1,7,i);imshow(let);
    
    rec = [ ];

    if i<=3
        for n=1:length(alphanum(1:26))
            cor = corr2(alphanum{n}, let);
            rec = [rec cor];
        end
        ind = find(rec == max(rec));
    else
        for n=27:36
            cor = corr2(alphanum{n}, let);
            rec = [rec cor];
        end
        ind = find([zeros(1,26) rec] == max([zeros(1,26) rec]));
    end
    
    if ind==1
        letter='A';
    elseif ind==2
        letter='B';
    elseif ind==3
        letter='C';
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

