%Shreyas Srinivasa Reddy%
%ELEN 249 Convalution layer 


W=7;c = [0,0,0];
Image_rgb = imread('mario.png');
%%resizing to input image to 7*7
Image_rgb = imresize(Image_rgb, [W W]);
Image_rgb = double(Image_rgb);
%figure(1);imshow(uint8(Image_rgb));

Image_red = Image_rgb(:,:,1);
Image_green = Image_rgb(:,:,2);
Image_blue = Image_rgb(:,:,3);
%figure(2);imshow(uint8(Image_red));

[row,col] = size(Image_rgb(:,:,1));

for y = 1:row %-->numberof rows in image
   for x = 1:col %-->number of columns in the image
      Red = Image_red(y,x);
      Green = Image_green(y,x);
      Blue = Image_blue(y,x);

    NormalizedRed = Red/sqrt(Red^2 + Green^2 + Blue^2);
    NormalizedGreen = Green/sqrt(Red^2 + Green^2 + Blue^2);
    NormalizedBlue = Blue/sqrt(Red^2 + Green^2 + Blue^2);

    Image_red(y,x) = NormalizedRed;
    Image_green(y,x) = NormalizedGreen;
    Image_blue(y,x) = NormalizedBlue;
   end
end

Image_rgb(:,:,1) = Image_red;
Image_rgb(:,:,2) = Image_green;
Image_rgb(:,:,3) = Image_blue;

Image_rgb = Image_rgb .* Image_rgb;
Image_rgb = Image_rgb .* Image_rgb;
N = 3; M = 1; R = 3; C = 3; K = 3; S = 2;Z=W-K;

%initilizing weigt in a liner array 
weight = ones(1,243);
weight2= ones(K,K,N,M);

%converting input matrix to linear array 7*7 would have 9 kernels with
%srtide of 2 so each kernal is appended to the previous kernel 7*7=49
%with kernel of 3*3 we have 9 elements and 9 kernals 9*9=81 elements
%input image has 3 features, therfore 81*3=234

for a=1:3
    input(:,:,a)=reshape(Image_rgb(:,:,a),[1 W*W]);
    
    %2=stride incremented by 2 9kernels*2=18
    for j=1:2:18
        %each kernel has 3 rows
        for i=0:2
            %K=kernel size Z=lenght of row input matrix - kernel
            b=input(j+(i*(K+Z)):j+(i*(K+Z))+K-1);
            %concatrinate the input to linear array  
            c=horzcat(c,b);
        
        end
    end
end
%i was getting an error so i inizilized [0 0 0] to c 
%now i'm removing it by just eliminating the first 3 elements
input1=c(4:end);

%initilizing output to 0 as linear array
%since we have taken M=1 we just have 3*3 matrix as output 
p=[0 0 0 0 0 0 0 0 0];
output2(R,C,M)=0;



profile on
tic
%calling a function
output=sample5(input1,weight,p);

toc
p = profile('info')

% profile on
% tic
% 
% for row = 1:R
%     for col = 1:C
%         for to = 1:M
%             for ti = 1:N
%                 for i = 1:K
%                     if mod(i,2)==0
%                         for j= K:-1:1
%                             output2(row,col,to)=output2(row,col,to)+(weight2(i,j,ti,to).*Image_rgb(((row-1)*S+i),((col-1)*S+j),ti));
%                         end
%                     else
%                         for j=1:K
%                             output2(row,col,to)=output2(row,col,to)+(weight2(i,j,ti,to).*Image_rgb(((row-1)*S+i),((col-1)*S+j),ti));
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end
% 
% 
% toc
% p = profile('info')

