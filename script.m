%-Coregistration with SPM12
%-----------------------------------------------------------

wd = '/home/jovyan';

addpath(fullfile(wd,'src'));

cd(fullfile(wd,'data'));

%-Input data
ref = fullfile(wd,'data','T1w.nii');
src = fullfile(wd,'data','bold.nii');

%-Reslice (for display...)
spm_reslice({ref,src}, struct('mean',false,'which',1));

%-Coregister
x = spm_coreg(ref, src);

%-Save transformation in NIfTI header
X  = spm_matrix(x);
M = spm_get_space(src);
spm_get_space(src, X\M);

%-Reslice
spm_reslice({ref,src}, struct('mean',false,'which',1));
