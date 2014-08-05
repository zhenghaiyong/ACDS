function th=size_otsu(sizes,max_size)

sizes2=sort(sizes);
sizes3=255*(sizes2-min(sizes2))/(max(sizes2)-min(sizes2));
sizes4=uint8(sizes3);
num_bins = 256;
counts = imhist(sizes4);
p = counts / sum(counts);
omega = cumsum(p);
mu = cumsum(p .* (1:num_bins)');
mu_t = mu(end); 

%  p = sizes / sum(sizes);
%  omega = cumsum(p);
%  mu = cumsum(p .* (1:num)');
%  mu_t = mu(end);

sigma_b_squared = (mu_t * omega - mu).^2 ./ (omega .* (1 - omega));

% Find the location of the maximum value of sigma_b_squared.
% The maximum may extend over several bins, so average together the
% locations.  If maxval is NaN, meaning that sigma_b_squared is all NaN,
% then return 0.
maxval = max(sigma_b_squared);
isfinite_maxval = isfinite(maxval);
if isfinite_maxval
    idx = mean(find(sigma_b_squared == maxval));
    % Normalize the threshold to the range [0, 1].
    level = (idx - 1) / (max_size - 1);
else
    level = 0.0;
end
th=max_size*level;
