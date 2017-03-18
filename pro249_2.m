%Shreyas Srinivasa Reddy%
%ELEN 249 Convalution layer 



Image_rgb = imread('mario.png');
Image_rgb = imresize(Image_rgb, [231 231]);
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

%figure(3); imshow(Image_rgb);
%intializing size of output feature map,weights,stride and size of kernel
N = 3; M = 48; R = 55; C = 55; K = 11;S = 4; Tr = 4; Tc = 4; Tm = 4; Tn=3;
output(R,C,M) = 0;
weight = ones(K,K,N,M);




tic
for row = 0:Tr:R-1
    for col= 0:Tc:C-1 
        for to =0:Tm:M-1 
            for ti =0:Tn:N-1
                output1=output(1:end,1:end,1:end);
                input1=Image_rgb(1:end,1:end,1:end,1:end);
                weight = ones(K,K,N,M);
                for trr = row+1:min(row+Tr,R)
                    for tcc = col+1:min(col+Tc,C)
                        for too = to+1:min(to+Tm,M)
                            for tii = ti+1:min(ti+Tn,N)
                                for i = 1:K
                                    if mod(i,2)==0
                                        for j=K:-1:1
                                            output1(trr,tcc,too)=output1(trr,tcc,too)+(weight(i,j,tii,too).*input1(((trr-1)*S+i),((tcc-1)*S+j),tii));
                                        end
                                    else
                                        for j=1:K
                                            output1(trr,tcc,too)=output1(trr,tcc,too)+(weight(i,j,tii,too).*input1(((trr-1)*S+i),((tcc-1)*S+j),tii));
                                        end 
                                    end
                                end
                            end
                        end
                    end
                end
                output=output1;    
            end
        end
    end
end

toc
figure(4);
vl_imarraysc(output);
