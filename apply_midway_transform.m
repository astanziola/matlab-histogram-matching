function outimg = apply_midway_transform(img, transform, min_max)
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
    minimum = min_max(1);
    maximum = min_max(2);
    mask = logical(ones(size(img)));
    mask(img < minimum) = false;
    mask(img > maximum) = false;
    masked_img = img(mask);

    pixels_in_mask = int32(masked_img);
    img = int32(img);
    numpix = numel(pixels_in_mask);
    nbins = size(transform,2);
    edges = linspace(minimum, maximum, nbins + 1) - 0.5;
    H = histcounts(pixels_in_mask, edges) ./ numpix;
    H = cumsum(H);

    % Loop trough each pixel
    intensities = unique(img(:));
    outimg = img*0;
    for i = 1:length(intensities)
        I = intensities(i);
        if I < min_max(1) || I > min_max(2)
            outimg(img == I) = I;
        else
            index = I - minimum + 1;
            Hu = int32((nbins-1)*H(index))+1;
            outimg(img == I) = round(transform(Hu)) + minimum;
        end
    end

end