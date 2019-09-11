Toolbox for BM3D-AMP-MRI algorithm; version 1.0 (August, 2018)

A toolbox for MRI reconstruction based on Denoising-AMP

If you utilize this code, please cite the related paper [1]: 

E.M. Eksioglu, A. K. Tanc, "Denoising AMP for MRI Reconstruction: BM3D-AMP-MRI", accepted for publication in "SIAM Journal on Imaging Sciences", DOI: 10.1137/18M1169655.

The folder "BM3D_AMP_MRI" contains all the functions and sample data necessary for demonstrating the BM3D-AMP-MRI algorithm for MRI reconstruction as introduced in [1]. 

* BM3D_AMP_MRI_Demo.m is the main demo file.
    
* The folder "Data" contains samples for real-valued and complex-valued MR images and an example sampling mask.

* The folder "Functions" contains the necessary subfunctions:

	- "DAMP_CMRI.p" realizes the BM3D-AMP-MRI algorithm as introduced in [1].

	- "BM3D_CMRI.p" realizes the BM3D-MRI algorithm as introduced in [2] (or equivalently the BM3D-IT-MRI algorithm from [1]) for the case of possibly complex-valued MR data.

	- "bm3d_thr_color.mexw64" and "bm3d_thr_color.mexmaci64" realize the BM3D denoising algorithm [3] for 64-bit Windows and Mac platforms, respectively.

	- "A_fhp_vec.m" and "At_fhp_vec.m" realize the MR forward operator and its adjoint operator, respectively.

	- "SNR_c.m" calculates the MRI reconstruction SNR.

REFERENCES: 
[1] E.M. Eksioglu, A. K. Tanc, “Denoising AMP for MRI Reconstruction: BM3D-AMP-MRI”, SIAM Journal on Imaging Sciences, vol. 11, no. 3, pp. 2090-2109, September 2018. DOI: 10.1137/18M1169655

[2] E.M. Eksioglu, "Decoupled Algorithm for MRI Reconstruction Using Nonlocal Block Matching Model: BM3D-MRI", Journal of Mathematical Imaging and Vision, vol. 56, no. 3, pp. 430-440, November 2016.

[3] K. Dabov, A. Foi, V. Katkovnik and K. Egiazarian, "Image Denoising by Sparse 3-D Transform-Domain Collaborative Filtering," in IEEE Transactions on Image Processing, vol. 16, no. 8, pp. 2080-2095, Aug. 2007.
    
