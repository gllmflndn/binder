%-Coregistration with SPM12
%-----------------------------------------------------------

wd = '/home/gflandin/github/binder/';

addpath(fullfile(wd,'src'));

%-Input data
ref = fullfile(wd,'data','T1w.nii');
src = fullfile(wd,'data','bold.nii');

%-Display original data
spm_figure('Create','Graphics','Coregistration','off');
spm_check_registration(ref, src);
spm_ov_contour('Display', 1, 2);
spm_print('coregister.png', NaN, 'png');

%-Coregister
x = spm_coreg(ref, src);

%-Save transformation in NIfTI header
X  = spm_matrix(x);
M = spm_get_space(src);
spm_get_space(src, X\M);

%-Reslice
spm_reslice({ref,src}, struct('mean',false,'which',1));

%-Display coregistered data
spm_check_registration(ref, src);
spm_ov_contour('Display', 1, 2);
spm_print('coregister.png', NaN, 'png');
