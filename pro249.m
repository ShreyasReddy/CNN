%Shreyas Srinivasa Reddy%
%ELEN 249 Convalution layer 


%import a image 
Image_rgb = imread('mario.png');

%resize the imported image
Image_rgb = imresize(Image_rgb, [231 231]);
Image_rgb = double(Image_rgb);
figure(1);imshow(uint8(Image_rgb));

%RGB of imported image
Image_red = Image_rgb(:,:,1);
Image_green = Image_rgb(:,:,2);
Image_blue = Image_rgb(:,:,3);
figure(2);imshow(uint8(Image_red));

[row,col] = size(Image_rgb(:,:,1));

%normalizing the image
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
figure(3); imshow(Image_rgb);


%initilizing output feature maps and kernel size 
N = 3; M = 48; R = 55; C = 55; K = 11; S = 4;
output(R,C,M) = 0;
weight = ones(K,K,N,M);


profile on
tic
%please refer to report for explanation of code
for row = 1:R
    for col = 1:C
        for to = 1:M
            for ti = 1:N
                for i = 1:K
                    if mod(i,2)==0
                        for j= K:-1:1
                            output(row,col,to)=output(row,col,to)+(weight(i,j,ti,to).*Image_rgb(((row-1)*S+i),((col-1)*S+j),ti));
                        end
                    else
                        for j=1:K
                            output(row,col,to)=output(row,col,to)+(weight(i,j,ti,to).*Image_rgb(((row-1)*S+i),((col-1)*S+j),ti));
                        end
                    end
                end
            end
        end
    end
end

toc
profile viewer
figure(4);
vl_imarraysc(output);






