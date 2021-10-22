% Load and transform test image
A = double(imread("cameraman.tif"));
B = round(A/3 + 10);
C = round(sin(0.5*pi*double(A)/255)*255);
V = {A, B ,C};

% Histogram equalize
[U, H_midway, H, H_inv] = midway_image_eq(V);

% Show images
figure;
subplot(4,3,1); imshow(A/255); title("Original");
subplot(4,3,2); imshow(B/255); title("Scaled");
subplot(4,3,3); imshow(C/255); title("Sinusoidal");
subplot(4,3,4); imshow(U{1}/255); title("Midway");
subplot(4,3,5); imshow(U{2}/255); title("Midway");
subplot(4,3,6); imshow(U{3}/255); title("Midway");
subplot(4,3,7); histogram(U{1}); title("Original");
subplot(4,3,8); histogram(U{2}); title("Scaled");
subplot(4,3,9); histogram(U{3}); title("Sinusoidal");
subplot(4,3,10); histogram(A);
subplot(4,3,11); histogram(B);
subplot(4,3,12); histogram(C);

