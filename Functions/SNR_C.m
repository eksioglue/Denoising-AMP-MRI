%% Reconstruction SNR Matlab Function
%% Written by Eksioglu and Tanc on May 23, 2018

function [SNR] = SNR_C(x_t,x_0)

[imheight, imwidth]=size(x_t);
MSE = sum(sum( (abs(x_t-x_0)).^2 ))/(imheight*imwidth);
SNR = 10*log10(1^2/MSE);

end

