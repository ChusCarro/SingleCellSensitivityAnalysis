addpath([pwd() '/../src'])

pathToSave = '~/SingleCellSensitivityResults/CRLP_DiffExp';
mainElvira = '~/Software/TestEM/TestEMSingleCellSensitivity_DiffExp20180222/bin/testem_gcc';

param = [1:14];
values =[0.70 0.85 1.15 1.30];
cellType = 15;
cores=4;
dt = 0.002;
step_save=50;
%[s]=rmdir(Model,'s');
Imax = 500;
Istep = 1;
Idur = 0.2;
Cai_ind = 1;

CL = 1000;
nCLs = 100;

SensitivityAnalysis(cores, pathToSave, mainElvira,cellType, param, values, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind)

plotIThresholdLimits(pathToSave)

exit
