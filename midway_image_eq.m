function [U, H_midway, H, H_inv] = midway_image_eq(V)
% Implementation of the Midway Equalization algorithm
% as described in Algorithm 1 of the paper:
%   Thierry Guillemot, and Julie Delon, 
%   Implementation of the Midway Image Equalization, 
%   Image Processing On Line, 6 (2016), pp. 114–129. 
%   https://doi.org/10.5201/ipol.2016.140
%
% Input:
%   V: collection of input images as a cell array
%
% Output:
%   U: collection of equalized images as a cell array
%   H_midway: midway histogram 
%   H: histogram of the input images
%   H_inv: inverse of H
%
% Author:
%   Antonio Stanziola; Biomedical Ultrasound Group, UCL

% Warning:
%   This implementation assumes that the cumulative
%   histograms aree never zero at any bin

nbins = 256;

% Compute the histogram of each image and store it
h = cell(1, length(V));
edges = linspace(0, 256, nbins + 1) - 0.5;
for i = 1:length(V)
    numpix = size(V{i}, 1) * size(V{i}, 2);
    h{i} = histcounts(V{i}, edges);
    h{i} = h{i}/numpix;
end

% Computes the cumulative histograms
H = cell(1, length(V));
for i = 1:length(V)
    H{i} = cumsum(h{i});
end

% Find the inverse function of each histogram
H_inv = cell(1, length(V));
for i = 1:length(V)
    H_inv{i} = inverse_histogram(H{1}, nbins);
end

% Compute the midway histogram as the harmonic mean of
% the cumulative histograms
H_midway = H{1}*0;
for i = 1:length(V)
    H_midway = H_midway + H_inv{i};
end
H_midway = H_midway/length(V);

% Applies the inverse transform to each pixel of each image
U = cell(1, length(V));
for i = 1:length(V)
    U{i} = apply_midway_transform(V{i}, H_midway);
end

end