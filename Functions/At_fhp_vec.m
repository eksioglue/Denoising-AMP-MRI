function x = At_fhp_vec(y, OMEGA, m, n)

K = length(y);

coeff=sqrt(m*n);

fx = zeros(m,n);
fx(OMEGA) = (y(1:K/2) + 1i*y((1+K/2):K));
x = (reshape(coeff*ifft2(fx),m*n,1));
