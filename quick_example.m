A = double(imread("cameraman.tif"));
B = round(sin(0.5*pi*double(A)/255)*200 + 55);
B(B>255) = 255;
V = {A, B};

% Histogram equalize
[U, H_midway, H, H_inv] = midway_image_eq(V);

% Show results
subplot(2,2,1); imshow(A/255); title("Image 1");
subplot(2,2,2); imshow(B/255); title("Image 2");
subplot(2,2,3); imshow(U{1}/255); title("1 Corrected");
subplot(2,2,4); imshow(U{2}/255); title("2 Corrected");