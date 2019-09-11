function y = A_fhp_vec(x, OMEGA, m, n)

coeff=sqrt(m*n);
yc = 1/coeff*fft2(reshape(x,m,n));
y = [real(yc(OMEGA)); imag(yc(OMEGA))];
