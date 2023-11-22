function letter=readLetter(snap)

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

%%

snap=imresize(snap,[42 24]);
rec=[ ];

for n=1:length(NewTemplates)
    cor=corr2(NewTemplates{1,n},snap);
    rec=[rec cor];
end

ind=find(rec==max(rec));
display(find(rec==max(rec)));

% Alphabets listings.
if ind==1 || ind==2
    letter='A';
elseif ind==3 || ind==4
    letter='B';
elseif ind==5
    letter='C'
elseif ind==6 || ind==7
    letter='D';
elseif ind==8
    letter='E';
elseif ind==9
    letter='F';
elseif ind==10
    letter='G';
elseif ind==11
    letter='H';
elseif ind==12
    letter='I';
elseif ind==13
    letter='J';
elseif ind==14
    letter='K';
elseif ind==15
    letter='L';
elseif ind==16
    letter='M';
elseif ind==17
    letter='N';
elseif ind==18 || ind==19
    letter='O';
elseif ind==20 || ind==21
    letter='P';
elseif ind==22 || ind==23
    letter='Q';
elseif ind==24 || ind==25
    letter='R';
elseif ind==26
    letter='S';
elseif ind==27
    letter='T';
elseif ind==28
    letter='U';
elseif ind==29
    letter='V';
elseif ind==30
    letter='W';
elseif ind==31
    letter='X';
elseif ind==32
    letter='Y';
elseif ind==33
    letter='Z';
elseif ind==34
    letter='1';
elseif ind==35
    letter='2';
elseif ind==36
    letter='3';
elseif ind==37 || ind==38
    letter='4';
elseif ind==39
    letter='5';
elseif ind==40 || ind==41 || ind==42
    letter='6';
elseif ind==43
    letter='7';
elseif ind==44 || ind==45
    letter='8';
elseif ind==46 || ind==47 || ind==48
    letter='9';
else
    letter='0';
end
end