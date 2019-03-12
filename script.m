
wd = '/home/jovyan';
addpath(fullfile(wd,'src'));
cd(fullfile(wd,'data'));

%-Input data
ref = fullfile(wd,'data','T1w.nii');
src = fullfile(wd,'data','bold.nii');

%-Reslice (for display...)
spm_reslice({ref,src}, struct('mean',false,'which',1));

A = spm_slice_vol(spm_vol('T1w.nii'),spm_matrix([0 0 80]),[99 134],1);
F = spm_slice_vol(spm_vol('rbold.nii'),spm_matrix([0 0 80]),[99 134],1);
subplot(1,2,1),imagesc(rot90(A)),axis equal,axis tight,subplot(1,2,2),imagesc(rot90(F)),axis equal, axis tight

%-Coregister
x = spm_coreg(ref, src);

%-Save transformation in NIfTI header
X  = spm_matrix(x);
M = spm_get_space(src);
spm_get_space(src, X\M);

%-Reslice
spm_reslice({ref,src}, struct('mean',false,'which',1));

A = spm_slice_vol(spm_vol('T1w.nii'),spm_matrix([0 0 80]),[99 134],1);
F = spm_slice_vol(spm_vol('rbold.nii'),spm_matrix([0 0 80]),[99 134],1);
subplot(1,2,1),imagesc(rot90(A)),axis equal,axis tight,subplot(1,2,2),imagesc(rot90(F)),axis equal, axis tight
