function outimg = apply_midway_transform(img, transform)
% Apply a midway transform to an image.
%
% Inputs:
%   img: the image to transform
%   transform: the midway transform to apply
%
% Outputs:
%   outimg: the transformed image
%

    % get the histogram of the input image
    numpix = size(img, 1) * size(img, 2);
    nbins = size(transform,2);
    edges = linspace(0, 256, nbins + 1) - 0.5;
    H = histcounts(img, edges) ./ numpix;
    H = cumsum(H);

    % Loop trough each pixel
    intensities = unique(img(:));
    outimg = img*0;
    for i = 1:length(intensities)
        I = intensities(i);
        Hu = round(255*H(I+1))+1;
        outimg(img == I) = round(transform(Hu));
    end

end